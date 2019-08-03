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

package com.xst.golddata.model

import com.xst.golddata.utils.I18nUtils
import com.xst.golddata.vo.CommonStatusVO
import com.xst.golddata.vo.GenderVO
import grails.gorm.annotation.Entity


@Entity
class UserInfo {

    String email
    String phone
    String nickname
    String avator
    Integer gender
    String pass
    Integer salt
    Date dateBirth
    Integer status
    Date dateCreated

    static mapping = {
    }

    static constraints = {
        email nullable:true
        phone nullable:true
        nickname nullable:true
        avator nullable:true
        gender nullable:true
        pass nullable:true
        salt nullable:true
        dateBirth nullable:true
        status nullable:true
        dateCreated nullable:true
    }

    def getStatusLabel(){

        return getStatusVO().label
    }

    def getStatusVO(){
        return  CommonStatusVO.get(status?:0)
    }

    def getGenderLabel(){
        return getGenderVO().label
    }

    def getGenderVO(){
        return GenderVO.get(gender?:0)
    }


}
