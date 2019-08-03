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
<s:col name="userProto_page">
<g:include view="themes/${application.$theme}/layouts/_common.gsp"/>
<%-- ================ 用户注册协议,请根据自己的需要进行修改 start=============--%>
<%-- ================ The page serves for 'registration protocol',You can change the content start============= --%>
<g:set var="siteName" value="${g.message(code:'goldsite.siteName',default: application.$siteName)}"/>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <title>协议</title>
</head>
<body>

<p>一、注册协议：</p>
<p>${siteName}提醒您：在使用本站各项服务前，请务必仔细阅读并理解本协议</p>
<p>一．总则</p>
<p>1.1 同意遵守本协议及所有网站规则后方可成为${siteName}用户。一旦注册成功，您与本站之间自动形成协议关系，须受本协议及所有本站规则的约束。</p>
<p>1.2 本协议根据${siteName}运营情况随时更新，${siteName}不承担通知义务，请您在使用时密切关注。</p>
<p>二．帐户</p>
<p>2.1 您注册的账号如果出现以下情况，${siteName}将有权禁止您在本站点的一切活动。</p>
<p>以党和国家领导人的真实姓名或音近名称注册； 　　</p>
<p>以国家机构或其他机构的名称注册；</p>
<p>以未经（${siteName}）许可的公司/单位名称之类含有广告性质的名称注册；</p>
<p>以${siteName}等相关或相近名称注册；</p>
<p>以本人或他人的手机号码、QQ号码、群号码等含有联系方式的信息注册；</p>
<p>以含有恶意人身攻击或淫秽字眼的名称注册；</p>
<p>以“管理员”等名称注册；</p>
<p>以机器手段批量注册。</p>
<p>账号名违反社会公德，令常人反感的。</p>
<p>2.2 您有义务保证个人账号和密码的安全，因保管不当引起的任何损失或损害，${siteName}不承担任何责任。</p>
<p>三．使用</p>
<p>3.1 欢迎您随时进入${siteName}参与交流，但如果您在本站点发布、转载、传送含有任何下列内容的信息，${siteName}将有权自行处理：</p>
<p>——发布反对宪法所确定的基本原则、危害国家安全、泄露国家机密、颠覆国家政权、破坏国家统一、损害国家荣誉和利益、</p>
<p>煽动民族仇恨、民族或地区歧视、宣扬邪教和封建迷信、散布谣言、扰乱社会秩序和稳定的内容；</p>
<p>——发布涉及政治军事题材、淫秽、色情、有违公德的不健康内容、赌博、暴力、凶杀、恐怖或教唆犯罪等内容；</p>
<p>——发布侮辱或诽谤他人，公布及侵害他人隐私及侵害他人合法权益的内容；</p>
<p>——发布任何非${siteName}指定团体和组织的商业行为；</p>
<p>——发布含有法律、行政法规、规章、行政规范性文件禁止的其他内容；</p>
<p>——恶意发布他人联系方式、照片等涉及他人隐私的内容。</p>
<p>3.2 所有虚拟产品是${siteName}向注册用户提供的服务。所有虚拟产品在有效期内有效，用于记载所有虚拟产品的${siteName}在有效期内注销的（包括用户主动或被动注销），虚拟产品同时失效。所有虚拟产品不具有现金价值，并非您拥有所有权的财产，不可转让或换取现金。虚拟产品的抵扣，有效期规则的最终解释权归${siteName}。</p>
<p></p>
<p>特别约定：您同意：他人未经许可，发布您已在${siteName}上传的合法作品（包括但不限于文字、图片、照片等作品）的，${siteName}可以自己的名义主张权利。${siteName}可以采取的维权行动有交涉、投诉、向法院起诉等。</p>

</body>
</html>
<%-- ================ The page serves for 'registration protocol',You can change the content start============= --%>
<%-- ================ 用户注册协议,请根据自己的需要进行修改 end=============--%>
</s:col>