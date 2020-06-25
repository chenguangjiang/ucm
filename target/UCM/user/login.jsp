<%@page pageEncoding="UTF-8" isELIgnored="false" contentType="text/html; UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>登录</title>

    <!--引入bootstrap css-->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/back/statics/bootstrap/css/bootstrap.min.css">
    <!--引入jquery核心js-->
    <script src="${pageContext.request.contextPath}/back/statics/js/jquery-3.4.1.min.js"></script>
    <!--引入bootstrap组件js-->
    <script src="${pageContext.request.contextPath}/back/statics/bootstrap/js/bootstrap.min.js"></script>

    <script>
        $(function() {
            // 设置属性
            $('.carousel').carousel({
                interval: 4000,
            });
        });
       function login() {
            var name = $("#name").val();
            var password=$("#password").val();
            var code=$("#code").val();
            if(name==""||password==""||code==""){
                alert("请输入完整信息");
            }else
                {
                    $('#tishi').empty();
                $.ajax({
                    url:'${pageContext.request.contextPath}/user/login',
                    method:'get',
                    data:{'name':name,"password":password,"code":code},
                    dataType:'json',
                    success:function (data) {
                        if (data.code==200)
                        {
                            window.location.href="${pageContext.request.contextPath}/front/main/main.jsp";
                            $('#tishi').append('<p style="color: red">'+data.message+'<p>');
                        }
                        if (data.code==201)
                        {
                            window.location.href="${pageContext.request.contextPath}/back/home/home.jsp";
                            $('#tishi').append('<p style="color: red">'+data.message+'<p>');
                        }
                        if (data.code == 202||203) {
                            $('#tishi').empty();
                            $('#tishi').append('<p style="color: red">'+data.message+'<p>');
                        }
                    }
                });
            }
        };

    </script>

</head>
<body>
<div class="container-fluid" >
    <div class="row">
        <!-- 左边部分 -->
        <div class="col-sm-4 hidden-xs" >
            <!--轮播图-->
            <div id="aa" class="carousel slide center-block" style="height:100%; width:100%;" data-ride="carousel">

                <!--轮播图索引-->
                <ol class="carousel-indicators">
                    <li data-target="#aa" data-slide-to="0" class="active"></li>
                    <li data-target="#aa" data-slide-to="1"></li>
                    <li data-target="#aa" data-slide-to="2"></li>
                </ol>

                <!--轮播图片-->
                <div class="carousel-inner" aa>
                    <!--轮播图片一个个选项-->
                    <div class="item active">
                        <img src="${pageContext.request.contextPath}/image/p1.jpg" alt="这是一个图片" aa>
                    </div>

                    <div class="item">
                        <img src="${pageContext.request.contextPath}/image/p2.jpg" alt="这是一个图片" />
                    </div>

                    <div class="item">
                        <img src="${pageContext.request.contextPath}/image/p3.jpg" alt="这是一个图片">
                    </div>

                </div>


            </div>
        </div>
        <!-- 右边部分 -->
        <div class="col-sm-8" >
            <!-- 返回按钮 -->
            <div style="margin-top: 2%; margin-left: 93%;">
                <a href="${pageContext.request.contextPath}/front/main/main.jsp">
                    <button type="button" class="btn btn-default">
                        <span class="glyphicon glyphicon-home" aria-hidden="true"></span>
                    </button>
                </a>
            </div>


            <div style="margin-top: 10%; margin-bottom: 7%; margin-left:45%;">
                <h1>欢迎登录<small>UCM</small></h1>
            </div>

            <div class="col-sm-3">
            </div>

            <!-- forme表单 -->
            <div class="col-sm-7">
                <%--<form class="form-horizontal" >--%>
                    <div class="form-group">
                        <label for="name" class="col-sm-2 control-label">用户名</label>
                        <div class="col-sm-10">
                            <input type="username" class="form-control" id="name" placeholder="Username" name="name" style="width: 90%;">
                        </div>
                    </div>
                    <br>
                    <br>
                    <div class="form-group">
                        <label for="password" class="col-sm-2 control-label">密码</label>
                        <div class="col-sm-10">
                            <input type="password" class="form-control" id="password" placeholder="Password"name="password" style="width: 90%;">
                        </div>
                    </div>
                    <br>
                    <br>
                    <div class="form-group">
                        <label for="code" class="col-sm-2 control-label ">验证码</label>
                        <div class="col-sm-10 ">
                            <input type="text" class="form-control" id="code" placeholder="Verification" name="code" style="width: 90%;">
                            </br>
                            <div class="row">
                                <div class="col-sm-4">
                            <img onclick="this.src='${pageContext.request.contextPath}/user/getImageCode?d='+new Date()*1" src="${pageContext.request.contextPath}/user/getImageCode"/>
                                </div>
                                <div class="col-sm-5">
                            <span id="tishi"></span>
                                </div>
                            </div>
                            <br/>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-offset-2 col-sm-10">
                            <button  onclick="login()" class="btn btn-success btn-lg" style="width: 90%;">登录</button>
                            <br>
                            <div class="col-sm-offset-7">
                                <a href="${pageContext.request.contextPath}/user/searchpassword.jsp" style="color: #9b9ea0; font-size: 0.9em; ">忘记密码?</a>
                                &nbsp;<span>|</span>&nbsp;
                                <a href="${pageContext.request.contextPath}/user/updatepassword.jsp" style="color: #9b9ea0; font-size: 0.9em; ">修改密码</a>
                            </div>

                        </div>
                    </div>
                <%--</form>--%>
            </div>

            <div class="col-sm-2">
            </div>

        </div>

    </div>
</div>
</body>
</html>
