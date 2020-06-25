<%@page pageEncoding="UTF-8" isELIgnored="false" contentType="text/html; UTF-8" %>

<script>
    $(function () {
        // 初始化表格并展示所有
        $("#equipmentList").jqGrid({
            height:300,
            styleUI:"Bootstrap",
            autowidth:true,
            url:"${pageContext.request.contextPath}/equipment/findAll",
            datatype:"json",
            colNames:["编号","品牌","IP地址","安装软件","状态","备注","所处机房","操作"],
            colModel:[
                {name:"id",search:false},
                {name:"name",search:false,editable:true},
                {name:"ipadress",editable:true},
                {name:"software",search:false,editable:true,edittype:"textarea"},
                {name:"status",search:false,editable:true},
                {name:"remark",search:false,editable:true},
                {name:"machineroom.id",editable:true,edittype:"select",editoptions:{
                        dataUrl:"${pageContext.request.contextPath}/machineroom/findAllName",
                    },
                    formatter:function (value,options,row) {
                        if (row.machineroom)return row.machineroom.name;
                    }
                },
                {name:"options",search:false,
                    formatter:function (value,options,row) {
                        return ``+
                            `<button class="btn btn-primary" onclick="editRow('`+row.id+`');">修改</button>&nbsp;&nbsp;`+
                            `<button class="btn btn-danger" onclick="delRow('`+row.id+`');">删除</button>`;
                    }

                },
            ],
            pager:"#pager",
            viewrecords:true,
            rowNum:5,
            rowList:[5,10,15],
            editurl:"${pageContext.request.contextPath}/equipment/edit",
            toolbar:[true,'both'],
            gridComplete:function () {
                $("#t_equipmentList").empty().append("<button class='btn btn-warning' onclick='saveRow();'>&nbsp;添加&nbsp;</button>")
            }
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
    //修改
    function editRow(id) {
        console.log(id);
        $("#equipmentList").jqGrid('editGridRow',id, {
            height : 400,
            reloadAfterSubmit : true,
            closeAfterEdit:true,
        });
    }
    //删除
    function delRow(id) {
        if (window.confirm("你确定要删除吗?")){
            //发送ajax请求时删除
            $.post("${pageContext.request.contextPath}/equipment/edit",{id:id,oper:"del"},function () {
                //刷新页面
                $("#equipmentList").trigger('reloadGrid');//刷新表格
            });
        };
    };
    //添加
    function saveRow() {
        $("#equipmentList").jqGrid('editGridRow', "new", {
            height : 400,
            reloadAfterSubmit : true,
            closeAfterAdd:true

        });
    }

</script>

<!--页头-->
<div class="page-header" style="margin-top: -20px">
 <h1>设备列表</h1>
</div>


<div class="col-sm-10">
    <%--设备列表--%>
    <table id="equipmentList"></table>
    <%--分页工具栏--%>
    <div id="pager"></div>
</div>





