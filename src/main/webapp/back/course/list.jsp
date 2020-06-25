<%@page pageEncoding="UTF-8" isELIgnored="false" contentType="text/html; UTF-8" %>


<script>
    // 通过动态获取展示标签页
    $(function () {
        $("#${param.name}").tab('show');
    });
    //导出数据
    function exportExcel() {
        if (window.confirm("你确定要导出数据吗?")){
        $.ajax({
            url:'${pageContext.request.contextPath}/timetable/exportData',
            method:'get',
            dataType:'json',
        });
        alert("恭喜你！导出数据成功");
        }
    }
    //导出模板
    function exportModel() {
        if (window.confirm("你确定要导出模板吗?")){
            $.ajax({
                url:'${pageContext.request.contextPath}/timetable/exportModel',
                method:'get',
                dataType:'json',
            });
            alert("恭喜你！导出模板成功");
        }
    }
</script>

<!--中心内容-->
<div class="col-sm-10">

    <!--页头-->
    <div class="page-header" style="margin-top: -20px">
        <h1>课程列表</h1>
    </div>

    <!--标签页组件-->
    <!-- Nav tabs -->
    <ul class="nav nav-tabs" role="tablist">
        <li role="presentation" class="active"><a href="#home" aria-controls="home" role="tab" data-toggle="tab" id="courseList">课程信息</a></li>
        <li role="presentation" ><a href="#profile" aria-controls="profile" role="tab" data-toggle="tab" id="manualinput">导出模板</a></li>
    </ul>


    <%--手动排课页面--%>
    <!-- Tab panes -->
    <div class="tab-content">
        <div role="tabpanel" class="tab-pane active" id="home">

            <script>
                $(function () {
                    // 初始化表格并展示所有
                    $("#timetableList").jqGrid({
                        height:250,
                        styleUI:"Bootstrap",
                        url:"${pageContext.request.contextPath}/timetable/findAll",
                        datatype:"json",
                        colNames:["编号","课程周期","课节","星期","老师","课目","班级","教室"],
                        colModel:[
                            {name:"id",search:false,hidden:true,editoptions:{required:true}},
                            {name:"weekscount",search:false,editable:true,editoptions:{required:true}},
                            {name:"phases",search:false,editable:true},
                            {name:"week",editable:true,editable:true},
                            {name:"teacher",editable:true,editable:true},
                            {name:"curriculum",search:false,editable:true},
                            {name:"classes",search:false,editable:true},

                            //教室
                            {name:"machineroom.id",editable:true,edittype:"select",editoptions:{
                                    dataUrl:"${pageContext.request.contextPath}/machineroom/findAllName",
                                },
                                formatter:function (value,options,row) {
                                    if (row.machineroom)return row.machineroom.name;
                                }
                            },


                        ],
                        pager:"#pager",
                        viewrecords:true,
                        rowNum:5,
                        rowList:[5,10,15],
                        editurl:"${pageContext.request.contextPath}/timetable/edit",
                        toolbar:[true,'both'],
                        gridComplete:function () {
                            $("#t_timetableList").empty().append("<button class='btn btn-danger' data-toggle='modal' data-target='#importDialog'>导入课程</button>&nbsp;&nbsp;&nbsp;",
                            "<button class='btn btn-danger' onclick='exportExcel()'>&nbsp;导出课程&nbsp;</button>"
                            )
                        },



                    }).navGrid('#pager',  //参数1 分页工具栏参数
                        {add:true}, //开启工具栏编辑按钮
                        {closeAfterEdit:true,reloadAfterSubmit:true,edittext:"编辑"},//编辑面板配置
                        {closeAfterAdd:true,reloadAfterSubmit:true},//添加面板配置
                        {},//删除面板配置
                        {
                            sopt:['eq','ne','cn']
                        },
                    );//搜索面板配置


                });


            </script>


            <%--课程列表--%>
            <table id="timetableList"></table>
            <%--分页工具栏--%>
            <div id="pager"></div>

            </br>
            </br>
            <!--警告信息-->
            <div class="alert alert-warning alert-dismissible" role="alert">
                <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <strong>Warning!</strong> Better check yourself, you're not looking too good.
            </div>
            <div class="alert alert-danger alert-dismissible" role="alert">
                <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <strong>Warning!</strong> Better check yourself, you're not looking too good.
            </div>

        </div>

        <%--导出模板--%>

        <div role="tabpanel" class="tab-pane" id="profile">
            <form>
                </br>
               <h3><p class="text-muted">1.请注意导出生成的模板默认在C盘根目录下</p></h3>
                </br>
                <h3> <p class="text-success">2.请不要随意更改模板，按照模板填充数据</p></h3>
                </br>
                <button type="button" onclick="exportModel()" class="btn btn-default">确认导出</button>
            </form>
        </div>

    </div>
</div>



<%--导入文件模态框--%>

<div class="modal fade" id="importDialog" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">导入课程信息</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" action="${pageContext.request.contextPath}/timetable/importData" method="post"  enctype="multipart/form-data">
                    <div class="form-group">
                        <label >File input</label>
                        <input type="file" class="form-control" name="aaa" id="file1" >
                    </div>
                    </br>
                    <div class="form-group">
                        <div>
                            <h4>温馨提示</h4>
                            <p class="help-block">1.请按照模板正确上传数据。</p>
                             <p class="help-block">2.请保证数据的规范。</p>
                        </div>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button type="submit" class="btn btn-primary">提交</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>




