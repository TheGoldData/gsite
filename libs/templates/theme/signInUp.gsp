%{--
  -  Copyright 2016-2019 新商态（北京）科技有限公司
  -
  -  Licensed under the Apache License, Version 2.0 (the "License");
  -  you may not use this file except in compliance with the License.
  -  You may obtain a copy of the License at
  -
  -      http://www.apache.org/licenses/LICENSE-2.0
  -
  -  Unless required by applicable law or agreed to in writing, software
  -  distributed under the License is distributed on an "AS IS" BASIS,
  -  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  -  See the License for the specific language governing permissions and
  -  limitations under the License.
  --}%
<s:col name="login_page">
<g:include view="themes/${application.$theme}/layouts/_common.gsp"/>
<%-- ================ 你可以根据你的需要 修改登录或者注册页面内容，也可以后期让编辑在后端修改内容 start============= --%>
<%-- ================ The page serves for 'sign in and up'. You can change the content start============= --%>

<!DOCTYPE HTML>
<html>
<head>
    <title><g:message code="goldsite.siteName" default="${application.$siteName}"/>--<g:message code="goldsite.signInUp.usercenter" default="用户中心" /></title>
    <asset:stylesheet src="common/goldsite.utils.css"/>
    <script src="https://code.jquery.com/jquery-1.11.1.min.js"></script>
    <asset:javascript src="common/goldsite.utils.js"></asset:javascript>

</head>
<body>

<div class="container">
    <div id="loginbox" style="margin-top:50px;" class="mainbox col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2">
        <div class="panel panel-info" >
            <div class="panel-heading">
                <div class="panel-title"><a href="${ctx}/"><g:message code="goldsite.siteName" default="${application.$siteName}"/></a>--<g:message code="goldsite.signInUp.login" default="登录"/></div>
                <div style="float:right; font-size: 80%; position: relative; top:-10px"><a href="javascript:void 0" onclick="$('#signupbox,#loginbox').hide(); $('#forgotbox').show()" >
                    <g:message code="goldsite.signInUp.doForgotPass" default="忘记了密码?"/>
                    </a></div>
            </div>

            <div style="padding-top:30px" class="panel-body" >

                <div style="display:none" id="login-alert" class="alert alert-danger col-sm-12"></div>

                <form id="loginform" class="form-horizontal" role="form">

                    <div style="margin-bottom: 25px" class="input-group">
                        <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                        <input id="login-username" type="email" class="form-control" name="email" value="" placeholder="${g.message(code:'goldsite.signInUp.form.email')}">
                    </div>

                    <div style="margin-bottom: 25px" class="input-group">
                        <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
                        <input id="login-password" type="password" class="form-control" name="pass" placeholder="${g.message(code:'goldsite.signInUp.form.pass')}">
                    </div>
                    <g:if test="${needVCode}">
                    <div class="form-group">
                        <div class="col-md-12">
                            <input type="text" class="form-control" name="vcode" placeholder="${g.message(code:'goldsite.signInUp.form.vcode')}" >

                            <p style="margin-top:5px;">
                                <img id="imgObj" src="${ctx}/vcode?timestamp=${new java.util.Date().format('yyyyMMddHHmmss')}" onclick="chImg('${ctx}')"
                                     title="${g.message(code:'goldsite.signInUp.form.altChange')}"/>
                            </p>
                        </div>
                    </div>
                    </g:if>

                    <div class="input-group">
                        <div class="checkbox">
                            <label>
                                <input id="login-remember" type="checkbox" name="rememberMe" value="1">  ${g.message(code:'goldsite.signInUp.form.rememberMe')}
                            </label>
                        </div>
                    </div>


                    <div style="margin-top:10px" class="form-group">
                        <div class="col-sm-12 controls">
                            <a id="btn-login" href="javascript:void 0" onclick="$(event.currentTarget).closest('form').trigger('submit')" class="btn btn-success"><g:message code="goldsite.signInUp.login" default="登录"/>  </a>

                        </div>
                    </div>


                    <div class="form-group">
                        <div class="col-md-12 control">
                            <div style="border-top: 1px solid#888; padding-top:15px; font-size:85%" >
                                ${g.message(code:'goldsite.signInUp.form.doHaveNotAccount')}
                                <a href="javascript:void 0" onClick="$('#loginbox').hide(); $('#signupbox').show()">
                                ${g.message(code:'goldsite.signInUp.form.register')}
                                </a>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <div id="signupbox" style="display:none; margin-top:50px" class="mainbox col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2">
        <div class="panel panel-info">
            <div class="panel-heading">
                <div class="panel-title"><a href="${ctx}/"><g:message code="goldsite.siteName" default="${application.$siteName}"/></a>--${g.message(code:'goldsite.signInUp.form.register')}</div>
                <div style="float:right; font-size: 85%; position: relative; top:-10px"><a  href="javascript:void 0" onclick="$('#signupbox,#forgotbox').hide(); $('#loginbox').show()">${g.message(code:'goldsite.signInUp.login')}</a></div>
            </div>
            <div class="panel-body" >
                <form id="signupform" class="form-horizontal" role="form">

                    <div id="signupalert" style="display:none" class="alert alert-danger">
                        <p>Error:</p>
                        <span></span>
                    </div>



                    <div class="form-group">
                        <label for="signup-email" class="col-md-3 control-label"> ${g.message(code:'goldsite.signInUp.form.email')}</label>
                        <div class="col-md-9">
                            <input type="text" class="form-control" name="email" id="signup-email"  placeholder="${g.message(code:'goldsite.signInUp.form.email')}">
                            <p style="margin-top: 5px">
                                <button  type="button" class="btn btn-info" onclick="sendEmailForRegister(event)"> ${g.message(code:'goldsite.signInUp.form.sendVCode')}</button>
                            </p>

                        </div>
                    </div>

                    <div class="form-group">
                        <label for="signup-vcode" class="col-md-3 control-label">${g.message(code:'goldsite.signInUp.form.vcode')}</label>
                        <div class="col-md-9">
                            <input type="text" class="form-control" name="vcode" id="signup-vcode"  placeholder="${g.message(code:'goldsite.signInUp.form.vcode')}">

                        </div>
                    </div>
                    <div class="form-group">
                        <label for="signup-nickname" class="col-md-3 control-label">${g.message(code:'goldsite.signInUp.form.nickame')}</label>
                        <div class="col-md-9">
                            <input type="text" class="form-control" name="nickname" id="signup-nickname"  placeholder="${g.message(code:'goldsite.signInUp.form.nickame')}">

                        </div>
                    </div>
                    <div class="form-group">
                        <label for="signup-pass" class="col-md-3 control-label">${g.message(code:'goldsite.signInUp.form.pass')}</label>
                        <div class="col-md-9">
                            <input type="password" class="form-control" name="pass" id="signup-pass" placeholder="${g.message(code:'goldsite.signInUp.form.pass')}">
                        </div>
                    </div>

                    <div class="form-group">
                        <!-- Button -->
                        <div class="col-md-offset-3 col-md-9">
                        <style>
                            #my_proto{
                                max-height: 300px;
                                overflow-x: hidden;
                                overflow-y: scroll;
                            }
                        </style>
                        <p>
                            <input type="checkbox"  name="proto" id="protoLabel" value="1"  checked="checked">
                            <label for="protoLabel">${g.message(code:'goldsite.signInUp.form.agreeProto')}</label>

                            <a href="javascript:void 0"
                            onclick="showHtmlDialog({title:'${g.message(code:'goldsite.signInUp.form.proto')}',content:'<div id=\'my_proto\'></div>'   },function(){ $('#my_proto').load('${ctx}/user/proto');},function(){});return false;"
                        >${g.message(code:'goldsite.signInUp.form.registerProto')}</a>
                        </p>
                            <button id="btn-signup" type="button" class="btn btn-info"
                                    onclick="$(event.currentTarget).closest('form').trigger('submit')" ><i class="icon-hand-right"></i> &nbsp ${g.message(code:'goldsite.signInUp.form.register')}</button>
                            %{--<span style="margin-left:8px;">or</span>--}%
                        </div>
                    </div>

                </form>
            </div>
        </div>
    </div>
    <div id="forgotbox" style="display:none; margin-top:50px" class="mainbox col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2">
        <div class="panel panel-info">
            <div class="panel-heading">
                <div class="panel-title"><a href="${ctx}/"><g:message code="goldsite.siteName" default="${application.$siteName}"/></a>--${g.message(code:'goldsite.signInUp.form.retrievePass')}</div>
                <div style="float:right; font-size: 85%; position: relative; top:-10px"><a href="javascript:void 0" onclick="$('#signupbox,#forgotbox').hide(); $('#loginbox').show()">${g.message(code:'goldsite.signInUp.login')}</a></div>
            </div>
            <div class="panel-body" >
                <form id="forgotform" class="form-horizontal" role="form">


                    <div class="form-group">
                        <label for="forgot-email" class="col-md-3 control-label">${g.message(code:'goldsite.signInUp.form.email')}</label>
                        <div class="col-md-9">
                            <input type="text" class="form-control" name="email" id="forgot-email"  placeholder="${g.message(code:'goldsite.signInUp.form.email')}">
                            <p style="margin-top: 5px">
                                <button  type="button" class="btn btn-info" onclick="sendEmailForForgot(event)"> ${g.message(code:'goldsite.signInUp.form.sendVCode')}</button>
                            </p>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="forgot-vcode" class="col-md-3 control-label">${g.message(code:'goldsite.signInUp.form.vcode')}</label>
                        <div class="col-md-9">
                            <input type="text" class="form-control" name="vcode" id="forgot-vcode"  placeholder="${g.message(code:'goldsite.signInUp.form.vcode')}">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="forgot-pass" class="col-md-3 control-label">${g.message(code:'goldsite.signInUp.form.setPass')}</label>
                        <div class="col-md-9">
                            <input type="password" class="form-control" name="pass" id="forgot-pass" placeholder="${g.message(code:'goldsite.signInUp.form.setPass')}">
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-md-offset-3 col-md-9">
                            <button  type="button" class="btn btn-info" href="javascript:void 0" onclick="$(event.currentTarget).closest('form').trigger('submit')" ><i class="icon-hand-right"></i> &nbsp <g:message code="goldsite.common.button.submit"/></button>
                        </div>
                    </div>

                </form>
            </div>
        </div>
    </div>
</div>

<script>
    var goldsite = {
        lang: {
            dialog: {
                ok:"${g.message(code:'goldsite.common.dialog.ok')}",
                agree:"${g.message(code:'goldsite.common.dialog.agree')}",
                cancel:'${g.message(code:'goldsite.common.dialog.cancel')}',
                confirm:'${g.message(code:'goldsite.common.dialog.confirm')}',
                title:{
                    info:'${g.message(code:"goldsite.common.dialog.title.info")}',
                    confirm:'${g.message(code:"goldsite.common.dialog.title.confirm")}',
                    error:'${g.message(code:"goldsite.common.dialog.title.error")}',
                    success:'${g.message(code:"goldsite.common.dialog.title.success")}',
                    warn:'${g.message(code:"goldsite.common.dialog.title.warn")}',
                },
                message:{
                    error:'${g.message(code:"goldsite.common.dialog.message.error")}'
                }
            }
        }
    }

    function chImg(ctx) {
        var imgSrc = $("#imgObj");
        var src = imgSrc.attr("src");
        imgSrc.attr("src", function(){
            var timestamp = (new Date()).valueOf();
            return ctx + "/vcode" + "?timestamp=" + timestamp;
        });
    }

    function sendEmailForForgot(event){
        var email=$(event.currentTarget).closest('form').find('[name=email]').val()
        $.post("${ctx}/user/sendEmailForForgot",{email:email},replyCommon3(function (data) {
            showOk({message:data.data.message})
        }))
    }
    function sendEmailForRegister(event){
        var email=$(event.currentTarget).closest('form').find('[name=email]').val()
        $.post("${ctx}/user/sendEmailForRegister",{email:email},replyCommon3(function (data) {
            showOk({message:data.data.message})
        }))
    }
    $("#loginform").submit(function () {
        $.post("${ctx}/user/login",$(this).serialize(),replyCommon3(function (data) {
            window.location=data.data.returnUrl
        },function(){

            setTimeout(function () {
                window.location.reload(true);
            },50)
        }))
        return false;
    })
    $("#signupform").submit(function () {
        var xx=$(this).find('[name=proto]:checked').val()
        if(!xx){
            showMsg({message:"${g.message(code:'goldsite.signInUp.form.agreePrototip')}"})
            return false;
        }

        $.post("${ctx}/user/register",$(this).serialize(),replyCommon3(function (data) {
            showOk(data.data, function () {
                showMainBox('#loginbox')
            })
        }))
        return false;
    })
    $("#forgotform").submit(function () {
        $.post("${ctx}/user/forgot",$(this).serialize(),replyCommon3(function (data) {
            showOk(data.data, function () {
                showMainBox('#loginbox')
            })
        }))
        return false;
    })
    function showMainBox(form){
        $('.mainbox').hide()
        $(form).show()
    }
    var prefer="${prefer}"
    if(prefer=='signUp'){
        showMainBox('#signupbox')
    }else{
        showMainBox('#loginbox')
    }

</script>
</body>
</html>
<%-- ================ The page serves for 'sign in and up'. You can change the content end============= --%>
<%-- ================ 你可以根据你的需要 修改登录页面内容，也可以后期让编辑在后端修改内容 end============= --%>
</s:col>