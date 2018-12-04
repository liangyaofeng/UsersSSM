$(function(){
    $("#regist_button").click(function(){
        //获取表单信息
        var name = $("#regist_username").val().trim();
        var nick=$("#nickname").val().trim();
        var password = $("#regist_password").val().trim();
        var final_password=$("#final_password").val().trim();
        //发送Ajax请求
        $.ajax({
            url:"http://localhost:8080/regist",
            type:"post",
            data:{"username":username,"password":phone,"nickname":nick},
            dataType:"json",
            success:function(result){
                if(result.status==0){
                    alert(result.msg);
                    $("#back").click();//触发返回按钮的单击
                }else if(result.status==1){ //用户已存在
                    $("#warning_1 span").html(result.msg);
                    $("#warning_1").show();//显示提示信息
                }
            }
        });
    });
})