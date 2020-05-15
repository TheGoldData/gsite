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

import com.xst.golddata.ImageHolder
import com.xst.golddata.command.FileUploadCommand
import com.xst.golddata.controllers.ControllerAssistant
import grails.converters.JSON
import org.apache.commons.io.FilenameUtils

/*
 * Created by wdg100 on 19/7/16
 */

class UploadController implements ControllerAssistant {


    ImageHolder imageHolder;

    def upload(FileUploadCommand cmd){
        Map u=request.session.getAttribute('$user')
        if(u==null){//如果没有登录。
            response.setStatus(403);
            response.flushBuffer()
            return Void
        }
        String folder = params.get("folder")
        folder=folder?:(u.id+'')
        String fileName=cmd?.upload?.originalFilename;
        String ext=FilenameUtils.getExtension(fileName)
        String baseName=FilenameUtils.getBaseName(fileName);
        String path=null;
        if(folder){
            path="/${folder}/"+baseName+new Date().format("yyyyMMddHHmmss")+'.'+ext?:'jpg';
        }else{
            path="/"+baseName+new Date().format("yyyyMMddHHmmss")+'.'+ext?:'jpg';
        }
        imageHolder.save(cmd?.upload?.inputStream,path);
        def ret= [:]
        ret.fullUrl = imageHolder.encodeFullUrl(path)
        ret.path = path
        render ret as JSON
    }

}
