//result是服务器返回的json结果
if(result.status==0) {
    var username = result.data;
    addCookie("uid", username, 4);//存储2小时
    window.location.href = "toshowall";
}