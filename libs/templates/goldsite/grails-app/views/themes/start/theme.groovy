
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

import java.util.regex.Matcher
import java.util.regex.Pattern

/**
 * Created by wdg100 on 19/6/25.
 */

String[] s=new String[1]
s[0]='gsp'
Collection<File> list=FileUtils.listFiles(new File('.'),s,true);


Matcher matcher=Pattern.compile('<s\\:col[^>]+name\\="([^"]+)"[^>]*>(.*?)<\\/s:col>',Pattern.DOTALL|Pattern.MULTILINE).matcher('')

Map<String,String> m=[:]
list.each {File f->
    println("f>${f.absolutePath}")

    String text=f.text

    matcher.reset(text)

    while(matcher.find()){
        String name=matcher.group(1)
        String content=matcher.group(2)
        m[name+'']=content
        println("${name}===>${content.trim()}")
    }
}

m=m.sort({e1,e2->
    return e1.key.compareTo(e2.key)
})

String[] s2=new String[1]
s2[0]='gsp'
Collection<File> gspList=FileUtils.listFiles(new File('./tpls'),s2,true);

List l=[]
gspList.each {
    l.add('tpls/'+it.getName())
}

def cc=[
        cols:m,
        tpls:l,
]


String text=JsonOutput.prettyPrint(JsonOutput.toJson(cc))

new File('./theme.json').write(text,'utf-8')

