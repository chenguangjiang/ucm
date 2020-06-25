<%@page pageEncoding="UTF-8" isELIgnored="false" contentType="text/html; UTF-8" %>
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
        var wait = 60;
        function time(o) {
            if (wait == 0) {
                o.removeAttribute("disabled");
                o.innerHTML = "获取验证码";
                wait = 60;
            } else {
                o.setAttribute("disabled", true);
                o.innerHTML = wait + "秒";
                wait--;
                setTimeout(function() {
                    time(o)
                }, 1000)
            }
        }
        // 获取验证码
        function returncode() {
            var name = $("input[name='name']").val();
            var phone = $("input[name='phone']").val();
            var wait = 60;
            if(name==""||phone==""){//JS中正则表达式的test方法用来验证是否与该正则表达式匹配，匹配就返回true，不匹配就返回false
                alert("请输入完整信息");
            }else {
            $.ajax({
                url:"${pageContext.request.contextPath}/user/returncode",
                data:{"name":name,"phone":phone},
                dataType: 'json',
                method: 'get',
                success: function (msg) {
                    if (msg.code == 201) {
                        $('#tishi').empty();
                        $('#tishi').append('<p style="color: red">'+msg.message+'<p>');
                    }
                    if (msg.code == 200) {
                        $('#tishi').empty();
                        $('#tishi').append('<p style="color: red">'+msg.message+'<p>');
                        var o= document.getElementById("code");
                        o.setAttribute("disabled", true);
                        time(o)
                    }
                }
            });
          };
        }
        // 验证验证码
        function confirm() {
            var name = $("input[name='name']").val();
            var code = $("input[name='code']").val();
            var phone = $("input[name='phone']").val();
            if(name==""||phone==""||name==""){//JS中正则表达式的test方法用来验证是否与该正则表达式匹配，匹配就返回true，不匹配就返回false
                alert("请输入完整信息");
            }else {
                $.ajax({
                    url:"${pageContext.request.contextPath}/user/confirm",
                    data:{"code":code,"phone":phone},
                    dataType: 'json',
                    method: 'get',
                    success: function (msg) {
                        if (msg.code == 201) {
                            $('#tishi').empty();
                            $('#tishi').append('<p style="color: red">'+msg.message+'<p>');
                        }
                        if (msg.code == 200) {
                            window.location.href="${pageContext.request.contextPath}/user/newpassword.jsp";
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
</br>
</br>
<div class="container-fluid">
<div class="row">
    <div class="project-headrd page-header text-center">
        <h2>重置密码</h2>
    </div>
</div>
    </br>
    <div class="row" >
        <p class="text-center">请输入要重置该账号所绑定的手机号码</p>
    </div>
    </br>
<div class="row">
    <div class="col-sm-4">
    </div>
    <div class="col-sm-4">
        <span id="tishi"></span>
        <div class="form-group">
                <input type="username" class="form-control" id="name" placeholder="Username" name="name" style="width: 100%;height: 40px">
        </div>
        </br>

        <div class="form-group">
            <div class="input-group">
                <span class="input-group-addon" id="basic-addon1">+86</span>
                <input type="text" class="form-control" name="phone" placeholder="手机号" style="height: 40px" aria-describedby="basic-addon1">
            </div>
            </br>
            </br>
            <div class="form-group">
                <div class="col-sm-8">
                    <div class="input-group">
                        <input type="text" class="form-control" name="code" placeholder="验证码" style="height: 40px" aria-describedby="basic-addon1">
                    </div>
                </div>
                <div class="col-sm-4">
                    <button  id="code" class="btn btn-default btn-lg" onclick="returncode()" style="width: 100%;">获取验证码</button>
                </div>
            </div>
            </br>
            </br>
            </br>
            <button  id="send" class="btn btn-primary btn-lg" onclick="confirm()" style="width: 100%;">确定</button>
        </div>

    </div>
    <div class="col-sm-4">
    </div>
</div>
</div>
</body>
</html>
