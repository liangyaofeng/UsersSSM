package com.liangyaofeng.dao;

import com.liangyaofeng.entity.Users;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UsersDao {

    Users fintUserByusername(@Param("username") String username);

    void insertUsers(Users users);

    List<Users> getAllUsers(@Param("username") String username,@Param("phone") String phone,@Param("email") String email);

    int deletebyid(@Param("username") String username);

    Users findUsersbyid(@Param("id") long id);

    boolean updateUsers(Users users);

    boolean updatepwd(@Param("id") long id,@Param("password") String password);

    int deletebyall(List<Long> ids);



}
