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

import com.xst.golddata.vo.CommonStatusVO
import com.xst.golddata.vo.GenderVO
import grails.gorm.annotation.Entity

@Entity
class UserSite {

    UserInfo user
    Site site
    Long providerId
    Date lastUpdated


    static mapping = {
    }

    static constraints = {
        user nullable:true
        site nullable:true
        providerId nullable:true
        lastUpdated nullable:true
    }

}
