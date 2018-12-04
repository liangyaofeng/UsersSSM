<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>登录</title>
    <style type="text/css">
        *{
            margin: 0px;
            padding: 0px;
        }
        #body{
            width: 954px;
            height: 374px;
            margin: 150px auto;
        }
        #img{
            float: left;
            width: 454px;
            height: 100%;
            background-image: url(../../img/1043.png);
        }
        #form{
            float: left;
            width: 500px;
            height: 100%;
        }
        #head{
            border-top: 4px solid #EA3A3A;
            width: 500px;
            height: 46px;
            background-color: #F9F9F9;
            text-align: center;
            font-size: 16px;
            line-height: 46px;
        }
        #f_body{
            padding: 10px;
        }
        #login{
            overflow: hidden;
        }
        #login label{
            margin: 30px 0 0 0;
            width: 90px;
            height: 50px;
            line-height: 50px;
            text-align: right;
            float: left;
            padding-right: 20px;
            color: #333;
            font-size: 12px;
        }
        #login input{
            margin: 30px 0 0 0;
            float: left;
            margin-right: 50px;
            width: 300px;
            height: 50px;
            box-sizing: border-box;
            border: 1px solid #cdcdcd;
            padding: 5px 10px 5px 10px;
        }
        #login p{
            float: left;
            margin-top: 20px;
            width: 300px;
            text-align: center;
        }
        #login a{
            text-decoration: none;
            font-size: 12px;
        }
        .div_a{
            color: white;
        }
    </style>
</head>
<body>
<%--<h2>员工登录</h2>--%>
<%--<form action="">--%>
    <%--用户名:&nbsp;<input type="text" name="" id="count" tabindex='1'/>--%>
    <%--<span id="count_msg"></span><br>--%>
    <%--密&nbsp;&nbsp;&nbsp;码:&nbsp;<input type="password" name="" id="password" tabindex='2'/>--%>
    <%--<span id="password_msg"></span><br>--%>
    <%--<input type="checkbox"><span>记住我</span><br>--%>
    <%--<input type="button" name="" id="login" value='&nbsp登&nbsp录&nbsp' tabindex='3'/>--%>
    <%--<input type="button" name="" id="sig_in" value='&nbsp注&nbsp册&nbsp' tabindex='4'/>--%>
<%--</form>--%>



<div id="body">
    <div id="img"></div>
    <div id="form">
        <div id="head">个人用户登录</div>
        <div id="f_body">
            <form id="login" action="userInfo">
                <label for="count">账号</label><input type="text" id="count" name="username" placeholder="请输入用户名"/>
                <label for="password">密码</label><input type="password" id="password" name="password" placeholder="请输入账号密码"/>
                <label>&nbsp;</label><input type="button" value="登录" id="login_on" style="background-color: #EB3B3B;color: white;"/>
                <label>&nbsp;</label><p><a href="tozhuce">免费注册</a></p>
            </form>
        </div>
    </div>
</div>



<script type="text/javascript" src="../../JS/jquery-1.10.2.min.js"></script>
<script>
    $(function(){
        $("#login_on").click(function(){
            //清空数据
            // $("#count_msg").html(" ");
            // $("#password_msg").html(" ");
            //检查数据格式
            var ok =true;
            //获取请求数据
            var username=$("#count").val().trim();
            var password = $("#password").val().trim();
            if(username==""){
                // $("#count_msg").html("用户名不能为空");
                alert("用户名不能为空");
                ok=false;
                return ok;
            }else{
                if(password==""){
                    // $("#password_msg").html("密码不能为空");
                    alert("密码不能为空");
                    ok=false;
                    return ok;
                }
            }


            if(ok){
                //发送Ajax请求
                $.ajax({
                    url:"/login",
                    type:"post",
                    data:{"username":username,"password":password},
                    dataType:"json",
                    success:function(result){
                        //result是服务器返回的json结果
                        if(result.status==0){  //登录成功
                            var username = result.data;
                            // addCookie("uid",username,4);//存储2小时

                            alert("登录成功");
                            sessionStorage.setItem("username",username);
                            window.location.href = "http://localhost:8080/usersInfo?name="+username+"";
                        }else if (result.status==1){  //用户名不存在
                            // $("#count_msg").html(result.msg);
                            alert(result.msg);

                        }else if(result.status==2){  //密码不正确
                            // $("#password_msg").html(result.msg);
                            alert(result.msg);
                        }
                    }
                });
            }
        });
    });
</script>

</body>
</html>
