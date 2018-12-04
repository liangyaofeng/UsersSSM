<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <title>首页</title>
    <link href="../../CSS/bootstrap.min.css" rel="stylesheet">
    <script type="text/javascript" src="../../JS/jquery-1.10.2.min.js"></script>
    <script type="text/javascript" src="../../JS/bootstrap.min.js"></script>
    <link href="../../CSS/showall.css" rel="stylesheet">
    <script>
        window.onload = function main() {
            Tabs(".list-item", ".contents", "list-item-checked", "contents-checked");
        }
        function Tabs(tabs_name, contents_name, tabs_checked_style, contents_checked_style) {
            var tabs = document.querySelectorAll(tabs_name),
                contents = document.querySelectorAll(contents_name),
                e_mark = 0;
            for (var i = 0, len = tabs.length; i < len; i++) {
                tabs[i].num = i;
                tabs[i].onclick = function () {
                    tabs[e_mark].classList.toggle(tabs_checked_style);
                    tabs[this.num].classList.toggle(tabs_checked_style);
                    contents[e_mark].classList.toggle(contents_checked_style);
                    contents[this.num].classList.toggle(contents_checked_style);
                    e_mark = this.num;
                };
            }
        }
    </script>
</head>
<body>
 <div>
     <div id="divlaoda">
         <div id="divtitle1">
             <h1>会员管理系统后台</h1>
         </div>
         <div id="divtitle12">
             <p></p>
             <span id="">${param.name}</span>
         </div>
     </div>
     <div id="divgukai"></div>

     <div id="div1">
         <ul id="list-title">
             <li class="list-item ">后台首页</li>
             <li class="list-item list-item-checked">会员管理</li>
             <li class="list-item"><a id="list_item_a" href="tologin">安全退出</a></li>
         </ul>
     </div>

     <div id="content-box">
         <div class="contents" >
             <span>欢迎登录会员管理系统，当前用户为:<a href="#">${param.name}</a></span><span>,你登录的时间为:
             <jsp:useBean id="now" class="java.util.Date" scope="page"/>
             <fmt:formatDate value="${now}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
         </div>
         <div class="contents contents-checked" >
             <form action="" method="post">
                 用户名：<input type="text" name="username"/>&nbsp;
                 电话号码：<input type="text" name="phone" />&nbsp;
                 邮箱：<input type="text" name="email" />
                 <input type="submit" value="搜索"/>&nbsp;&nbsp;
                 <a href="/pushcsv">导出</a>
                 <a href="#">导入</a>
             </form><br><br>


             <!-- 表格  -->
             <div class="row">
                 <div class="col-md-12">
                     <form action="deletes" method="get">
                         <table class="table table-hover">
                             <tr>
                                 <th>选择</th>
                                 <th>编号</th>
                                 <th>账号</th>
                                 <th>电话</th>
                                 <th>邮箱</th>
                                 <th>注册日期</th>
                                 <th>操作</th>
                             </tr>
                             <c:forEach items="${pageInfo.list}" var="users">
                                 <tr>
                                     <td><input type="checkbox" name="ids" value="${users.id}"></td>
                                     <td>${users.id}</td>
                                     <td>${users.username}</td>
                                     <td>${users.phone}</td>
                                     <td>${users.email}</td>
                                     <td>${users.udate}</td>
                                     <td>
                                         <a type="button"  href="getUsers?id=${users.id}" class="btn btn-info btn-sm">
                                             <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                                             编辑</a>
                                         <a type="button" id="btndel"  href="delbyid?username=${users.username}" class="btn btn-danger btn-sm">
                                             <span class="glyphicon glyphicon-trash" aria-hidden="true" ></span>
                                             删除</a>
                                         <a type="button"  href="getUsersbypwd?id=${users.id}" class="btn btn-info btn-sm">
                                             <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                                             重置密码</a>
                                     </td>
                                 </tr>
                             </c:forEach>
                         </table>
                         <button id="btndelids" class="btn btn-primary">删除选择项</button>
                     </form>
                 </div>
             </div>




             <hr style="height:1px;border:none;border-top:1px solid #ccc;" />
             <!-- 分页导航栏 -->

             <!-- 分页信息 -->
             <div class="row">
                 <!-- 分页文字信息，其中分页信息都封装在pageInfo中 -->
                 <div class="col-md-6">
                     当前第：${pageInfo.pageNum}页，总共：${pageInfo.pages}页，总共：${pageInfo.total}条记录
                 </div>

                 <!-- 分页条 -->
                 <div class="col-md-6">
                     <nav aria-label="Page navigation">
                         <ul class="pagination">
                             <li><a href="/usersInfo?pn=1">首页</a></li>
                             <c:if test="${pageInfo.hasPreviousPage}">
                                 <li>
                                     <a href="/usersInfo?pn=${pageInfo.pageNum-1}" aria-label="Previous">
                                         <span aria-hidden="true">上一页</span>
                                     </a>
                                 </li>
                             </c:if>

                             <c:forEach items="${pageInfo.navigatepageNums}" var="page_Num">
                                 <c:if test="${page_Num == pageInfo.pageNum}">
                                     <li class="active"><a href="#">${ page_Num}</a></li>
                                 </c:if>
                                 <c:if test="${page_Num != pageInfo.pageNum}">
                                     <li><a href="/usersInfo?pn=${page_Num}">${page_Num}</a></li>
                                 </c:if>
                             </c:forEach>
                             <c:if test="${pageInfo.hasNextPage}">
                                 <li>
                                     <a href="/usersInfo?pn=${pageInfo.pageNum+1}" aria-label="Next">
                                         <span aria-hidden="true">下一页</span>
                                     </a>
                                 </li>
                             </c:if>
                             <li><a href="/usersInfo?pn=${pageInfo.pages}">末页</a></li>
                         </ul>
                     </nav>
                 </div>
             </div>


         </div>
         <%--<div class="contents" >content_3</div>--%>
     </div>
 </div>
<script>
    $("#btndel").click(function () {
        var msg = "您真的确定要删除选择项吗？\n\n请确认！";
        if (confirm(msg)==true){
            return true;
        }else{
            return false;
        }
    })
    
    $("#list_item_a").click(function(){
        if (confirm("你确定要注销当前账号吗？")) {
            sessionStorage.removeItem("username");
            return true;

        }else{
            return false;
        }

    })
    
    
</script>
</body>
</html>
