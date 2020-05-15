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

package quick

import com.xst.golddata.common.utils.VCodeUtils
import grails.converters.JSON
import org.springframework.http.HttpStatus

import javax.imageio.ImageIO
import javax.servlet.ServletOutputStream

class GeneralController {

    def vcode() {

        def code= VCodeUtils.genVCode()
        session.setAttribute("validateCode",code.code)

        // 禁止图像缓存。
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setDateHeader("Expires", 0);

        response.setContentType("image/jpeg");

        // 将图像输出到Servlet输出流中。
        ServletOutputStream sos = response.getOutputStream();
        ImageIO.write(code.img, "jpeg", sos);
        sos.flush();
        sos.close();
    }
    def set(){
        if (grails.util.Environment.current == grails.util.Environment.DEVELOPMENT) {
            request.session.setAttribute('$domain',params._domain);
            render ([status: 200] as JSON)
        }
        else{
            response.sendError(HttpStatus.NOT_FOUND.value())
        }
    }
}
