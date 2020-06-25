<%@page pageEncoding="UTF-8" isELIgnored="false" contentType="text/html; UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>修改密码</title>

    <!--引入bootstrap css-->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/back/statics/bootstrap/css/bootstrap.min.css">
    <!--引入jquery核心js-->
    <script src="${pageContext.request.contextPath}/back/statics/js/jquery-3.4.1.min.js"></script>
    <!--引入bootstrap组件js-->
    <script src="${pageContext.request.contextPath}/back/statics/bootstrap/js/bootstrap.min.js"></script>

    <script>

        function updatepassword() {
            var name = $("input[name='name']").val();
            var password = $("input[name='password']").val();
            var password2 = $("input[name='password2']").val();
            if(name==""||password==""||password2==""){//JS中正则表达式的test方法用来验证是否与该正则表达式匹配，匹配就返回true，不匹配就返回false
                alert("请输入完整信息");
            }else {
                $.ajax({
                    url:"${pageContext.request.contextPath}/user/updatepassword",
                    data:{"name":name,"password":password,"password2":password2},
                    dataType: 'json',
                    method: 'post',
                    success: function (msg) {
                        if (msg.code == 300) {
                            $('#tishi').empty();
                            $('#tishi').append('<p style="color: red">'+msg.message+'<p>');
                        }
                        if (msg.code == 200) {
                            window.location.href="${pageContext.request.contextPath}/user/login.jsp";
                        }
                    }
                });
            };
        }
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
                <li><a href="${pageContext.request.contextPath}/user/login.jsp"><span class="glyphicon glyphicon-log-in">  登录</span></a></li>
            </ul>
        </div>
    </div>
</nav>
</br>
</br>
<div class="container-fluid">
    <div class="row">
        <div class="project-headrd page-header text-center">
            <h2>修改密码</h2>
        </div>
    </div>
    <div class="row" >
        <p class="text-center">请输入原始密码和新的密码</p>
    </div>
    </br>
    <div class="row">
        <div class="col-sm-4">
        </div>
        <div class="col-sm-4">
            <span id="tishi"></span>
            <div class="form-group">
                <label>用户名</label>
                <input type="username" class="form-control" id="name" placeholder="Username" name="name" style="width: 100%;height: 40px">
            </div>
            </br>
            <div class="form-group">
                <label>原始密码</label>
                <input type="password" class="form-control" name="password" placeholder="Password" style="height: 40px;" aria-describedby="basic-addon1">
            </div>
            </br>
            <div class="form-group">
                <label>新密码</label>
                <input type="password" class="form-control" name="password2" placeholder="NewPassword" style="height: 40px" aria-describedby="basic-addon1">
            </div>
            </br>
            <button  id="send" class="btn btn-primary btn-lg" onclick="updatepassword()" style="width: 100%;">确认修改</button>
        </div>

    </div>
    <div class="col-sm-4">
    </div>
</div>
</div>
</body>
</html>
