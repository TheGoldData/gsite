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

package quick.mana.command.userInfo

import com.xst.golddata.command.BaseCommand

/*
 * Created by wdg100 on 2019/5/24
 */

class ListUserInfoCommand extends BaseCommand{
    String email
    String phone
    String nickname

    Date regStart
    Date regEnd


    static constraints = {
        email nullable:true
        phone nullable:true
        nickname nullable:true
        regStart nullable:true
        regEnd nullable:true
    }

}
