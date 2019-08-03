//= require bootstrap
//= require bootstrap3-dialog/1.34.7/bootstrap-dialog.min
//= require_self

/**
 * i18n languages
 * <pre>
 *  var goldsite = {
 *      lang: {
 *          dialog: {
 *              ok:"${g.message(code:'goldsite.common.dialog.ok')}",
 *              agree:"${g.message(code:'goldsite.common.dialog.agree')}",
 *              cancel:'${g.message(code:'goldsite.common.dialog.cancel')}',
 *              confirm:'${g.message(code:'goldsite.common.dialog.confirm')}',
 *              title:{
 *                  info:'${g.message(code:"goldsite.common.dialog.title.info")}',
 *                  confirm:'${g.message(code:"goldsite.common.dialog.title.confirm")}',
 *                  error:'${g.message(code:"goldsite.common.dialog.title.error")}',
 *                  success:'${g.message(code:"goldsite.common.dialog.title.success")}',
 *                  warn:'${g.message(code:"goldsite.common.dialog.title.warn")}',
 *              },
 *              message:{
 *                  error:'${g.message(code:"goldsite.common.dialog.message.error")}'
 *              }
 *          }
 *      }
 *  }
 *</pre>
 */

function safeGet(code,defaultVal){
    try{
        return eval(code)
    }catch (error){
        return defaultVal;
    }

}
var goldsite=goldsite||{}
goldsite.initBootstrap=false;
function initLang(){
    if(!goldsite.initBootstrap){
        goldsite.initBootstrap=true;
        BootstrapDialog.DEFAULT_TEXTS[BootstrapDialog.TYPE_DEFAULT] = safeGet('goldsite.lang.dialog.title.info','提示');
        BootstrapDialog.DEFAULT_TEXTS[BootstrapDialog.TYPE_INFO] = safeGet('goldsite.lang.dialog.title.info','提示');
        BootstrapDialog.DEFAULT_TEXTS[BootstrapDialog.TYPE_PRIMARY] = safeGet('goldsite.lang.dialog.title.info','提示');
        BootstrapDialog.DEFAULT_TEXTS[BootstrapDialog.TYPE_SUCCESS] = safeGet('goldsite.lang.dialog.title.success','成功');
        BootstrapDialog.DEFAULT_TEXTS[BootstrapDialog.TYPE_WARNING] =safeGet('goldsite.lang.dialog.title.warn','警告');
        BootstrapDialog.DEFAULT_TEXTS['OK'] = safeGet('goldsite.lang.dialog.ok');
        BootstrapDialog.DEFAULT_TEXTS['CANCEL'] =  safeGet('goldsite.lang.dialog.cancel');
        BootstrapDialog.DEFAULT_TEXTS['CONFIRM'] = safeGet('goldsite.lang.dialog.confirm');

    }

}
function showError(data,callback){
    initLang()
    if(data.__code && data.__code!=100){
        if( data.__code==104){
            var msg='';
            if(data.cause){
                for(var i=0;i<data.cause.length;i++){
                    msg+=data.cause[i]+"<br/>";
                }
            }else{
                msg = data.message ? data.message:safeGet('goldsite.lang.dialog.message.error',"操作失败")
            }
            BootstrapDialog.alert({
                title:goldsite.lang.dialog.title.error,
                message:msg,
                draggable:true,
                type:BootstrapDialog.TYPE_WARNING,
                callback:callback

            });
        }else{
            BootstrapDialog.alert({
                title:safeGet('goldsite.lang.dialog.title.error','错误'),
                message:data.message,
                draggable:true,
                type:BootstrapDialog.TYPE_WARNING,
                callback:callback
            });
        }
    }
    if(!data.__code){
        BootstrapDialog.alert({
            title:safeGet('goldsite.lang.dialog.title.error','错误'),
            message:data.message,
            draggable:true,
            type:BootstrapDialog.TYPE_WARNING,
            callback:callback
        });
    }
}
function showOk(data,callback){
    initLang()
    BootstrapDialog.alert({
        title:data.title?data.title:safeGet('goldsite.lang.dialog.title.info','提示'),
        type:BootstrapDialog.TYPE_SUCCESS,
        message:data.message,
        draggable:true,
        callback:callback
    });
}
function showMsg(data,callback){
    initLang()
    BootstrapDialog.alert({
        title:data.title?data.title:safeGet('goldsite.lang.dialog.title.info','提示'),
        type:BootstrapDialog.TYPE_INFO,
        message:data.message,
        draggable:true,
        callback:callback
    });
}
function showConfirm(data,callback){
    initLang()
    BootstrapDialog.confirm({
        title:data.title?data.title:safeGet('goldsite.lang.dialog.title.confirm','确认'),
        message:data.message,
        type: BootstrapDialog.TYPE_INFO,
        draggable:true,
        callback:callback
    });
}
function showInput(data,callback){
    initLang()
    if(data.defaultVal){
        data.content=data.content+":<input type='text' class='form-control' value='"+data.defaultVal+"' >";
    }else{
        data.content=data.content+":<input type='text' class='form-control'>";
    }

    var $dlg=null
    showHtmlDialog(data,function(dlg){
        $dlg=dlg
        $dlg.$modalContent.find('input').get(0).focus();
    },function () {
        var input=$dlg.$modalContent.find("input").val();
        if(callback){
            callback(input);
        }
    })
}
function showAgree(data,callback,cancelCallback){
    initLang()
    BootstrapDialog.show({
        title:data.title,
        message:data.content,
        type: BootstrapDialog.TYPE_INFO,
        draggable:true,
        callback:callback,
        closable:false,
        buttons:[
            {
                id:'okBtn',
                label:safeGet('goldsite.lang.dialog.agree','同意'),
                action: function(dlg){
                    if(callback){
                        var defer= $.Deferred();
                        var promise=callback(defer);
                        if(promise!=null){
                            promise.then(function () {
                                dlg.close();
                            }, function (data) {
                                //失败什么都不做.
                            })
                        }else{
                            dlg.close();
                        }
                    }
                }
            },
            {
                id:'cancelBtn',
                label:safeGet('goldsite.lang.dialog.cancel','取消'),
                action: function(dlg){
                    if(cancelCallback){
                        cancelCallback(dlg);
                    }
                }
            },
        ]
    });
}
function showHtmlDialog(data,shownCallback,callback,label,hideCallback){
    initLang()
    if(!label){
        label=safeGet('goldsite.lang.dialog.ok','好')
    }
    BootstrapDialog.show({
        title:data.title,
        type:BootstrapDialog.TYPE_DEFAULT,
        message:data.content,
        onshown:shownCallback,
        onhide:hideCallback,
        draggable:true,
        //onhide:callback,
        buttons:[
            {
                id:'okBtn',
                label:label,
                action: function(dlg){
                    if(callback){
                        var defer= $.Deferred();
                        var promise=callback(defer);
                        if(promise!=null){
                            promise.then(function () {
                                dlg.close();
                            }, function (data) {
                                //失败什么都不做.
                            })
                        }else{
                            dlg.close();
                        }
                    }


                }
            }
        ]
    });
}

function replyCommon(oKCallback,errorCallback){
    initLang()
    return function(map){
        if(map.__code && map.__code!=100){
            showError(map,function () {
                if(errorCallback){
                    errorCallback(map);
                }
            })

        }else{
            showOk(map, function () {
                if(oKCallback){
                    oKCallback(map);
                }
            })
        }
    }
}
function replyCommon2(oKCallback,errorCallback){
    initLang()
    return function(map){
        if(map.__code && map.__code!=100){
            if(errorCallback){
                errorCallback(map);
            }
        }
        else{

            if(oKCallback){
                oKCallback(map);
            }
        }
    }
}

function replyCommon3(oKCallback,errorCallback){
    initLang()
    return function(map){
        if(map.__code && map.__code!=100){
            showError(map,function () {
                if(errorCallback){
                    errorCallback(map);
                }
            })
        }
        else{

            if(oKCallback){
                oKCallback(map);
            }
        }
    }
}


function replaceAll(str,pattern,replacement){

    return str.split(pattern).join(replacement);
}

function parseTemplate(tpl,param){
    var props=Object.keys(param);
    props.forEach(function(key){
        var value=param[key];
        tpl=replaceAll(tpl,'$'+key,value)
    })
    return tpl;
}
function findItemBy(list,attr,val){
    for (var i=0;i<list.length;i++){
        if(list[i][attr]==val){
            return list[i];
        }
    }
    return null;
}
function escapeHtml(html){
    var text = document.createTextNode(html);
    var p = document.createElement('p');
    p.appendChild(text);
    return p.innerHTML;
}