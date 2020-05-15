---
grails:
    profile: web
    codegen:
        defaultPackage: quick
    spring:
        transactionManagement:
            proxies: false
    gorm:
        reactor:
            # Whether to translate GORM events into Reactor events
            # Disabled by default for performance reasons
            events: false
info:
    app:
        name: '@info.app.name@'
        version: '@info.app.version@'
        grailsVersion: '@info.app.grailsVersion@'
spring:
    main:
        banner-mode: "off"
    groovy:
        template:
            check-template-location: false

# Spring Actuator Endpoints are Disabled by Default
endpoints:
    enabled: false
    jmx:
        enabled: true

---
grails:
    mime:
        disable:
            accept:
                header:
                    userAgents:
                        - Gecko
                        - WebKit
                        - Presto
                        - Trident
        types:
            all: '*/*'
            atom: application/atom+xml
            css: text/css
            csv: text/csv
            form: application/x-www-form-urlencoded
            html:
              - text/html
              - application/xhtml+xml
            js: text/javascript
            json:
              - application/json
              - text/json
            multipartForm: multipart/form-data
            pdf: application/pdf
            rss: application/rss+xml
            text: text/plain
            hal:
              - application/hal+json
              - application/hal+xml
            xml:
              - text/xml
              - application/xml
    urlmapping:
        cache:
            maxsize: 1000
    controllers:
        defaultScope: singleton
        upload:
            #限制上传图片20M以内
            maxFileSize: 20971520
            maxRequestSize: 20971520
    converters:
        encoding: UTF-8
    databinding:
        dateFormats:
            - 'yyyy-MM-dd HH:mm:ss'
            - 'yyyy-MM-dd'
    views:
        default:
            codec: html
        gsp:
            encoding: UTF-8
            htmlcodec: xml
            codecs:
                expression: html
                scriptlets: html
                taglib: none
                staticparts: none
endpoints:
    jmx:
        unique-names: true

---
hibernate:
    cache:
        queries: false
        use_second_level_cache: false
        use_query_cache: false
dataSource:
    pooled: true
    jmxExport: true
    dbCreate: none
    dialect: org.hibernate.spatial.dialect.mysql.MySQL56InnoDBSpatialDialect
    logSql: false
#    driverClassName: com.mysql.jdbc.Driver
#    driverClassName: com.p6spy.engine.spy.P6SpyDriver
    driverClassName: com.mysql.cj.jdbc.Driver
    username: ${mysqlUser}
    password: '${mysqlPwd}'
    url:  jdbc:mysql://${mysqlHost}:${mysqlPort}/${mysqlDb}?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8&useSSL=true&useInformationSchema=true&serverTimezone=GMT%2B8&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false
#    url:  jdbc:p6spy:mysql://${mysqlHost}:${mysqlPort}/${mysqlDb}?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8&useSSL=true&useInformationSchema=true&serverTimezone=GMT%2B8&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false
    properties:
        jmxEnabled: true
        initialSize: 5
        maxActive: 50
        minIdle: 5
        maxIdle: 25
        maxWait: 10000
        maxAge: 600000
        timeBetweenEvictionRunsMillis: 5000
        minEvictableIdleTimeMillis: 60000
        validationQuery: SELECT 1
        validationQueryTimeout: 3
        validationInterval: 15000
        testOnBorrow: true
        testWhileIdle: true
        testOnReturn: false
        jdbcInterceptors: ConnectionState
        defaultTransactionIsolation: 2 #
goldsite:
    docsUrl: 'https://goldsite.100shouhou.com'
    officeUrl: 'https://goldsite.100shouhou.com'
    licenseUrl: 'https://goldsite.100shouhou.com'
    serPubKey: 'MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQClsrj91wkL9NBwlEbBcrksjmD+iWdz0ZePi7O4Ag/YfaQsWu2VhLJAq5vRkVfaxnIjBoEY52GYvwi3/wfOvDfTee6rCyt97HDS9WyHZZnSRUj49Oh7dPrsAPFPK3ajgsi/QyzSpf2TmYwIgo/G4THKGzBq7Cy1+L90lMlw+O4GlQIDAQAB'
    servImg: true # 选项true,false 是否提供图片访问，如果提供，则imgServer必须配制成/image/get?url=
    imgServer: '/image/get?url='
    imgLoc: '.'
    uploadType: 'local'  # 选项:ftp,sftp,webdav,local 默认:local.
    static: '/static'
    mana:
        cookieMaxAge: 604800
    ftp:
        host:
        port: 21
        user:
        pass:
        localPassive: true # 是否被动模式
    sftp:
        host:
        port:
        user:
        pass:
    webdav:
        serverUrl:
        user:
        pass:

server:
    port: ${serPort}

logging:
    config: 'classpath:logback.groovy'

ckeditor:
    connectors:
        prefix: 'mana'
    config: '/assets/myckconfig.js'
    skipAllowedItemsCheck: false
    defaultFileBrowser: 'ofm'
    upload:
        basedir: '\${goldsite.imgLoc}'
        baseurl: '\${goldsite.imgServer}'
        enableContentController: true
        overwrite: false
        link:
            browser: true
            upload: true
            allowed:
              - js
              - css
              - html
              - txt
              - jpg
              - jpeg
              - png
              - gif
              - doc
              - docx
              - ppt
              - pptx
              - xls
              - xlsx
              - zip
              - rar
              - gz
              - bzip2
              - 7zip
              - mp4
              - 3gp
              - mp3
              - avi
              - woff
              - woff2
              - eot
              - ttf
            denied:
              - html
              - php
              - php2
              - ph3
              - php5
              - exe
              - asp
              - apx
              - jsp
              - gsp
              - cfm
              - htaccess
              - cgi
              - sh
              - vbs
              - reg
        image:
            browser: true
            upload: true
            allowed:
              - jpg
              - gif
              - jpeg
              - png
              - svg
            denied:
        flash:
            browser: false
            upload: false
            allowed:
              - swf
            denied: