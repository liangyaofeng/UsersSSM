package com.liangyaofeng.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.liangyaofeng.common.R;
import com.liangyaofeng.entity.NoteResult;
import com.liangyaofeng.entity.Users;
import com.liangyaofeng.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.security.NoSuchAlgorithmException;
import java.util.Date;
import java.util.List;


@Controller
@RequestMapping
public class UsersController {

    @Autowired
    UserService userService;

    //注册账号，就是添加账号
    @RequestMapping("/regist")
    @ResponseBody
    public NoteResult execute(String username, String password , String phone, String email, HttpServletRequest request) throws NoSuchAlgorithmException {
        NoteResult result= userService.regist(username, password, phone,email);

        return  result;

    }


    //查询，登录账号
    @RequestMapping("/login")
    @ResponseBody
    public NoteResult execute(String username, String password, HttpServletRequest request) throws NoSuchAlgorithmException {

        HttpSession session = request.getSession();
        session.setAttribute("username",username);
        System.out.println(username);

        NoteResult result = userService.checkLogin(username,password);
        return result;
    }


    //跳转到首页
    @RequestMapping("toshowall")
    public String toshowall(Model model,HttpSession session){
//        model.addAttribute("protype",protypeService.querygetAllProtype());
        if(session.getAttribute("username")==null){
            return "redirect:/tologin";
        }
        return "showall";
    }


    //跳转到注册页面
    @RequestMapping("tozhuce")
    public String tozhuce(Model model){
//        model.addAttribute("protype",protypeService.querygetAllProtype());
        return "zhuce";
    }

    //跳转到登录页面
    @RequestMapping("tologin")
    public String tologin(Model model){

//        model.addAttribute("protype",protypeService.querygetAllProtype());
        return "login";
    }


    //跳转到验证页面
    //上机作业157
    @RequestMapping("tologin2")
    public String tologin2(Model model){

//        model.addAttribute("protype",protypeService.querygetAllProtype());
        return "login2";
    }

    @RequestMapping("totest")
    public String totest(Model model){
        return "test";
    }




    //注册用户
    @RequestMapping("/addUsers")
    public String addUsers(Model model,String username, String password , String phone,String email){
        try {
            userService.regist(username, password, phone,email);
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        return "login";
    }




    //根据name查询，默认查询所有
    @RequestMapping("usersInfo")
    public String productInfo(@RequestParam(required=true,defaultValue="1") Integer pn,
                              @RequestParam(required=false,defaultValue="3") Integer pageSize, Model model, String username,String phone,String email,HttpServletRequest request){
        //从第一条开始 每页查询五条数据
        PageHelper.startPage(pn, pageSize);
        List<Users> product = userService.querygetAllUsers(username,phone,email);
        //将用户信息放入PageInfo对象里
        PageInfo<Users> page = new PageInfo<Users>(product,pageSize);
        model.addAttribute("pageInfo", page);
        model.addAttribute("username",username);
        model.addAttribute("phone",phone);
        model.addAttribute("email",email);

        //获取session值
        HttpSession session = request.getSession();
        Object name = session.getAttribute("username");
        System.out.println(name);
        return "showall";
    }


    //    删除
    @RequestMapping("/delbyid")
    public String delbyid(String username,Model model){
        model.addAttribute("users", userService.querydeletebyid(username));
        return "redirect:/usersInfo";
    }


    //   多删除
    @RequestMapping("/deletes")
    public String deletes(Model model, @RequestParam("ids") List<Long> ids){

        String msg="删除成功！";

        if(userService.deletebyall(ids)<=0){
            msg="删除失败！";
        }

        model.addAttribute("msg",msg);

        model.addAttribute("users",userService.querygetAllUsers("","",""));
        return "redirect:/usersInfo";
    }





    //    根据id查询
    @RequestMapping("/getUsers")
    public String getUsers(long id,Model model){
        model.addAttribute("users", userService.findUsersbyid(id));
        return "update";
    }

    //    根据id查询，重置密码
    @RequestMapping("/getUsersbypwd")
    public String getUsersbypwd(long id,Model model){
        model.addAttribute("users", userService.findUsersbyid(id));
        return "updatepwd";
    }


    //    修改
    @RequestMapping("updateUsers")
    public String updateUsers(Model model,Users users){
        if(userService.updateUsers(users)){
            users = userService.findUsersbyid(users.getId());
            model.addAttribute("users", users);
            return "redirect:/usersInfo";
        }
        return "error";
    }

    //修改密码
    @RequestMapping("updatepwd")
    public String updatepwd(Model model,long id,String password) throws NoSuchAlgorithmException {
        if(userService.updatepwd(id,password)){
            Users users;
            users = userService.findUsersbyid(id);
            model.addAttribute("users", users);
            return "redirect:/usersInfo";
        }
        return "error";
    }




    //22.下载附件，导出Excel,csv
    @RequestMapping("/pushcsv")
    @ResponseBody
    public void pushcsv(HttpServletResponse response) throws IOException {

        //POI
        //response.setContentType("text/html;charset=utf-8");
        //response.setCharacterEncoding("utf-8");
        response.setHeader("Content-Type","application/octet-stream;charset=utf-8");
        response.setHeader("Content-Disposition","attachment;filename=users.csv");
        PrintWriter out = response.getWriter();
        //加上bom头,解决excel打开乱码问题
        byte[] bomStrByteArr = new byte[] { (byte) 0xef, (byte) 0xbb, (byte) 0xbf };
        String bomStr = new String(bomStrByteArr, "UTF-8");
        out.write(bomStr);

        List<Users> list=userService.querygetAllUsers("","","");


        StringBuffer str=new StringBuffer("");
        str.append("编号,用户名,密码,手机号码,email,注册时间\r\n");
        for (Users users:list) {
            str.append(users.getId()+","+users.getUsername()+","+users.getPassword()+","+users.getPhone()+","+users.getEmail()+","+users.getUdate()+"\r\n");
        }
        response.getWriter().write(str.toString());
    }



    @RequestMapping("/jsonp")
    @ResponseBody
    public String jsonp(String callback,long id,HttpServletResponse response){
        response.addHeader("Access-Control-Allow-Origin","*");
        Users users=userService.findUsersbyid(id);
        return callback+"('"+users+"')";
    }




    @RequestMapping("/jsont")
    @ResponseBody
    public String jsont(String callback,HttpServletResponse response){

        response.addHeader("Access-Control-Allow-Origin","*");
        return  callback+"('"+new Date()+"')";
    }



}
