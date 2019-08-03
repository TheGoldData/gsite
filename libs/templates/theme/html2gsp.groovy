
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

@GrabResolver(name='aliyun', root='http://maven.aliyun.com/nexus/content/groups/public')
@Grab(group='commons-io', module='commons-io', version='2.6')
import groovy.json.JsonOutput
import org.apache.commons.io.FileUtils
import org.apache.commons.io.FilenameUtils

import java.util.regex.Matcher
import java.util.regex.Pattern

/**
 * Created by wdg100 on 19/6/25.
 */


//先处理 html pages in the directory layouts
Collection<File> files=FileUtils.listFiles(new File('layouts'),['html','htm'].toArray(new String[0]),true);
def s=null;
def col2Map(def text){
    Matcher matcher=Pattern.compile('<s\\:col[^>]+name\\="([^"]+)"[^>]*>(.*?)<\\/s:col>',Pattern.DOTALL|Pattern.MULTILINE).matcher('')
    Map<String,String> m=[:]
    matcher.reset(text)
    while(matcher.find()){
        String name=matcher.group(1)
        String content=matcher.group(2)
        m[name+'']=content
        println("${name}===>${content.trim()}")
    }
    return m;
}
def replaceScriptOrLinkOrImg(String text,String regex){
    Matcher scriptMatcher=Pattern.compile(regex,Pattern.MULTILINE).matcher(text);
    sb=new StringBuffer()
    while(scriptMatcher.find()){
        if(scriptMatcher.group(2).startsWith('http') ||scriptMatcher.group(2).startsWith('//')){
            scriptMatcher.appendReplacement(sb,scriptMatcher.group())
            continue;
        }
        String replace='''${ctx}/assets/${application.$theme}/'''
        scriptMatcher.appendReplacement(sb,'$1'+scriptMatcher.quoteReplacement(replace)+'$3$4')
    }
    scriptMatcher.appendTail(sb)
    text=sb.toString()
    return text;
}

def replaceScript(String text) {
    return replaceScriptOrLinkOrImg(text, '(<script(.*?)src\\s*=\\s*[\'|"])([^\'"]+)([\'|"])')
}
def replaceImg(String text) {
    return replaceScriptOrLinkOrImg(text, '(<img(.*?)src\\s*=\\s*[\'|"])([^\'"]+)([\'|"])')
}
def replaceLink(String text) {
    return replaceScriptOrLinkOrImg(text, '(<link(.*?)href\\s*=\\s*[\'|"])([^\'"]+)([\'|"])')
}
println 'layouts:'
files.each {File f->
    String text=f.text
    File parentFile=f.getParentFile()
    String basename=FilenameUtils.getBaseName(f.name)
    File gsp=new File(parentFile,basename+'.gsp')
    println "${f.canonicalPath} ==> ${gsp.name}"
    if(gsp.exists()){ //quit if it exists
        println "skips for its exists."
        return ;
    }
    // enclosing with column name.
    String col_name="layout_${basename}"
    Map col2Map=col2Map(text)
    String newText=''
    if(!col2Map.get(col_name)){ //没有时才添加
        newText=["<s:col name=\"${col_name}\">",text,"</s:col>"].join('\n')
    }
    //Replace title tags with
    Matcher titleMatcher=Pattern.compile('<title>([^<]+)</title>',Pattern.MULTILINE).matcher(newText)
    if(titleMatcher.find()){
        String insertText= '''
    <g:render template="/themes/${application.$theme}/layouts/meta1"/>
    <title>
        <g:layoutTitle default="${g.message(code:'goldsite.siteName',default:application.$siteName)}"/>
    </title>
    <g:render template="/themes/${application.$theme}/layouts/meta2"/>
'''
        newText=[newText.substring(0,titleMatcher.start()),insertText, newText.substring(titleMatcher.end())].join('')
    }
    newText=replaceImg(newText)
    newText=replaceScript(newText)
    newText=replaceLink(newText)
    gsp.write(newText,'utf-8');
}

//convert html to gsp in tpls.
println 'tpls:'
files=FileUtils.listFiles(new File('tpls'),['html','htm'].toArray(new String[0]),true);
files.each { File f ->
    String text=f.getText('utf-8')

    File parentFile=f.getParentFile()
    String basename=FilenameUtils.getBaseName(f.name)

    File gsp=new File(parentFile,basename+'.gsp')
    println "${f.canonicalPath} ==> ${gsp.name}"
    if(gsp.exists()){//return if it exists
        println "skips for its exists."
        return ;
    }

    String hd='''<g:include view="themes/${application.$theme}/layouts/_common.gsp"/>'''
    String newText=[hd,text].join('\n')
    newText=replaceImg(newText)
    newText=replaceScript(newText)
    newText=replaceLink(newText)
    gsp.write(newText,'utf-8');

}
