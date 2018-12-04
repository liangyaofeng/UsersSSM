package com.liangyaofeng.service.Impl;

import com.liangyaofeng.common.MD5;
import com.liangyaofeng.common.NoteUtil;
import com.liangyaofeng.dao.UsersDao;
import com.liangyaofeng.entity.NoteResult;
import com.liangyaofeng.entity.Users;
import com.liangyaofeng.service.UserService;
import org.apache.commons.lang3.StringUtils;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.security.NoSuchAlgorithmException;
import java.util.List;

@Service
public class UserServiceImpl implements UserService{

    @Autowired
    UsersDao usersDao;



    public NoteResult checkLogin(String username,String password) throws NoSuchAlgorithmException {
        NoteResult result = new NoteResult();
        Users user = usersDao.fintUserByusername(username);
        if(user==null){
            result.setStatus(1);
            result.setMsg("用户名不存在");
            return result;
        }
        //将用户输入的pwd密码加密
        String md5_pwd=NoteUtil.md5(password);
        //与数据库密码比对
        if(!user.getPassword().equals( md5_pwd)){
            result.setStatus(2);
            result.setMsg("密码不正确");
            return  result;
        }
        result.setStatus(0);
        result.setMsg("用户名和密码正确");
        result.setData(user.getUsername());//返回username
        return  result;
    }

    public NoteResult regist(String username, String password, String phone,String email) throws NoSuchAlgorithmException {
        NoteResult result = new NoteResult();
        //检测用户名是否被占用
        Users hash_user=usersDao.fintUserByusername(username);
        if(hash_user!=null){
            result.setStatus(1);
            result.setMsg("用户名已被占用");
            return  result;
        }
        Users user = new Users();
        user.setUsername(username);
        String md5_pwd = NoteUtil.md5(password);
        user.setPassword(md5_pwd);
        user.setPhone(phone);
        user.setEmail(email);
        //调用userDao保存
        usersDao.insertUsers(user);
        result.setStatus(0);
        result.setMsg("注册成功");
        result.setData(user);
        return result;
    }


    public List<Users> querygetAllUsers(String username, String phone,String email){
        if (StringUtils.isEmpty(username)){
            username=null;
        }
        if (StringUtils.isEmpty(phone)){
            phone=null;
        }
        if (StringUtils.isEmpty(email)){
            email=null;
        }
        return usersDao.getAllUsers(username,phone,email);
    }

    public int querydeletebyid(String username) {
        return usersDao.deletebyid(username);
    }

    public Users findUsersbyid(long id) {
        Users users=usersDao.findUsersbyid(id);
        return users;
    }
    public boolean updatepwd(long id,String password) throws NoSuchAlgorithmException {

        Users users=new Users();
        users.setId(id);
        users.setPassword(NoteUtil.md5(password));
        return usersDao.updateUsers(users);
    }

    public boolean updateUsers(Users users) {
        return usersDao.updateUsers(users);
    }

    public int deletebyall(List<Long> ids) {
        if(ids==null||ids.size()<=0) {
            return 0;
        }
        return usersDao.deletebyall(ids);
    }
}
