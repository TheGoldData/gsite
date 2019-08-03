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

package quick.command.user

import grails.validation.Validateable

/*
 * Created by wdg100 on 19/7/7
 */

class UserLoginCommand implements Validateable{

    String email
    String pass
    String vcode
    Integer rememberMe
    static constraints = {
        email nullable: false,blank: false
        vcode nullable: true
        pass nullable: false,minSize: 6
        rememberMe nullable: true
    }
}
