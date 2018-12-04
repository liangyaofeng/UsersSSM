package com.liangyaofeng.service;

import com.liangyaofeng.entity.NoteResult;
import com.liangyaofeng.entity.Users;
import org.apache.ibatis.annotations.Param;

import java.security.NoSuchAlgorithmException;
import java.util.List;

public interface UserService {


    public NoteResult checkLogin(String username,String password) throws NoSuchAlgorithmException;

    public NoteResult regist(String username, String password, String phone,String email) throws NoSuchAlgorithmException;

    List<Users> querygetAllUsers(String username,String phone,String email);

    int querydeletebyid(String username);

    Users findUsersbyid(long id);

    boolean updatepwd(long id,String password) throws NoSuchAlgorithmException;

    boolean updateUsers(Users users);

    int deletebyall(List<Long> ids);


}
