import org.springframework.boot.web.servlet.FilterRegistrationBean
import quick.web.filters.RememberMeFilter

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

}
