<%@page pageEncoding="UTF-8" isELIgnored="false" contentType="text/html; UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.jcg.entity.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>重置密码</title>

    <!--引入bootstrap css-->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/back/statics/bootstrap/css/bootstrap.min.css">
    <!--引入jquery核心js-->
    <script src="${pageContext.request.contextPath}/back/statics/js/jquery-3.4.1.min.js"></script>
    <!--引入bootstrap组件js-->
    <script src="${pageContext.request.contextPath}/back/statics/bootstrap/js/bootstrap.min.js"></script>

    <script>
        $(function () {

            var aaa;

            $("#btn").click(function () {
                console.log("开启定时发送请求");
                //发送ajax轮询  每隔几秒发送一次ajax请求
                aaa = setInterval(function () {
                    //ajax查询当前用户文件记录的下载次数并更新页面
                    $.post("${pageContext.request.contextPath}/filelog/findAllJSON",function(result){
                        console.log(result); //3对象
                        //遍历
                        $.each(result,function(i,filelog){
                            //根据当前遍历id获取指定span标签进行修改下载次数
                            $("#"+filelog.id).text(filelog.downcounts);
                        });
                    },"JSON");
                },3000);
            });



            $("#closeBtn").click(function(){
                console.log("关闭执行.....")
                //关闭时间周期执行
                clearInterval(aaa);
            });



        });
    </script>
</head>
<br>
<nav class="navbar navbar-default navbar-fixed-top">
    <div class="container">
        <div class="navbar-header">
            <a href="/" class="navbar-brand"><img src="image/logo.png" alt="" class="img-responsive"></a>
            <button class="navbar-toggle" type="button" data-toggle="collapse" data-target="#navbar-collapse">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
        </div>
        <div class="collapse navbar-collapse" id="navbar-collapse">
            <ul class="nav navbar-nav navbar-right">
                <li class="active"><a href="${pageContext.request.contextPath}/front/main/main.jsp">首页</a></li>
                <li><a href="#"><span class="glyphicon glyphicon-user" id="username">&nbsp;${user.name}</span></a></li>
            </ul>
        </div>
    </div>
</nav>
<body>

<hr>
<div class="project-headrd page-header text-left">
    <h2>下载记录</h2>
</div>
<table class="table table-bordered">
    <thead>
    <tr>
        <%--<th>ID</th>--%>
        <th>原始文件名</th>
        <th>新文件名</th>
        <th>扩展名</th>
        <th>大小</th>
        <th>文件类型</th>
        <th>下载日期</th>
        <th>操作</th>
    </tr>
    </thead>
    <c:forEach items="${requestScope.fileLogs}" var="fileLog">
        <tr>
                <%--<td>${fileLog.id}</td>--%>
            <td>${fileLog.oldFileName}</td>
            <td>${fileLog.newFileName}</td>
            <td>${fileLog.ext}</td>
            <td>${fileLog.filesize}</td>
            <td>${fileLog.contentType}</td>
            <td>${fileLog.uploadDate}</td>
            <td><a href="${pageContext.request.contextPath}/filelog/delete?id=${fileLog.id}">删除</a>
        </tr>
    </c:forEach>
</table>

<hr>
</body>
</html>