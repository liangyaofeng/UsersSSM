$(function(){
    $("#login").click(function(){
        //清空数据
        $("#count_msg").html(" ");
        $("#password_msg").html(" ");
        //检查数据格式
        var ok =true;
        if(name==""){
            $("#count_msg").html("用户名不能为空");
            ok=false;
        }2
        if(password==""){
            $("#password_msg").html("密码不能为空");
            ok=false;
        }
        //获取请求数据
        var name=$("#count").val().trim();
        var password = $("#password").val().trim();
        if(ok){
            //发送Ajax请求
            $.ajax({
                url:"http://localhost:8080/login",
                type:"post",
                data:{"name":username,"pwd":password},
                dataType:"json",
                success:function(result){
                    //result是服务器返回的json结果
                    if(result.status==0){
                        var userId = result.data;
                        addCookie("uid",userId,2);//存储2小时
                        window.location.href="edit.html";
                    }else if (result.status==1){
                        $("#count_msg").html(result.msg);
                    }else if(result.status==2){
                        $("#password_msg").html(result.msg);
                    }
                }
            });
        }
    });
});