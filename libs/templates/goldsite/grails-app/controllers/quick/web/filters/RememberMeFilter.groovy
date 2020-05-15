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

package quick.web.filters

import com.fasterxml.jackson.databind.ObjectMapper
import com.xst.golddata.common.utils.ObjectUtils
import com.xst.golddata.model.UserInfo
import com.xst.golddata.utils.AESUtils
import com.xst.golddata.vo.CommonStatusVO
import org.apache.commons.net.util.Base64

import javax.servlet.*
import javax.servlet.http.Cookie
import javax.servlet.http.HttpServletRequest
import javax.servlet.http.HttpSession

/*
 * Created by wdg100 on 19/7/7
 */

class RememberMeFilter implements Filter {

    @Override
    void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest httpRequest=request as HttpServletRequest
        HttpSession session=httpRequest.getSession(false)
        if(!(session?.getAttribute('$user'))){//没有登录
            for(Cookie cookie:httpRequest.getCookies()){
                if('$rememberMe'.equals(cookie.getName()) && cookie.getValue() ){//
                    if(!httpRequest.requestURI.startsWith('/mana/')){// when it's not the uri which starts with '/mana/'
                        String s=new String(Base64.decodeBase64(cookie.value),'utf-8')
                        Map map=new ObjectMapper().readValue(s,Map.class)
                        Long userId=map.id
                        UserInfo u=null
                        UserInfo.withTransaction{
                            u=UserInfo.where{id==userId && status==CommonStatusVO.AVAILBLE.value}.find()
                        }
                        if(u){
                            String key=u.pass.substring(0,16)
                            if(AESUtils.encrypt(key,userId+'').equals(map.text)){ // they equals.
                                httpRequest.session.setAttribute('$user',ObjectUtils.toMap(u));

                            }
                        }
                    }
                    break;
                }
            }
        }
        chain.doFilter(request,response)
    }

    @Override
    void destroy() {

    }
}
