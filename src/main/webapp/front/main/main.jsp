<%@ page import="com.jcg.entity.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page pageEncoding="UTF-8" isELIgnored="false" contentType="text/html; UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>机房管理首页</title>

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
    <!--引入bootstrap组件js-->
    <script src="${pageContext.request.contextPath}/back/statics/bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="http://cdn.goeasy.io/goeasy-1.0.3.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/back/statics/bootstrap/css/bootstrap-datetimepicker.min.css">
    <script src="${pageContext.request.contextPath}/back/statics/js/moment-with-locales.min.js"></script>
    <script src="${pageContext.request.contextPath}/back/statics/bootstrap/js/bootstrap-datetimepicker.min.js"></script>

    <%--查询所有房间名--%>
    <script>

        $(function () {
                var i;
                      //查询所有房间
            $.post("${pageContext.request.contextPath}/machineroom/findMachineroomName",function (result) {
                //遍历所有房间
                $.each(result,function (i,machineroomList) {
                    var option = $("<option/>").val(machineroomList.name).text(machineroomList.name);
                    var input = $("<input/>").val(machineroomList.id).attr({"type":"radio","name":"machineroom"})

                    $("#machineSpan").append(input).append(machineroomList.name).append("</br></br></br>");
                    $("#select2").append(option);
                });

            },"JSON");
            //查询所有房间
            $.post("${pageContext.request.contextPath}/machineroom/findMachineroomName",function (result) {
                //遍历所有房间
                $.each(result,function (i,machineroomList) {
                    var option = $("<option/>").val(machineroomList.name).text(machineroomList.name);
                    $("#select1").append(option);
                });
            },"JSON");

            $("input[name='weeks']").click(function () {
               get();
               qingk();
            });
            // 日期控件
            $("#datetimepicker2").datetimepicker({
                language:  'zh-CN',
                format: "yyyy-mm-dd",
                minView: "month",
                maxView:31,
                autoclose: true,
                todayBtn: true,
                pickerPosition: "bottom-left",
                startDate:new Date,
            })
            //日期提示
            $(function () {
                $('[data-toggle="popover"]').popover()
            })
            $('#example').popover(options)


        });/*end*/
        //反馈信息
        function fank() {
            var ip  = $("input[name='ip']").val();
            var remark  = $("textarea[name='remark']").val();
            var aname  = $("input[name='aname']").val();
            var machineroom  = $("select[name='machineroom']").val();
            var exp=/^(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])$/;
            var reg = ip.match(exp);
            if(ip==""||aname==""||remark==""){//JS中正则表达式的test方法用来验证是否与该正则表达式匹配，匹配就返回true，不匹配就返回false
                alert("请输入完整信息");
            }else {
                if (reg==null)
                {
                    alert("请输入正确的ip地址");
                }else {
                $.ajax({
                    url: '${pageContext.request.contextPath}/equipment/reaction',
                    method: 'get',
                    data: {'name': name,"ip": ip, "remark": remark, "aname": aname, "machineroom": machineroom},
                    dataType: 'json',
                    success: function (data) {
                        if(data.code==200)
                        {
                            alert("提交成功");
                            $("#remark").val("");
                            $("#ip").val("");
                        }
                        if(data.code==300)
                        {
                            window.location.href="${pageContext.request.contextPath}/user/login.jsp";
                        }

                    },
                });
               }
            }
        }
        //预约机房
        function yyjk() {
            var time  = $("input[name='time']").val();//可以直接用document获取表单指定内容
            var room  = $("select[name='room']").val();
            var name  = $("input[name='name']").val();
            var classes  = $("input[name='classes']").val();
            var phases  = $("select[name='phases']").val();
            var curriculum  = $("input[name='curriculum']").val();
            if(curriculum==""||classes==""||name==""||time==""){//JS中正则表达式的test方法用来验证是否与该正则表达式匹配，匹配就返回true，不匹配就返回false
                alert("请输入完整信息");
            }else {
                    $.ajax({
                        url: '${pageContext.request.contextPath}/timetable/applicant',
                        method: 'get',
                        data: {'name': name, "time": time, "room": room, "classes": classes, "phases": phases, "curriculum": curriculum},
                        dataType: 'json',
                        success: function (msg) {
                            if(msg.code==200)
                            {
                                alert("该时间段有课，请另外选择时间！");
                            }
                            if(msg.code==201)
                            {
                                alert("对不起你预约时间不符合规定，请重新选择时间！");
                            }
                            if (msg.code==300)
                            {
                                window.location.href="${pageContext.request.contextPath}/user/login.jsp";
                            }
                            console.log(msg); //控制台输
                            $("#time").val("");
                            $("#classes").val("");
                            $("#curriculum").val("");
                        },
                    });
            }
        }


        function qingk() {
            $('#tishi').empty();
        }
        //预约信息
        function get2() {
            $.ajax({
                url:'${pageContext.request.contextPath}/subscrible/findAll',
                method:'get',
                dataType:'json',
                success:function (data) {
                    console.table(data);
                    var $table = $('#aaa');

                    $table.empty();
                    $.each(data, function (i, n) {
                        var $tr = $("<tr>" +
                            "<td>" + n.time + "</td>" +
                            "<td>" + n.room + "</td>" +
                            "<td>" + n.week + "</td>" +
                            "<td>" + n.phases + "</td>" +
                            "<td>" + n.curriculum + "</td>" +
                            "<td>" + n.name + "</td>" +
                            "<td>" + n.classes + "</td>" +
                            "</tr>");
                        var $table = $('#aaa');
                        $table.append($tr);
                    });
                }
             })
        }
        //根据日期和房间查询
        function get() {
            $.ajax({
                url:'${pageContext.request.contextPath}/timetable/findByweekandroom',
                method:'get',
                data:{"machineroom":test(),"weeks":getWeek()},
                dataType:'json',
                success:function (data) {
                    console.table(data);
                    var $table = $('table tbody');
                      if (data!=null&&data!="")
                        {
                                $table.empty();
                                $.each(data,function(i,n){
                                    var $tr = $("<tr>"+
                                        "<td>"+n.weekscount+"</td>"+
                                        "<td>"+n.phases+"</td>"+
                                        "<td>"+n.curriculum+"</td>"+
                                        "<td>"+n.teacher+"</td>"+
                                        "<td>"+n.classes+"</td>"+
                                        "</tr>");
                                    var $table = $('table tbody');
                                    $table.append($tr);
                                });
                        }
                        else {
                          $table.empty();
                          $('table tbody').append('<tr><td colspan="5">暂无数据......</td></tr>');
                      }
                    }
             });
        }

        function test() {
            let input = $("input[name='machineroom']").get();
            for(var i=0;i<input.length;i++){
                if(input[i].checked==true){
                    return input[i].value;
                }
            }
        }
        function getWeek() {
            let input = $("input[name='weeks']").get();
            for(var i=0;i<input.length;i++){
                if(input[i].checked==true){
                    return input[i].value;
                }
            }
        }
        $(function () {
            $('[data-toggle="tooltip"]').tooltip()
        })
        //goeasy
        var goEasy = new GoEasy({
            host:"hangzhou.goeasy.io",
            appkey: "BS-7d64d828e680433fad13d09a3ea62796",
        });
        // 接受消息
        goEasy.subscribe({
            channel: "jcg",
            onMessage: function (message) {
                alert("预约提醒："+message.content);
            }
        });
        // var goEasy = new GoEasy({
        //     host:"hangzhou.goeasy.io",
        //     appkey: "BC-64449ef96f244726825d3b4f26fa7e3c",
        // });
        // //发送消息
        // function publishMessage() {
        //     goEasy.publish({
        //         channel: "jcg",
        //         message: "你有一条新的申请消息！"
        //     });
        // }

    </script>
    <style>
        ul li{
            list-style-type:none;
        }


        .navbar-brand {
            padding: 0;
        }

        .navbar-brand img {
            max-width: 100%;
            max-height: 100%;
        }

        .project-headrd {
            width: 60%;
            text-align: center;
            font-weight: 200;
            display: block;
            margin: 60px auto 40px;
        }
        .footer{
            padding: 30px 0;
            border-top: 1px solid #e5e5e5;
            margin-top: 70px;
        }
        .footer, .footer a {
            color: #777;
        }
        .che{
            width: 20px;
            height: 20px;
        }
        * {
            padding: 0;
            margin: 0;
        }
        .demo {
            width: 600px;
            margin: 0px auto;
            animation: Updown 1s infinite alternate;
        }
        @keyframes Updown {
            from {
                margin-top: 30px;
            }
            to {
                margin-top: 10px;
            }
        }
        #sg{
             font-size: 15px;
            line-height: 26px;
            font-weight: 500;
        }
    </style>
</head>
<body>
<!--导航栏-->

<nav class="navbar navbar-default navbar-fixed-top">
    <div class="container">
        <div class="navbar-header">
            <a href="javascript:void(0)" class="navbar-brand center-block"><img src="${pageContext.request.contextPath}/image/logo1.png" alt="" class="img-responsive"></a>
            <button class="navbar-toggle" type="button" data-toggle="collapse" data-target="#navbar-collapse">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
        </div>
        <div class="collapse navbar-collapse" id="navbar-collapse">
            <ul class="nav navbar-nav navbar-right">
                <li class="active"><a href="${pageContext.request.contextPath}/front/main/main.jsp">首页</a></li>
                <li><a href="javascript:void(0)" data-toggle='modal' data-target='#aplicant'><span
                        class="glyphicon glyphicon-edit">  预约机房</span></a></li>
                <li><a href="javascript:void(0)" data-toggle="modal" data-target="#reaction"><span
                        class="glyphicon glyphicon-comment">  反馈</span></a></li>
                <li><a href="${pageContext.request.contextPath}/filelog/findAllfile"><span
                        class="glyphicon glyphicon-save-file"> 下载</span></a></li>
                <c:if test='${user!=null}'>
                    <li><a href="javascript:void(0)"><span class="glyphicon glyphicon-user" id="username">  ${user.name}
                </span></a></li>
                    <div class="btn-group" style="margin-left: 30px;margin-top: 7px">
                        <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            个人中心 <span class="caret"></span>
                        </button>
                        <ul class="dropdown-menu">
                            <li><a href="${pageContext.request.contextPath}/subscrible/findbyname">我的预约</a></li>
                            <li><a href="${pageContext.request.contextPath}/filelog/findAll">我的下载</a></li>
                            <li role="separator" class="divider"></li>
                            <li><a href="${pageContext.request.contextPath}/user/clearname">退出</a></li>
                        </ul>
                    </div>
                </c:if>
                <c:if test="${user==null}">
                    <li> <a href="${pageContext.request.contextPath}/user/login.jsp"> <span style="color: red">登录</span></a></li>
                </c:if>

            </ul>
        </div>
    </div>
</nav>
<br>
<br>
<br>
<!--布局系统 中心内容-->
<div class="container-fluid">
    <%--轮播--%>
    <div class="row">
        <div class="col-sm-12">
            <div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
                <!-- Indicators -->
                <ol class="carousel-indicators">
                    <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
                    <li data-target="#carousel-example-generic" data-slide-to="1"></li>
                    <li data-target="#carousel-example-generic" data-slide-to="2"></li>
                </ol>

                <!-- Wrapper for slides -->
                <div class="carousel-inner" role="listbox" style="width: 100%;height:100%">
                    <div class="item active">
                        <img src="${pageContext.request.contextPath}/image/lb1.png" alt="图片">
                    </div>
                    <div class="item">
                        <img src="${pageContext.request.contextPath}/image/lb2.png" alt="...">
                    </div>
                    <div class="item">
                        <img src="${pageContext.request.contextPath}/image/la3.jpg" alt="图片">
                    </div>
                </div>

                <!-- Controls -->
                <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
                    <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                    <span class="sr-only">Previous</span>
                </a>
                <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
                    <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                    <span class="sr-only">Next</span>
                </a>
            </div>
        </div>
    </div>
    <%--机房环境介绍>--%>
    <div class="row">
        <div class="project-headrd page-header">
            <h2>机房通知通告、最新动态</h2>
            <p>希望同学们能给出宝贵意见，共同打造和谐环境</p>
        </div>
    </div>
    <%--消息通知--%>
    <div class="row">
        <diV class="col-sm-3">
            <div class="thumbnail" style="height: 337px">
                <img src="${pageContext.request.contextPath}/image/title6.png" alt="...">
                <div class="caption">
                    <h3>Inform one</h3>
                    <p style="text-align: center;letter-spacing: 2px">
                        为推动“不忘初心、牢记使命”主题教育落到实处，经研究决定，自11月29日开始，我院开放信息工程学院6楼IT大合堂教室课余时间为自习教室</p>
                </div>
            </div>
        </div>
        <diV class="col-sm-3">
            <div class="thumbnail" style="height: 337px">
                <img src="${pageContext.request.contextPath}/image/title5.png" alt="...">
                <div class="caption">
                    <h3>Inform two</h3>
                    <p style="text-align: center;letter-spacing: 2px">信息工程学院秉承“教学神圣
                        崇尚学术”的办学理念,着力在教师队伍建设、教学科研、学生工作、社会影响力进一步增强。</p>
                </div>
            </div>
        </div>
        <diV class="col-sm-3">
            <div class="thumbnail" style="height: 337px">
                <img src="${pageContext.request.contextPath}/image/title4.png" alt="...">
                <div class="caption">
                    <h3>Inform three</h3>
                    <p style="text-align: center;letter-spacing: 2px">
                        致力于网络安全特色团队培养和安全应用技术创新。程康同学作为团队核心成员，主要研究Web漏洞挖掘、曾获得ISCC 2019个人挑战赛第二名（全国一等奖）</p>

                </div>
            </div>
        </div>
        <diV class="col-sm-3">
            <div class="thumbnail" style="height: 337px">
                <img src="${pageContext.request.contextPath}/image/title1.png" alt="...">
                <div class="caption">
                    <h3>Inform four</h3>
                    <p style="text-align: center;letter-spacing: 2px">
                        平源副院长首先对我院近几届学生毕业论文（设计）存在的主要问题进行了分析，与会成员针对这些问题展开深入讨论</p>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <!--创建基本手风琴-->
        <div class="panel-group" id="accordion">
            <!--第一个面板-->
            <div class="panel panel-default">
                <!--面板标题-->
                <div class="panel-heading" role="tab" id="headingOne">

                    <h4 class="panel-title">
                        <!--data-toggle collapse 折叠效果 -->

                        <a data-toggle="collapse" href="#collapseOne" data-parent="#accordion">
                            <span class="badge">管理员信息</span>
                        </a>
                    </h4>

                </div>
                <!--面板内容-->
                <div id="collapseOne" class="panel-collapse collapse in">
                    <div class="panel-body">
                        <ul class="list-group">
                            <li class="list-group-item">
                                <div class="row">
                                    <div class="col-sm-4 text-center">
                                        <img src="${pageContext.request.contextPath}/image/8.jpg" alt="这是一个图片"
                                             class="img-circle">
                                        </br>
                                        </br>
                                        <ul class="list-group">
                                            <li class="list-group-item list-group-item-success">姓名：雷军</li>
                                            <li class="list-group-item list-group-item-info">联系方式：11010101010</li>
                                            <li class="list-group-item list-group-item-warning">邮箱：leijun@163.com</li>
                                            <li class="list-group-item list-group-item-danger">简介：找到有台风口的地方，做一头会借力的猪
                                            </li>
                                        </ul>
                                    </div>
                                    <div class="col-sm-4 text-center">
                                        <img src="${pageContext.request.contextPath}/image/4.jpg" alt="这是一个图片"
                                             class="img-circle">
                                        </br>
                                        </br>
                                        <ul class="list-group">
                                            <li class="list-group-item list-group-item-success">姓名：马云</li>
                                            <li class="list-group-item list-group-item-info">联系方式：11110101010</li>
                                            <li class="list-group-item list-group-item-warning">邮箱：mayun@163.com</li>
                                            <li class="list-group-item list-group-item-danger">简介：不喜欢钱</li>
                                        </ul>
                                    </div>
                                    <div class="col-sm-4 text-center">
                                        <img src="${pageContext.request.contextPath}/image/6.jpg" alt="这是一个图片"
                                             class="img-circle">
                                        </br>
                                        </br>
                                        <ul class="list-group">
                                            <li class="list-group-item list-group-item-success">姓名：李彦宏</li>
                                            <li class="list-group-item list-group-item-info">联系方式：12010101010</li>
                                            <li class="list-group-item list-group-item-warning">邮箱：liyanhong@163.com</li>
                                            <li class="list-group-item list-group-item-danger">
                                                简介：做自己喜欢并且擅长的事情，不跟风，不动摇。
                                            </li>
                                        </ul>
                                    </div>
                                </div>

                            </li>
                        </ul>
                    </div>
                </div>
            </div>


            <!--第二个面板-->
            <div class="panel panel-default">
                <!--面板标题-->
                <div class="panel-heading" role="tab" id="headingTwo">

                    <h4 class="panel-title">
                        <!--data-toggle collapse 折叠效果 -->
                        <a data-toggle="collapse" href="#collapseTwo" data-parent="#accordion">
                            <span class="badge">机房学期排课表</span>
                        </a>
                    </h4>

                </div>
                <!--面板内容-->
                <div id="collapseTwo" class="panel-collapse collapse">
                    <div class="panel-body">
                        <ul class="list-group">
                            <ul class="list-group">
                                <li class="list-group-item">
                                    <%--星期标题--%>
                                    <div class="row" id="topcheckbox">
                                        <div class="col-sm-2">
                                        </div>
                                        <div class="col-sm-1">
                                            <div class="input-group">
                                             <span class="input-group-addon">
                                                 <input type="radio" name="weeks" class="btn btn-deault aria-label"
                                                        data-toggle="tooltip" data-placement="top" title="点击查询"
                                                        value="星期一"/>
                                             </span>
                                                <input type="text" class="form-control" style="width: 70px" value="星期一">
                                            </div>
                                        </div>
                                        <div class="col-sm-1">
                                            <div class="input-group">
                                             <span class="input-group-addon">
                                                 <input type="radio" name="weeks" class="btn btn-default aria-label"
                                                        data-toggle="tooltip" data-placement="top" title="点击查询"
                                                        value="星期二"/>
                                             </span>
                                                <input type="text" class="form-control" style="width: 70px" value="星期二">
                                            </div><!-- /input-group -->
                                        </div>
                                        <div class="col-sm-1">
                                            <div class="input-group">
                                             <span class="input-group-addon">
                                                 <input type="radio" name="weeks" class="btn btn-default aria-label"
                                                        data-toggle="tooltip" data-placement="top" title="点击查询"
                                                        value="星期三"/>
                                             </span>
                                                <input type="text" class="form-control" style="width: 70px" value="星期三">
                                            </div><!-- /input-group -->
                                        </div>
                                        <div class="col-sm-1">
                                            <div class="input-group">
                                             <span class="input-group-addon">
                                                 <input type="radio" name="weeks" class="btn btn-default aria-label"
                                                        data-toggle="tooltip" data-placement="top" title="点击查询"
                                                        value="星期四"/>
                                             </span>
                                                <input type="text" class="form-control" style="width: 70px" value="星期四">
                                            </div><!-- /input-group -->
                                        </div>
                                        <div class="col-sm-1">
                                            <div class="input-group">
                                             <span class="input-group-addon">
                                                 <input type="radio" name="weeks" class="btn btn-default aria-label"
                                                        data-toggle="tooltip" data-placement="top" title="点击查询"
                                                        value="星期五"/>
                                             </span>
                                                <input type="text" class="form-control" style="width: 70px" value="星期五">
                                            </div><!-- /input-group -->
                                        </div>
                                        <div class="col-sm-1">
                                            <div class="input-group">
                                             <span class="input-group-addon">
                                                 <input type="radio" name="weeks" class="btn btn-default aria-label"
                                                        data-toggle="tooltip" data-placement="top" title="点击查询"
                                                        value="星期六"/>
                                             </span>
                                                <input type="text" class="form-control" style="width: 70px" value="星期六">
                                            </div><!-- /input-group -->
                                        </div>
                                        <div class="col-sm-1">
                                            <div class="input-group">
                                             <span class="input-group-addon">
                                                 <input type="radio" name="weeks" class="btn btn-default aria-label"
                                                        data-toggle="tooltip" data-placement="top" title="点击查询"
                                                        value="星期日"/>
                                             </span>
                                                <input type="text" class="form-control" style="width: 70px" value="星期日">
                                            </div><!-- /input-group -->
                                        </div>
                                        <div class="col-sm-1 col-lg-offset-1">
                                            <button class="btn btn-danger" data-toggle='modal' data-target='#subscrible'
                                                    onclick='get2()'>已预约教室
                                            </button>
                                        </div>
                                    </div>
                                    </br>
                                    <div class="row">
                                        <div class="col-sm-2">
                                            <span id="machineSpan">
		                                     </span>
                                        </div>
                                        <div class="col-sm-7">

                                            <!--table-->
                                            <table class="table table-bordered">
                                                <thead>
                                                <tr>
                                                    <th>周数</th>
                                                    <th>课节</th>
                                                    <th>课程</th>
                                                    <th>教师</th>
                                                    <th>班级</th>
                                                </tr>
                                                </thead>
                                                <tbody>
                                                </tbody>
                                            </table>
                                            <h4 id="tishi">
                                                <div class="project-headrd page-header">
                                                    <h2>暂无数据....</h2>
                                                    <p>请选择左边教室点击上方的日期进行查询</p>
                                                </div>
                                            </h4>
                                        </div>
                                    </div>

                                </li>
                            </ul>
                        </ul>
                    </div>
                </div>
            </div>

        </div>
    </div>
    <%--下方轮播--%>
    <div class="row" style="height: 300px">
        <%--左边--%>
        <div class="col-sm-4" style="margin-top: 5%">
            <h3>Your machine room management has been
                <div id="carousel-example-generic2" class="carousel slide" data-ride="carousel">
                    <div class="carousel-inner" role="listbox" style="width: 30%;margin-top: 2%">
                        <div class="item active">
                            <span class="label label-default">Simple</span>
                        </div>
                        <div class="item">
                            <span class="label label-default">Convenient</span>
                        </div>
                        <div class="item">
                            <span class="label label-default">Easy</span>
                        </div>
                    </div>
                </div>
            </h3>
            <p id="sg" style="margin-top: 10%">如有好的意见请积极与我们反馈交流,共同进步.</p>
        </div>
        <%--右边--%>
        <div class="col-sm-8 text-center ">
            <div class="demo">
                <img src="${pageContext.request.contextPath}/image/22.png" width="50%">
            </div>
        </div>
    </div>


    <!--上机申请模态框-->
    <div class="modal fade" id="aplicant" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title">预约机房</h4>
                </div>
                <div class="form-group">
                    <label for="inputPassword1" class="col-sm-2 control-label"></label>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal">
                        <div class="form-group">
                            <div class="row">
                                <div class="col-sm-2" style="margin-left: 30px">
                                    <label>选择日期</label>
                                </div>
                                <div class="col-sm-4" style="margin-left: -20px">
                                    <!--指定 date标记-->
                                    <%--<input id="smeet" name="time" type="datetime-local"  />--%>
                                    <div class='input-group date' id='datetimepicker2'>
                                        <input type='text' class="form-control" id="time" name="time"/>

                                        <span class="input-group-addon">
                                        <a tabindex="0" role="button" data-toggle="popover" data-trigger="focus"
                                           title="温馨提示" data-container="body" data-placement="right"
                                           data-content="只能预约本月内的时间段哦">
                                     <span class="glyphicon glyphicon-calendar"></span>
                                        </a>
                                    </span>

                                    </div>

                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputPassword1" class="col-sm-2 control-label">课节</label>
                            <div class="col-sm-10">
                                <select name="phases" id="select">
                                    <option value="1-2节">1-2节</option>
                                    <option value="3-4节">3-4节</option>
                                    <option value="5-6节">5-6节</option>
                                    <option value="7-8节">7-8节</option>
                                    <option value="9-10节">9-10节</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputPassword1" class="col-sm-2 control-label">教室</label>
                            <div class="col-sm-10">
                                <select name="room" id="select1">

                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputPassword1" class="col-sm-2 control-label">课程</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" id="curriculum" name="curriculum">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputPassword1" class="col-sm-2 control-label">班级</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" id="classes" name="classes">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputPassword1" class="col-sm-2 control-label">申请人</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" id="inputPassword1" value="${user.name}" disabled="disabled" name="name">
                            </div>
                        </div>

                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                            <button type="button" onclick="yyjk()" class="btn btn-primary">提交</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!--问题反馈模态框-->
    <div class="modal fade" id="reaction" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title">问题反馈</h4>
                </div>
                <div class="form-group">
                    <label for="inputPassword1" class="col-sm-2 control-label"></label>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal">
                        <div class="form-group">
                            <label for="inputPassword1" class="col-sm-2 control-label">教室</label>
                            <div class="col-sm-10">
                                <select name="machineroom" id="select2">

                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputPassword1" class="col-sm-2 control-label">机器ip</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" id="ip" name="ip">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputPassword1" class="col-sm-2 control-label">简述问题</label>
                            <div class="col-sm-10">
                                <textarea name="remark" id="remark" style="height: 100px"></textarea>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputPassword1" class="col-sm-2 control-label">反馈者</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" id="aname" disabled="disabled" value="${user.name}" name="aname">
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                            <button type="button" class="btn btn-primary" onclick="fank()">提交</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <%--预约机房模态框--%>
    <div class="modal fade" id="subscrible" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content" style="width: 800px">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title">预约信息</h4>
                    </br>
                    <p>注意:&nbsp;&nbsp;预约消息每月<span class="badge">1</span>号会定时清空</p>
                </div>
                <div class="form-group">
                    <label for="inputPassword1" class="col-sm-2 control-label"></label>
                </div>
                <div class="modal-body">
                    <table class="table table-bordered">
                        <thead>
                        <tr>
                            <th>上课时间</th>
                            <th>教室</th>
                            <th>星期</th>
                            <th>课节</th>
                            <th>课程</th>
                            <th>申请人</th>
                            <th>班级</th>
                        </tr>
                        </thead>
                        <tbody id="aaa">
                    </table>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%--页脚--%>
    <footer class="footer">
        <div class="container">
            <div class="row footer-top" style=" color: #563d7c;font-size: 16px;">
                <div class="col-sm-6">
                    <h4>大学机房管理系统</h4>
                    <p>我们一直致力于为学生服务！</p>
                </div>
                <div class="col-sm-6">
                    <div class="row about">
                        <div class="col-sm-4">
                            <h4>关于</h4>
                            <ul class="list-unstyled">
                                <li>
                                    <a href="#">关于我们</a>
                                </li>
                                <li>
                                    <a href="#">合作单位</a>
                                </li>
                                <li>
                                    <a href="#">友情链接</a>
                                </li>

                            </ul>
                        </div>
                        <div class="col-sm-4">
                            <h4>联系方式</h4>
                            <ul class="list-unstyled">
                                <li>
                                    <a href="#">新浪微博</a>
                                </li>
                                <li>
                                    <a href="#">电子邮箱</a>
                                </li>
                            </ul>
                        </div>
                        <div class="col-sm-4">
                            <h4>特别致谢</h4>
                            <ul class="list-unstyled">
                                <li>
                                    <a href="#">许昌学院</a>
                                </li>
                                <li>
                                    <a href="#">指导老师</a>
                                </li>
                                <li>
                                    <a href="#">给予帮助的室友</a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            <hr>
            <div class="row footer-bottom ">
                <ul class="list-inline text-center">
                    <li>京IC备110110110号-6</li>
                    <li>京公安备11101101101010</li>
                </ul>
            </div>
        </div>

    </footer>
</div>
</body>
</html>