<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page pageEncoding="UTF-8" isELIgnored="false" contentType="text/html; UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>后台管理</title>
    <!--引入bootstrap css-->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/back/statics/bootstrap/css/bootstrap.min.css">
    <!--引入jqgrid的bootstrap css-->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/back/statics/jqgrid/css/ui.jqgrid-bootstrap.css">
    <!--引入jquery核心js-->
    <script src="${pageContext.request.contextPath}/back/statics/js/jquery-3.4.1.min.js"></script>
    <!--引入jqgrid核心js-->
    <script src="${pageContext.request.contextPath}/back/statics/jqgrid/js/jquery.jqGrid.min.js"></script>
    <!--引入jqgrid国际化js-->
    <script src="${pageContext.request.contextPath}/back/statics/jqgrid/i18n/grid.locale-cn.js"></script>
    <script src="${pageContext.request.contextPath}/back/statics/jqgrid/js/ajaxfileupload.js"></script>
    <!--引入bootstrap组件js-->
    <script src="${pageContext.request.contextPath}/back/statics/bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="http://cdn.goeasy.io/goeasy-1.0.3.js"></script>

    <script>
        $(function(){
            //切换样式
            $(".list-group").on("click",".list-group-item",function(){
                //去掉所有
                $(".list-group-item").removeClass().addClass("list-group-item");
                //点击激活
                $(this).addClass("active");
            })

            $.post("${pageContext.request.contextPath}/equipment/information",function (data) {
                //遍历所有消息

                $.each(data,function(i,n){
                    var $tr = $("<tr id='i'>"+
                        "<td id='atime'>"+n.atime+"</td>"+
                        "<td id='room'>"+n.machineroom+"</td>"+
                        "<td>"+n.ip+"</td>"+
                        "<td>"+n.remark+"</td>"+
                        "<td>"+n.aname+"</td>"+
                        "<td><button onclick=\" del('"+n.atime+"','"+n.machineroom+"','"+n.ip+"','"+n.remark+"','"+n.aname+"') \" class='btn btn-danger'>删除</button></td>"+
                        "</tr>");
                    var $table = $('table tbody');
                    $table.append($tr);
                })
            },"JSON");
        });
        //删除
        function del(a,b,c,d,e) {
            var $table = $('table tbody');
            $table.empty();
            $.post('${pageContext.request.contextPath}/equipment/deletereaction',{"atime":a,"machine":b,"ip":c,"remark":d,"aname":e},function (data) {

                if(data.code==200){
                    alert("删除成功");
                    $.post("${pageContext.request.contextPath}/equipment/information",function (data) {
                        $.each(data,function(i,n){
                            var $tr = $("<tr>"+
                                "<td >"+n.atime+"</td>"+
                                "<td>"+n.machineroom+"</td>"+
                                "<td>"+n.ip+"</td>"+
                                "<td>"+n.remark+"</td>"+
                                "<td>"+n.aname+"</td>"+
                                "<td><button onclick=\" del('"+n.atime+"','"+n.machineroom+"','"+n.ip+"','"+n.remark+"','"+n.aname+"') \" class='btn btn-danger'>删除</button></td>"+
                                "</tr>");
                            var $table = $('table tbody');
                            $table.append($tr);
                        })
                    },"JSON");
                }
            });
        }
    //接收预约成功
        //goeasy
        var goEasy = new GoEasy({
            host:"hangzhou.goeasy.io",
            appkey: "BS-69f0f3cb479a4383a5ad1654128bbe06",
        });
        // 接受消息
        goEasy.subscribe({
            channel: "jcg",
            onMessage: function (message) {
                alert("提示："+message.content);
            }
        });
        //接收上传成功
        //goeasy
        var goEasy2 = new GoEasy({
            host:"hangzhou.goeasy.io",
            appkey: "BS-7d64d828e680433fad13d09a3ea62796",
        });
        // 接受消息
        goEasy2.subscribe({
            channel: "jcg2",
            onMessage: function (date) {
                alert("上传结果："+date.content);
            }
        });

</script>


</head>
<body>
<!--导航栏-->
<nav class="navbar navbar-inverse navbar-fixed-top">
    <div class="container-fluid">

        <div class="navbar-header">
            <a class="navbar-brand" href="../home/home.jsp">大学机房管理系统 <small>UCM</small></a>
        </div>


        <div class="collapse navbar-collapse " id="bs-example-navbar-collapse-1" >
            <ul class="nav navbar-nav navbar-right">
                <li ><a href="javascript:void(0)" data-toggle="modal" data-target="#upload"><span class="glyphicon glyphicon-floppy-open"> 文件上传</span></a></li>
                <li ><a href="#" data-toggle="modal" data-target="#information" ><span class="glyphicon glyphicon-envelope" id="xx">  消息

                </span></a></li>
                <li ><a href="#"><span class="glyphicon glyphicon-user"> ${user.name}</span></a></li>
                <li ><a href="${pageContext.request.contextPath}/user/clearname"><span class="glyphicon glyphicon-log-out">  退出</span></a></li>
            </ul>
        </div>
    </div>
</nav>
<br>
<br>
<br>
<!--布局系统 中心内容-->
<div class="container-fluid">
    <div class="row">
        <!--菜单-->
        <div class="col-sm-2">
            <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="headingOne">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                                机房管理
                            </a>
                        </h4>
                    </div>
                    <div id="collapseOne" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingOne">
                        <div class="panel-body">
                            <div class="list-group">
                                <a href="javascript:$('#content').load('${pageContext.request.contextPath}/back/machineRoom/machineroom.jsp')"  class="list-group-item active">
                                    机房列表
                                </a>
                            </div>

                        </div>
                    </div>
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="headingTwo">
                        <h4 class="panel-title">
                            <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                                设备管理
                            </a>
                        </h4>
                    </div>
                    <div id="collapseTwo" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
                        <div class="panel-body">
                            <div class="list-group">
                                <a href="javascript:$('#content').load('${pageContext.request.contextPath}/back/equipment/equipment.jsp');" class="list-group-item active">
                                    设备列表
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="headingThree">
                        <h4 class="panel-title">
                            <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                                课程管理
                            </a>
                        </h4>
                    </div>
                    <div id="collapseThree" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingThree">
                        <div class="panel-body">
                            <div class="list-group">

                                <a href="javascript:$('#content').load('${pageContext.request.contextPath}/back/course/list.jsp?name=courseList');" id="btn" class="list-group-item active">
                                    课程列表
                                </a>
                                <a href="javascript:$('#content').load('${pageContext.request.contextPath}/back/course/list.jsp?name=manualinput');" class="list-group-item">
                                    导出模板
                                </a>
                                <%--<button class="list-group-item">导出课程模板</button>--%>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="headingFour">
                        <h4 class="panel-title">
                            <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseFour" aria-expanded="false" aria-controls="collapseFour">
                                用户管理
                            </a>
                        </h4>
                    </div>
                    <div id="collapseFour" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingFour">
                        <div class="panel-body">
                            <div class="list-group">
                                <a href="javascript:$('#content').load('${pageContext.request.contextPath}/user/list.jsp');" class="list-group-item active">
                                    用户列表
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="headingFive">
                        <h4 class="panel-title">
                            <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseFive" aria-expanded="false" aria-controls="collapseFive">
                                轮播管理
                            </a>
                        </h4>
                    </div>
                    <div id="collapseFive" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingFive">
                        <div class="panel-body">
                            <div class="list-group">
                                <a href="javascript:$('#content').load('${pageContext.request.contextPath}/banner/banner.jsp');" class="list-group-item active">
                                    轮播列表
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--中心内容-->
        <div id="content">
            <div class="col-sm-10">

                <!--巨幕-->
                <div class="jumbotron">
                    <h1>Hello, world!</h1>
                    <p>This is the homepage of computer room management system, simple and efficient operation.<br>
                        Let your work not be tedious........</p>
                    <p><a class="btn btn-primary btn-lg" href="#" role="button">Learn more</a></p>
                </div>

                <!--带有按钮警告框-->
                <div class="alert alert-danger alert-dismissible" role="alert">
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h3>Warning!</h3>
                    <p>Better check yourself, you're not looking too good.</p>
                    <p>
                        <button class="btn btn-danger">立即处理</button>
                        <button class="btn btn-default">稍后修复</button>
                    </p>
                </div>

                <!--面板 带有标题面板-->
                <div class="panel panel-default">
                    <div class="panel-heading">系统状态:</div>
                    <div class="panel-body">
                        <!--进度条-->
                        <label for="">系统使用率:</label>
                        <div class="progress">
                            <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="40" aria-valuemin="0" aria-valuemax="100" style="width: 40%">
                                40%<span class="sr-only">40% Complete (success)</span>
                            </div>
                        </div>
                        <label for="">CPU使用率:</label>
                        <div class="progress">
                            <div class="progress-bar progress-bar-info" role="progressbar" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100" style="width: 20%">
                                20%<span class="sr-only">20% Complete</span>
                            </div>
                        </div>
                        <label for="">磁盘使用率:</label>
                        <div class="progress">
                            <div class="progress-bar progress-bar-warning" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 60%">
                                60%<span class="sr-only">60% Complete (warning)</span>
                            </div>
                        </div>
                        <label for="">数据库使用率:</label>
                        <div class="progress">
                            <div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="80" aria-valuemin="0" aria-valuemax="100" style="width: 80%">
                                80%<span class="sr-only">80% Complete (danger)</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
<div>
    <!--消息模态框-->
    <div class="modal fade" id="information" tabindex="-1" role="dialog"  >
        <div class="modal-dialog" role="document" >
            <div class="modal-content" style="width: 800px">
                <div class="modal-header" >
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title">问题反馈</h4>
                </div>
                <div class="modal-body">
                    <table class="table table-bordered" style="width: 750px">
                        <thead>
                        <tr>
                            <th>时间</th>
                            <th>教室</th>
                            <th>机器ip</th>
                            <th width="200px">问题描述</th>
                            <th>反馈者</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody>

                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <%--文件上传--%>
    <div class="modal fade" id="upload" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">上传文件</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal" action="${pageContext.request.contextPath}/filelog/save" method="post"  enctype="multipart/form-data">
                        <div class="form-group">
                            <label >File input</label>
                            <input type="file" class="form-control" name="aaa" id="file1" >
                        </div>
                        </br>
                        <div class="form-group">
                            <div>
                                <h4>温馨提示</h4>
                                <p class="help-block">文件大小限制2G</p>
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
</body>
</html>