package quick

class UrlMappings {

    static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
//            namespace=System.getProperty('scheme')
            constraints {
                // apply constraints here
            }
        }
        "/$namespace/$controller/$action?/$id?(.$format)?" {
            constraints {
                // apply constraints here
            }
        }
        "/mana/vcode"(controller: 'general',action: 'vcode')
        "/vcode"(controller: 'general',action: 'vcode')

        "/"(view:"/index")
        "500"(view:'/error')
        "404"(view:'/notFound')

        "/mana/home"(controller: 'home',action: 'index')
        "/mana"(redirect: '/mana/home')
        "/mana/login"(view: "/mana/login")
        "/mana/unauthorized"(view: "/unauthorized")
    }
}
