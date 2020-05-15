import org.springframework.boot.web.servlet.FilterRegistrationBean
import quick.web.filters.CustomFilter
import quick.web.filters.RememberMeFilter
import quick.web.filters.UserPrincipalFilter

beans = {
    xmlns context:"http://www.springframework.org/schema/context"
    importBeans('classpath:/spring/security.groovy')
    importBeans('classpath:/spring/goldsite.groovy')


    rememberMeFilterProxy(FilterRegistrationBean) {
        order=25
        urlPatterns = ['/*']
        filter=ref('rememberMeFilter')
        name='rememberMeFilter'
    }
    rememberMeFilter(RememberMeFilter) {
    }

    userPrincipalFilterProxy(FilterRegistrationBean) {
        order=29
        urlPatterns = ['/*']
        filter=ref('userPrincipalFilter')
        name='userPrincipalFilter'
    }
    userPrincipalFilter(UserPrincipalFilter) {
    }



}
