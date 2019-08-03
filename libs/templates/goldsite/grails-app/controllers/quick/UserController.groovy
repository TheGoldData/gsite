/*
 *  Copyright 2016-2019 新商态（北京）科技有限公司
 *
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 */

package quick

import com.fasterxml.jackson.databind.ObjectMapper
import com.xst.golddata.ImageHolder
import com.xst.golddata.ThreadManager
import com.xst.golddata.common.utils.AvatorUtils
import com.xst.golddata.common.utils.VCodeUtils
import com.xst.golddata.controllers.ControllerAssistant
import com.xst.golddata.model.IpLogDaily
import com.xst.golddata.model.UserInfo
import com.xst.golddata.utils.AESUtils
import com.xst.golddata.utils.EncryptUtils
import com.xst.golddata.utils.I18nUtils
import com.xst.golddata.vo.CommonStatusVO
import groovy.text.SimpleTemplateEngine
import org.apache.commons.net.util.Base64
import quick.command.user.*

import javax.imageio.ImageIO
import javax.servlet.http.Cookie
import java.awt.image.BufferedImage
import java.sql.Timestamp
import java.time.LocalDate

/*
 * Created by wdg100 on 19/7/7
 */

class UserController implements ControllerAssistant{
    ThemeService themeService
    SettingService settingService
    MailService mailService

    ImageHolder imageHolder
    def proto(){
        render(view:'/userProto',model: [:]);
    }
    def signIn(){
        String returnUrl=params.returnUrl
        if(returnUrl){
            request.session.setAttribute('returnUrl',returnUrl)
        }
        render (view:"/signInUp",model:[prefer: 'signIn',needVCode:isNeedVCode()])
    }
    private boolean  isNeedVCode(){
        IpLogDaily log=getIpTodayLoginLog()
        boolean needValid=false;
        if(log && 'fail'.equals(log.note)){
            needValid=true
        }
        return needValid
    }
    private IpLogDaily getIpTodayLoginLog(){
        Date today= Timestamp.valueOf(LocalDate.now().atStartOfDay())
        String userIP=request.getAttribute('$ip')
        return IpLogDaily.where{ dateCreated > today && ip==userIP && path=='/user/login' }.find()
    }

    private void addFailedRecord(){
        String userIP=request.getAttribute('$ip')
        IpLogDaily todayDaily=getIpTodayLoginLog();
        if(!todayDaily){
           todayDaily=new IpLogDaily()
        }
        todayDaily.setIp(userIP)
        todayDaily.setUa(request.getAttribute('$ua') as String)
        todayDaily.note='fail'
        todayDaily.path='/user/login'
        todayDaily.save(flush:true);

    }
    private void addSuccessRecord() {
        String userIP=request.getAttribute('$ip')
        IpLogDaily todayDaily=getIpTodayLoginLog();
        if(!todayDaily){
            todayDaily=new IpLogDaily()
            todayDaily.path='/user/login'
        }
        todayDaily.setIp(userIP)
        todayDaily.setUa(request.getAttribute('$ua') as String)
        todayDaily.note=null
        todayDaily.save(flush:true);
    }

    def signUp(){
        String returnUrl=params.returnUrl
        if(returnUrl){
            request.session.setAttribute('returnUrl',returnUrl)
        }
        render(view:"/signInUp",model: [ prefer:'signUp',needVCode:isNeedVCode()])
    }

    def login(UserLoginCommand cmd){
        valid(cmd)
        if(isNeedVCode()){
            String sessCode=request.session.getAttribute('validateCode');
            if(!cmd.vcode ||  !cmd.vcode.equalsIgnoreCase(sessCode )){
                renderCode('error.login.vcode')
                return Void
            }
        }

        UserInfo u=UserInfo.findByEmail(cmd.email)

        if(u==null){
            addFailedRecord();
            renderCode('error.login.nouser')
            return Void
        }else{
            if(u.status==CommonStatusVO.DISABLE.value){
                addFailedRecord();
                renderCode('error.login.prohibit')
                return Void
            }

            String encpass=EncryptUtils.hashPassword(cmd.pass,u.salt)
            if(!encpass.equals(u.pass)){
                //set enormal state
                addFailedRecord();
                renderCode('error.login.pass')
                return Void
            }
            //correct,
            //set normal state
            addSuccessRecord()
            //set session
            String returnUrl=settingService.getSettingVal('login.welcomeUrl',true,'/');
            String sessReturn=request.session.getAttribute('returnUrl')
            if(sessReturn){
                returnUrl=sessReturn;
            }
            request.session.invalidate();

            request.session.setAttribute('$user',u)

            if(cmd.rememberMe==1){//记住我
                String key=u.pass.substring(0,16)
                String text=AESUtils.encrypt(key,u.id+'');
                String ss=new ObjectMapper().writeValueAsString([id:u.id,text:text]);
                Cookie rem=new Cookie('$rememberMe',Base64.encodeBase64String(ss.getBytes('utf-8')).trim())
                rem.setPath('/')
                rem.setMaxAge(3600*24*14);
                response.addCookie(rem)
            }else{
                exitOnCookie()
            }

            //retrieve returnUrl
            renderOk([returnUrl:returnUrl])
            return Void
        }
    }
    private void exitOnCookie(){

        //cookie exit
        Cookie rem=new Cookie('$rememberMe','')
        rem.setPath('/')
        rem.setMaxAge(0)
        response.addCookie(rem)
    }
    def logout(){
        String returnUrl=settingService.getSettingVal('login.exitUrl',true,'/');
        String sessReturn=request.session.getAttribute('returnUrl')
        if(sessReturn){
            returnUrl=sessReturn;
        }
        request.session.invalidate();
        exitOnCookie()
        renderOk([returnUrl: returnUrl]);
        return Void

    }

    def register(UserRegisterCommand cmd){
        valid(cmd)
        Map registerCode=request.session.getAttribute('$registerCode') as Map
        if(!cmd.vcode || !cmd.vcode.equalsIgnoreCase(registerCode?.vcode) || !cmd.email.equals(registerCode?.email)){
            renderCode('error.vcode.register')
            return Void
        }
        request.session.removeAttribute('$registerCode')

        UserInfo entity=new UserInfo()
        entity.nickname=cmd.nickname
        entity.email=cmd.email
        entity.salt=new Random().nextInt(100)
        entity.pass=EncryptUtils.hashPassword(cmd.pass,entity.salt)
        entity.status=CommonStatusVO.AVAILBLE.value
        BufferedImage img=AvatorUtils.gen(cmd.nickname,100,100);
        ByteArrayOutputStream bos=new ByteArrayOutputStream()
        ImageIO.write(img,'PNG',bos)
        String path='/Image/avators/'+UUID.randomUUID().toString().replace('-','')+".png"
        imageHolder.save(bos.toByteArray(),path)
        entity.avator=imageHolder.encodeFullUrl(path);
        entity.save()
        String msg=I18nUtils.getMessage('ok.register')
        renderOk([message:msg]);
    }

    def sendEmailForRegister(SendEmailRegisterCommand cmd){
        if(UserInfo.findByEmail(cmd.email.trim())){
            renderCode('error.register.existMail')
            return Void
        }
        String tpl=settingService.getSettingVal('mail.register',false,'')

        String contentTpl=I18nUtils.getMessage(tpl,tpl)
        String siteName=I18nUtils.getMessage('goldsite.siteName',servletContext.getAttribute('$siteName'))


        StringWriter sw=new StringWriter()
        String vcode=VCodeUtils.genVCode2()
        request.session.setAttribute('$registerCode',[email:cmd.email,vcode:  vcode])

        new SimpleTemplateEngine().createTemplate(new StringReader(contentTpl)).make([vcode:vcode,sitename:siteName]).writeTo(sw)
        String mailContent=sw.toString()
        ThreadManager.exec({
            def ret=mailService.send(cmd.email,mailContent,mailContent);
            if(!ret.status){
                logger.warn('Error to send email for register:{},{},cause:{}',cmd.email,mailContent,ret.message)
            }
        })

        renderOk([message:I18nUtils.getMessage('goldsite.mail.vcode')])

    }

    def sendEmailForForgot(SendEmailForgotCommand cmd){
        if(!UserInfo.findByEmail(cmd.email)){
            renderCode('error.forgot.unregister')
            return Void
        }
        String tpl=settingService.getSettingVal('mail.register',false,'')
        String contentTpl=I18nUtils.getMessage(tpl,tpl)
        String siteName=I18nUtils.getMessage('goldsite.siteName',servletContext.getAttribute('$siteName'))

        StringWriter sw=new StringWriter()
        String vcode=VCodeUtils.genVCode2()
        request.session.setAttribute('$forgotCode',[email:cmd.email,vcode:  vcode])
        new SimpleTemplateEngine().createTemplate(new StringReader(contentTpl)).make([vcode:vcode,sitename:siteName]).writeTo(sw)
        String mailContent=sw.toString()
        ThreadManager.exec({
            def ret=mailService.send(cmd.email,mailContent,mailContent);
            if(!ret.status){
                logger.warn('Error to send email for forgot:{},{},cause:{}',cmd.email,mailContent,ret.message)
            }
        })
        renderOk([message:I18nUtils.getMessage('goldsite.mail.vcode')])
    }

    def forgot(UserForgotCommand cmd){
        valid(cmd)
        Map forgotCode=request.session.getAttribute('$forgotCode') as Map
        if(!cmd.vcode || !cmd.vcode.equalsIgnoreCase(forgotCode?.vcode) || !cmd.email.equals(forgotCode?.email)){
            renderCode('error.vcode.forgot')
            return  Void
        }
        request.session.removeAttribute('$forgotCode')
        UserInfo entity=UserInfo.findByEmail(cmd.email)

        entity.salt=new Random().nextInt(100)
        entity.pass=EncryptUtils.hashPassword(cmd.pass,entity.salt)
        entity.save(flush: true)
        String msg=I18nUtils.getMessage('ok.forgot')

        renderOk([message:msg]);
    }

}
