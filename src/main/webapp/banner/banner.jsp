<%@page pageEncoding="UTF-8" isELIgnored="false" contentType="text/html; UTF-8" %>

<script>
    $(function () {
        // 初始化表格并展示所有
        $("#bannerList").jqGrid({
            height:300,
            styleUI:"Bootstrap",
            autowidth:true,
            url:"${pageContext.request.contextPath}/banner/findAll",
            datatype:"json",
            colNames:["编号","标题","图片","超链接","创建时间","描述","状态"],
            colModel:[
                {name:"id",search:false,hidden:true,align:"center"},
                {name:"title",editable:true,align:"center",editrules:{required:true}},
                {name:"url",search:false,editable:true,align:"center",
                    formatter(data){
                    return "<img style='width: 100%' src='"+data+"'/>"
                    },editable:true,edittype:"file",editoptions:{enctype:"multipart/form-data"}
                },
                {name:"href",search:false,editable:true,align:"center"},
                {name:"ldate",search:false,editable:true,align:"center"},
                {name:"ldesc",search:false,editable:true,align:"center"},
                {name:"lstatus",editable:true,align:"center",
                    formatter:function (data) {
                        if (data==1) {
                            return "展示";
                        }
                        else return "冻结";
                    },editable:true,edittype:"select",editoptions:{value:"1:展示;2:冻结"}
                }
            ],
            pager:"#pager",
            viewrecords:true,
            rowNum:5,
            rowList:[5,10,15],
            editurl:"${pageContext.request.contextPath}/banner/edit",


        });$("#bannerList").jqGrid('navGrid','#pager',
            {edit:true,add:true,del:true,edittext:"编辑",addtext:"添加",deltext:"删除"},
            //edit add del
            {
                //frm->表单对象
                beforeShowForm:function (frm) {
                    
                }
                },{ afterSubmit:function (response) {
                    var bannerId = response.responseJSON.bannerId;
                    $.ajaxFileUpload({
                        url:"${pageContext.request.contextPath}/banner/upload",
                        datatype:"json",
                        type:"post",
                        data:{bannerId:bannerId},
                        //指定上传input框id
                        fileElementId:"url",
                        success:function(data){
                            //输出上传成功

                            //重新载入
                        }
                    })

                  }
            });
    });
    //修改
    function editRow(id) {
        console.log(id);
        $("#bannerList").jqGrid('editGridRow',id, {
            height : 400,
            reloadAfterSubmit : true,
            closeAfterEdit:true,
        });
    }
    //删除
    function delRow(id) {
        if (window.confirm("你确定要删除吗?")){
            //发送ajax请求时删除
            $.post("${pageContext.request.contextPath}/banner/edit",{id:id,oper:"del"},function () {
                //刷新页面
                $("#bannerList").trigger('reloadGrid');//刷新表格
            });
        };
    };
    // //添加
    // function saveRow() {
    //     $("#bannerList").jqGrid('editGridRow', "new", {
    //         height : 400,
    //         reloadAfterSubmit : true,
    //         closeAfterAdd:true
    //
    //     });
    // }

</script>

<!--页头-->
<div class="page-header" style="margin-top: -20px">
    <h1>轮播列表</h1>
</div>


<div class="col-sm-10">
    <%--设备列表--%>
    <table id="bannerList"></table>
    <%--分页工具栏--%>
    <div id="pager"></div>
</div>





