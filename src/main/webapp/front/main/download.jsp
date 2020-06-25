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
    <title>文件下载</title>

    <!--引入bootstrap css-->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/back/statics/bootstrap/css/bootstrap.min.css">
    <!--引入jquery核心js-->
    <script src="${pageContext.request.contextPath}/back/statics/js/jquery-3.4.1.min.js"></script>
    <!--引入bootstrap组件js-->
    <script src="${pageContext.request.contextPath}/back/statics/bootstrap/js/bootstrap.min.js"></script>

    <script>
        $(function () {

            var aaa;


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
                },1000);




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
                <li><a href="#"><span class="glyphicon glyphicon-user">${user.name}</span></a></li>
            </ul>
        </div>
    </div>
</nav>
<body>

</br>
</br>

<hr>
<div class="project-headrd page-header text-center">
    <h2>下载文件专区</h2>
    <p>同学们可以自行下载自己所需要的文件</p>
</div>
<table class="table table-bordered">
    <thead>
    <tr>
        <%--<th>ID</th>--%>
        <th>文件名</th>
        <th>扩展名</th>
        <th>大小(字节)</th>
        <th>文件类型</th>
        <th>下载次数</th>
        <%--<th>是否是图片</th>--%>
        <th>上传时间</th>
        <th>操作</th>
    </tr>
    </thead>
    <c:forEach items="${requestScope.fileLogs}" var="fileLog">
        <tr>
                <%--<td>${fileLog.id}</td>--%>
            <td>${fileLog.oldFileName}</td>
            <td>${fileLog.ext}</td>
            <td>${fileLog.filesize}</td>
            <td>${fileLog.contentType}</td>
            <td><span id="${fileLog.id}">${fileLog.downcounts}</span></td>
            <%--<td>--%>
                <%--&lt;%&ndash;<c:if test="${fileLog.isImage}">&ndash;%&gt;--%>
                    <%--&lt;%&ndash;<img src="${pageContext.request.contextPath}${fileLog.path}/${fileLog.newFileName}" style="width:50px;height: 50px;"/>&ndash;%&gt;--%>
                <%--&lt;%&ndash;</c:if>&ndash;%&gt;--%>
                <%--&lt;%&ndash;<c:if test="${!fileLog.isImage}">&ndash;%&gt;--%>
                    <%--&lt;%&ndash;<font color="red">否</font>&ndash;%&gt;--%>
                <%--&lt;%&ndash;</c:if>&ndash;%&gt;--%>
            <%--</td>--%>
            <td>${fileLog.uploadDate}</td>
            <td>
                <a href="${pageContext.request.contextPath}/filelog/download?id=${fileLog.id}">下载</a>
                <a href="${pageContext.request.contextPath}/filelog/download?id=${fileLog.id}&openStyle=inline">预览</a> </td>
        </tr>
    </c:forEach>
</table>

<hr>
</body>
</html>