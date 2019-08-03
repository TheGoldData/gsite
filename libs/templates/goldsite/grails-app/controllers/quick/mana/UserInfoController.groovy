/*
 * Copyright 2016-2019 新商态（北京）科技有限公司
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package quick.mana

import com.xst.golddata.command.Pageable
import com.xst.golddata.controllers.ControllerAssistantWithSecBase
import com.xst.golddata.model.UserInfo
import com.xst.golddata.utils.AuditLogger
import com.xst.golddata.vo.AuditTypeVO
import com.xst.golddata.vo.ModuleVO
import quick.mana.command.userInfo.ListUserInfoCommand

/*
 * Created by wdg100 on 2019/4/23
 */

class UserInfoController implements ControllerAssistantWithSecBase{

    static namespace = "mana"

    def index (){

    }

    def list(ListUserInfoCommand cmd){
        valid(cmd)
        String col=params["mDataProp_${params['iSortCol_0']}"]
        String order=params['sSortDir_0']
        if('statusLabel'.equals(col)){
            col='status'
        }
        if('genderLabel'.equals(col)){
            col='gender'
        }

        def page = UserInfo.createCriteria().list (max: cmd.pageSize(), offset: cmd.pageFirst(),sort:col,order:order){
            if(cmd.email!=null){
                like('email','%'+cmd.email+'%')
            }

            if(cmd.phone){
                like('phone','%'+cmd.phone+'%')
            }
            if(cmd.nickname){
                like('nickname','%'+cmd.nickname+'%')
            }
            if(cmd.regStart){
                gt('dateCreated',cmd.regStart)
            }
            if(cmd.regEnd){
                lt('dateCreated',cmd.regEnd)
            }
        }
        def ret = []
        page.each {
            def c = [:]
            c.putAll(it.properties);
            c.id = it.id;
            ret << c;
        }

        renderPageTable(cmd.asPageable() as Pageable,page.totalCount as Long ,ret as List)
    }






    def updateStatus(){
        Long id=params.long('id');
        UserInfo entity=UserInfo.get(id)
        if(entity.status==1){
            entity.status=0
        }else{
            entity.status=1;
        }
        entity.save(flush:true)
        AuditLogger.log(ModuleVO.TABLE,AuditTypeVO.UPDATE,id+":status:user_info");
        renderOk();
    }



}
