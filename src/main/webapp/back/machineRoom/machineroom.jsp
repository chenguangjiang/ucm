<%@page pageEncoding="UTF-8" isELIgnored="false" contentType="text/html; UTF-8" %>


<body>

<script>
    $(function () {
        // 初始化表格并展示所有
        $("#machineroomList").jqGrid({
            height:200,
            styleUI:"Bootstrap",
            autowidth:true,
            url:"${pageContext.request.contextPath}/machineroom/findAll",
            datatype:"json",
            colNames:["编号","名字","容量","状态","地点"],
            colModel:[
                {name:"id",search:false},
                {name:"name",editable:true},
                {name:"capacity",search:false,editable:true},
                {name:"status",search:false,editable:true},
                {name:"site.id",editable:true,edittype:"select",editoptions:{
                        dataUrl:"${pageContext.request.contextPath}/site/findAllName",
                    },
                    formatter:function (value,options,row) {
                        if (row.site)return row.site.name;
                    }
                },
            ],
            pager:"#pager",
            viewrecords:true,
            rowNum:3,
            rowList:[3,5,10],
            editurl:"${pageContext.request.contextPath}/machineroom/edit",

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
    <table id="machineroomList"></table>
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


