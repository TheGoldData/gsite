<g:include view="mana/shared/_common.gsp"/>
<div class="side-body">
    <div class="page-title">
        <span class="title"><g:message code="goldsite.resource.users"/></span>
    </div>
    <div class="row">
        <div class="col-xs-12">
            <div class="card">
                <div class="card-header">
                    <div class="card-title">
                        <div class="title"><g:message code="goldsite.resource.users.list"/></div>
                    </div>
                </div>
                <div class="card-body">
                    <form class="form-inline" id="searchForm">
                        <div class="form-group">
                            <label for="phone"><g:message code="goldsite.resource.users.list.searchForm.phone"/></label>
                            <input type="text" class="form-control" id="phone"  name="phone"   placeholder="${g.message(code:'goldsite.resource.users.list.searchForm.phonetip')}">
                        </div>
                        <div class="form-group">
                            <label for="email"><g:message code="goldsite.resource.users.list.searchForm.email"/></label>
                            <input type="text" class="form-control" id="email"  name="email"   placeholder="${g.message(code:'goldsite.resource.users.list.searchForm.emailtip')}">
                        </div>
                        <div class="form-group">
                            <label for="nickname"><g:message code="goldsite.resource.users.list.searchForm.nickname"/></label>
                            <input type="text" class="form-control" id="nickname"  name="nickname"   placeholder="${g.message(code:'goldsite.resource.users.list.searchForm.nicknametip')}">
                        </div>
                        <div class="form-group">
                            <label><g:message code="goldsite.resource.users.list.searchForm.registerDate"/></label>

                            <input type="text" class="" name="regStart" id="inpstart" readonly>
                            <input type="text" class="" name="regEnd" id="inpend" readonly>
                        </div>

                        <button type="submit" class="btn btn-default" id="searchButton"><g:message code="goldsite.common.button.search"/></button>
                    </form>
                    %{--<button  class="btn btn-default" id="exportButton">导出</button>--}%
                    <table class="table"  id="dataTable">
                        <thead>
                        <tr>
                            <th class="w_homeT1"><g:message code="goldsite.common.tablecol.offset"/></th>
                            <th class="w_homeT1"><g:message code="goldsite.resource.users.list.tablecol.avator"/></th>
                            <th class="w_homeT1"><g:message code="goldsite.resource.users.list.tablecol.nickname"/></th>
                            <th class="w_homeT1"><g:message code="goldsite.resource.users.list.tablecol.email"/></th>
                            <th class="w_homeT1"><g:message code="goldsite.resource.users.list.tablecol.phone"/></th>
                            <th class="w_homeT1"><g:message code="goldsite.resource.users.list.tablecol.gender"/></th>
                            <th class="w_homeT1"><g:message code="goldsite.resource.users.list.tablecol.birthdate"/></th>
                            <th class="w_homeT1"><g:message code="goldsite.resource.users.list.tablecol.registerdate"/></th>
                            <th class="w_homeT1"><g:message code="goldsite.common.tablecol.status"/></th>
                            <th class="w_homeT1"><g:message code="goldsite.common.tablecol.action"/></th>
                        </tr>
                        </thead>
                        <tbody>

                        </tbody>
                    </table>

                </div>
            </div>
        </div>
    </div>
</div>
<script>
    $(function() {
        $("#inpstart") .jeDate({
            language:goldsite.lang.calendar,
//            dateCell: '#inpstart',
            onClose:false,
            format: 'YYYY-MM-DD hh:mm:ss',
            /*minDate: jeDate.now(0), //设定最小日期为当前日期*/
            isinitVal:false,
            festival:false,
            ishmsVal:false,
            isTime:true,
            ishmsLimit:true,
            maxDate: '2099-06-30 23:59:59', //最大日期
            choosefun: function(elem,datas){
                //    end.minDate = datas; //开始日选好后，重置结束日的最小日期
            }
        })
        $("#inpend") .jeDate({
            language:goldsite.lang.calendar,
//            dateCell: '#inpstart',
            onClose:false,
            format: 'YYYY-MM-DD hh:mm:ss',
            /*minDate: jeDate.now(0), //设定最小日期为当前日期*/
            isinitVal:false,
            festival:false,
            ishmsVal:false,
            isTime:true,
            ishmsLimit:true,
            maxDate: '2099-06-30 23:59:59', //最大日期
            choosefun: function(elem,datas){
                //    end.minDate = datas; //开始日选好后，重置结束日的最小日期
            }
        })


        var userManage = {
            getQueryCondition : function(aoData) {
                var form = $("#searchForm").serializeArray();
                $.each(form,function (e,v) {
                    aoData.push({"name":v.name,"value":v.value})
                })
                return aoData;
            }
        };

        //点击查询重新加载
        $("#searchForm").submit(function(){
            $("#dataTable").DataTable().ajax.reload();
            return false;
        });
        table = $('#dataTable').DataTable({
            "bSort": true,		//取消默认排序查询,否则复选框一列会出现小箭头
            "aaSorting": [],
            "bProcessing": false,	//隐藏加载提示,自行处理
            "serverSide": true,
//            "bProcessing": true,
            "bLengthChange": true,
            "bFilter": false,  //搜索框
            "bAutoWidth": false,//关闭后，表格将不会自动计算表格大小
            "sAjaxDataProp": "data",
            "bInfo": true,//页脚信息
            "iDisplayLength": 10,
            "sAjaxSource": "${ctx}/userInfo/list.json",
            "language":goldsite.lang.datatable,
            "fnServerData": function (sSource, aoData, fnCallback) {
                var param =  userManage.getQueryCondition(aoData);
                $.ajax({
                    "type": 'POST',
                    "url": sSource,
                    "dataType": "json",
                    "data": aoData,
                    "success": function (resp) {
                        fnCallback(resp);
                    }
                });
            },

            "aoColumns": [{
                "bSortable": false,
                "mRender":function(row,type,full,meta){
                    return (meta.settings._iDisplayStart+meta.row+1) +"/"+full.id
                }
            },{
                "mData": "avator",
                "mRender":function(data,type,full){
                    var text="";
                    if(full.avator){
                        text += "<img src='"+full.avator+"' style='height:60px;width:60px'> "

                    }

                    return text;
                }
            },  {
                "mData": "nickname",
                "aTargets": [3]
            },{
                "mData": "email",
                "aTargets": [3]
            },{
                "mData": "phone",
                "aTargets": [3]
            }, {
                "mData": "genderLabel",
                "aTargets": [2]
            },{
                "mData": "dateBirth",
                "aTargets": [2]

            },
                {
                    "mData": "dateCreated",
                    "aTargets": [4]
                },{
                    "mData": "statusLabel",
                    "aTargets": [4]
                }, {"mData": false,
                    "bSortable": false,
                    "mRender":function(data,type,full){
                        var text="";
                        text += "<a href='javascript:void(0)' class='link' onclick='updateStatus("+full.id+")'>${g.message(code:'goldsite.common.button.updateStatus')}</a> "

                        return text;
                    }
                }
            ],
        });
    })

    function updateStatus(id) {
        $.post("${ctx}/userInfo/updateStatus",{"id":id},replyCommon(function (data) {
           $("#dataTable").DataTable().ajax.reload(null,false);
        }))
    }
</script>