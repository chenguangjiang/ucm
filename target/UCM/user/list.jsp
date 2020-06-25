<%@page pageEncoding="UTF-8" isELIgnored="false" contentType="text/html; UTF-8" %>


<body>

<script>
    $(function () {
        // 初始化表格并展示所有
        $("#userList").jqGrid({
            height:200,
            styleUI:"Bootstrap",
            autowidth:true,
            url:"${pageContext.request.contextPath}/user/findAll",
            datatype:"json",
            colNames:["编号","用户名","密码","真实姓名","身份","手机号"],
            colModel:[
                {name:"id",search:false},
                {name:"name",search:false,editable:true},
                {name:"password",search:false,editable:true},
                {name:"truename",editable:true},
                {name:"usertype",editable:true},
                {name:"phone",search:false,editable:true},
            ],
            pager:"#pager",
            viewrecords:true,
            rowNum:5,
            rowList:[5,10,15],
            editurl:"${pageContext.request.contextPath}/user/edit",

        }).navGrid('#pager',  //参数1 分页工具栏参数
            {add:true}, //开启工具栏编辑按钮
            {closeAfterEdit:true,reloadAfterSubmit:true},//编辑面板配置
            {closeAfterAdd:true,reloadAfterSubmit:true},//添加面板配置
            {},//删除面板配置
            {
                sopt:['eq','ne','cn']
            },
        );//搜索面板配置
    });
</script>

<div class="col-sm-10">
    <!--页头-->
    <div class="page-header" style="margin-top: -20px">
        <h1>机房列表</h1>
    </div>
    <%--机房列表--%>
    <table id="userList"></table>
    <%--分页工具栏--%>
    <div id="pager"></div>
</div>
<div class="row"style="height: 400px">

</div>
<div class="row">
    <div class="col-sm-2"></div>
    <div class="col-sm-10">
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
</div>


