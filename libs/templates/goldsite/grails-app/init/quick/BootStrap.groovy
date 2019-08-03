package quick

import grails.converters.JSON

class BootStrap {

    BootService bootService

    def init = { servletContext ->
//        grailsApplication
        JSON.registerObjectMarshaller(Date){
            return it?.format("yyyy-MM-dd HH:mm:ss")
        }
        //初始化goldsite相关服务
        bootService.init(servletContext)
    }

    def destroy = {

    }
}
