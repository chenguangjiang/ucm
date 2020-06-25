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
    <title>我的预约</title>

    <!--引入bootstrap css-->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/back/statics/bootstrap/css/bootstrap.min.css">
    <!--引入jquery核心js-->
    <script src="${pageContext.request.contextPath}/back/statics/js/jquery-3.4.1.min.js"></script>
    <!--引入bootstrap组件js-->
    <script src="${pageContext.request.contextPath}/back/statics/bootstrap/js/bootstrap.min.js"></script>

    <script>

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
    <h2>预约信息</h2>
</div>
<table class="table table-bordered">
    <thead>
    <tr>
        <%--<th>ID</th>--%>
        <th  class="text-center">上课时间</th>
        <th class="text-center">星期</th>
        <th class="text-center">机房</th>
        <th class="text-center">课节</th>
        <th class="text-center">班级</th>
        <th class="text-center">课程</th>
        <th class="text-center">操作</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${subscribles}" var="s">
        <tr>
                <%--<td>${fileLog.id}</td>--%>
            <td class="text-center">${s.time}</td>
            <td class="text-center">${s.week}</td>
            <td class="text-center">${s.room}</td>
            <td class="text-center">${s.phases}</td>
            <td class="text-center">${s.classes}</td>
            <td class="text-center">${s.curriculum}</td>
            <td class="text-center"><a href="${pageContext.request.contextPath}/subscrible/delete?id=${s.id}"><button class="btn btn-danger">取消预约</button></a></td>
        </tr>
    </c:forEach>
    </tbody>
</table>

<hr>
<%--<!--上机申请模态框-->--%>
<%--<div class="modal fade" id="aplicant" tabindex="-1" role="dialog">--%>
    <%--<div class="modal-dialog" role="document">--%>
        <%--<div class="modal-content">--%>
            <%--<div class="modal-header">--%>
                <%--<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span--%>
                        <%--aria-hidden="true">&times;</span>--%>
                <%--</button>--%>
                <%--<h4 class="modal-title">预约机房</h4>--%>
            <%--</div>--%>
            <%--<div class="form-group">--%>
                <%--<label for="inputPassword1" class="col-sm-2 control-label"></label>--%>
            <%--</div>--%>
            <%--<div class="modal-body">--%>
                <%--<form class="form-horizontal">--%>
                    <%--<div class="form-group">--%>
                        <%--<div class="row">--%>
                            <%--<div class="col-sm-2" style="margin-left: 30px">--%>
                                <%--<label>选择日期</label>--%>
                            <%--</div>--%>
                            <%--<div class="col-sm-4" style="margin-left: -20px">--%>
                                <%--<!--指定 date标记-->--%>
                                <%--&lt;%&ndash;<input id="smeet" name="time" type="datetime-local"  />&ndash;%&gt;--%>
                                <%--<div class='input-group date' id='datetimepicker2'>--%>
                                    <%--<input type='text' class="form-control" id="time" name="time"/>--%>

                                    <%--<span class="input-group-addon">--%>
                                        <%--<a tabindex="0" role="button" data-toggle="popover" data-trigger="focus"--%>
                                           <%--title="温馨提示" data-container="body" data-placement="right"--%>
                                           <%--data-content="只能预约本月内的时间段哦">--%>
                                     <%--<span class="glyphicon glyphicon-calendar"></span>--%>
                                        <%--</a>--%>
                                    <%--</span>--%>

                                <%--</div>--%>

                            <%--</div>--%>
                        <%--</div>--%>
                    <%--</div>--%>
                    <%--<div class="form-group">--%>
                        <%--<label for="inputPassword1" class="col-sm-2 control-label">课节</label>--%>
                        <%--<div class="col-sm-10">--%>
                            <%--<select name="phases" id="select">--%>
                                <%--<option value="1-2节">1-2节</option>--%>
                                <%--<option value="3-4节">3-4节</option>--%>
                                <%--<option value="5-6节">5-6节</option>--%>
                                <%--<option value="7-8节">7-8节</option>--%>
                                <%--<option value="9-10节">9-10节</option>--%>
                            <%--</select>--%>
                        <%--</div>--%>
                    <%--</div>--%>
                    <%--<div class="form-group">--%>
                        <%--<label for="inputPassword1" class="col-sm-2 control-label">教室</label>--%>
                        <%--<div class="col-sm-10">--%>
                            <%--<select name="room" id="select1">--%>

                            <%--</select>--%>
                        <%--</div>--%>
                    <%--</div>--%>
                    <%--<div class="form-group">--%>
                        <%--<label for="inputPassword1" class="col-sm-2 control-label">课程</label>--%>
                        <%--<div class="col-sm-10">--%>
                            <%--<input type="text" class="form-control" id="curriculum" name="curriculum">--%>
                        <%--</div>--%>
                    <%--</div>--%>
                    <%--<div class="form-group">--%>
                        <%--<label for="inputPassword1" class="col-sm-2 control-label">班级</label>--%>
                        <%--<div class="col-sm-10">--%>
                            <%--<input type="text" class="form-control" id="classes" name="classes">--%>
                        <%--</div>--%>
                    <%--</div>--%>
                    <%--<div class="form-group">--%>
                        <%--<label for="inputPassword1" class="col-sm-2 control-label">申请人</label>--%>
                        <%--<div class="col-sm-10">--%>
                            <%--<input type="text" class="form-control" id="inputPassword1" value="${user.name}" disabled="disabled" name="name">--%>
                        <%--</div>--%>
                    <%--</div>--%>

                    <%--<div class="modal-footer">--%>
                        <%--<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>--%>
                        <%--<button type="button" onclick="yyjk()" class="btn btn-primary">提交</button>--%>
                    <%--</div>--%>
                <%--</form>--%>
            <%--</div>--%>
        <%--</div>--%>
    <%--</div>--%>
<%--</div>--%>
</body>
</html>