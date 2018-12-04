<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <title>重置密码</title>
</head>
<body>
<form action="updatepwd">
    <input type="hidden" id="id" name="id" value="${users.id}"><br>
    <%--　旧密码：<input type="text" id="jiupassword" name="jiupassword" value="" placeholder="请输入旧密码"><br>--%>
    　新密码：<input type="text" id="password" name="password" value="" placeholder="请输入新密码"><br>
    <%--确定密码：<input type="text" id="password2" name="password2" value="" placeholder="请再次输入新密码"><br>--%>
    <input id="btnsumbit" type="submit" value="提交">&nbsp;&nbsp;
    <input type="reset" value="重置">
</form>
    <script type="text/javascript" src="../../JS/jquery-1.10.2.min.js"></script>
    <script>
        // $(function(){
        //     $("#btnsumbit").click(function(){
        //         //获取表单信息
        //         var userid = $("#userid").val().trim();
        //         var jiupassword = $("#jiupassword").val().trim();
        //         var password=$("#password").val().trim();
        //         var password2 = $("#password2").val().trim();
        //
        //         var ok=true;
        //
        //         if (jiupassword==""){
        //             alert("请填写旧密码！");
        //             ok=false;
        //             return ok;
        //         }else if (password==""){
        //             alert("新密码不能为空！");
        //             ok=false;
        //             return ok;
        //         }else if(password2==""){
        //             alert("确定新密码不能为空！");
        //             ok=false;
        //             return ok;
        //         }else if (password!=password2){
        //             alert("你输入的两次密码不一致！");
        //             ok=false;
        //             return ok;
        //         }

                // if(ok){
                //     //发送Ajax请求
                //     $.ajax({
                //         url: "/updateUsers",
                //         type: "post",
                //         data: {"id": userid, "password": password},
                //         dataType: "json",
                //         success: function (result) {
                //             if (result.status == 0) {
                //                 alert(result.msg);
                //                 // $("#btna").click();//触发返回按钮的单击
                //                 window.location.href = "http://localhost:8080/userInfo";
                //             } else if (result.status == 1) { //用户已存在
                //                 alert(result.msg);
                //                 // $("#warning_1 span").html(result.msg);
                //                 // $("#warning_1").show();//显示提示信息
                //
                //             }
                //         }
                //     });
                // }

        //     });
        // })
    </script>

</body>
</html>
