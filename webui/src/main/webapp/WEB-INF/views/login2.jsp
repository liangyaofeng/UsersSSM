<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>上机作业一</title>

</head>
<body>

    <form id="" action="">
        <label for="username">输入账号:</label><input type="text" id="username" name="username" placeholder="请输入用户名" onblur="oncheck()"/>
        <span id="spanname" style="color: green">请输入6-16字符</span><br>
        <label for="password">输入密码:</label><input type="password" id="password" name="password" placeholder="请输入账号密码" onblur="oncheck()"/>
        <span id="spanpwd" style="color: green">6-16位字符</span><br>
        <label for="password">重新输入:</label><input type="password" id="password2" name="password2" placeholder="请再次输入账号密码" onblur="oncheck()"/>
        <span id="spanpwd2" style="color: green">6-16位密码</span><br>
        <label>&nbsp;</label><input type="button" value="注册" id="register_on"/>
        <label>&nbsp;</label><input type="reset" value="重置" id="login_on"/>
    </form>


<script type="text/javascript" src="../../JS/jquery-1.10.2.min.js"></script>
<script>
    function oncheck(){
        $(function(){
            // $("#username").onblur(function(){
            $("#spanname").html(" ");
            $("#spanpwd").html(" ");
            $("#spanpwd2").html(" ");

            var ok =true;
            //获取请求数据
            var username=$("#username").val();
            var password = $("#password").val();
            var password2=$("#password2").val();

            if (username==""){
                // alert("用户名不能为空！");
                $("#spanname").html("用户名不能为空");
                ok=false;
                return ok;
            }else if (password==""){
                // alert("密码不能为空！");
                $("#spanpwd").html("密码不能为空");
                ok=false;
                return ok;
            }else if(password2==""){
                // alert("确定密码不能为空！");
                $("#spanpwd2").html("确定密码不能为空");
                ok=false;
                return ok;
            }else if (password!=password2){
                // alert("你输入的两次密码不一致！");
                $("#spanpwd2").html("你输入的两次密码不一致");
                ok=false;
                return ok;
            }



            if(ok) {
                //发送Ajax请求
                $.ajax({
                    url: "/login",
                    type: "post",
                    data: {"username": username, "password": password},
                    dataType: "json",
                    success: function (result) {
                        //result是服务器返回的json结果
                        if (result.status == 0) {  //登录成功
                            // alert("登录成功");
                        } else if (result.status == 1) {  //用户名不存在
                            $("#spanname").html(result.msg);
                            // alert(result.msg);

                        }
                        // else if(result.status==2){  //密码不正确
                        //     $("#spanpwd").html(result.msg);
                        //     // alert(result.msg);
                        // }
                    }
                });
            }
            // });
        })
    }




    $(function(){
        $("#register_on").click(function(){
            //获取表单信息
            var username = $("#username").val().trim();
            var password = $("#password").val().trim();
            var password2=$("#password2").val().trim();

            $("#spanname").html(" ");
            $("#spanpwd").html(" ");
            $("#spanpwd2").html(" ");

            var ok=true;

            if (username==""){
                alert("用户名不能为空！");
                $("#spanname").html("用户名不能为空");
                ok=false;
                return ok;
            }else if (password==""){
                // alert("密码不能为空！");
                $("#spanpwd").html("密码不能为空");
                ok=false;
                return ok;
            }else if(password2==""){
                // alert("确定密码不能为空！");
                $("#spanpwd2").html("确定密码不能为空");
                ok=false;
                return ok;
            }else if (password!=password2){
                // alert("你输入的两次密码不一致！");
                $("#spanpwd2").html("你输入的两次密码不一致");
                ok=false;
                return ok;
            }

            if(ok){
                //发送Ajax请求
                $.ajax({
                    url: "/regist",
                    type: "post",
                    data: {"username": username,"password": password},
                    dataType: "json",
                    success: function (result) {
                        if (result.status == 0) {
                            alert(result.msg); //注册成功
                        } else if (result.status == 1) { //用户已存在
                            // alert(result.msg);
                            $("#spanname").html("用户已存在");
                            var span=document.getElementById("spanname");
                            span.style.color="red";
                            // $("#spanname").style.color="red";
                        }
                    }
                });
            }

        });
    })

</script>

</body>
</html>
