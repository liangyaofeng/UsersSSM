package com.liangyaofeng.test;


import com.liangyaofeng.common.MD5;
import com.liangyaofeng.dao.UsersDao;
import com.liangyaofeng.entity.Users;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
@RunWith(SpringJUnit4ClassRunner.class)
//@Transactional
//@TransactionConfiguration(defaultRollback = true)  //被弃用
//@Rollback(true)  //是否回滚
public class UserDaoTest {


    @Autowired
    UsersDao usersDao;

    @Test
    public void testFintUserByusername(){
        Users users=usersDao.fintUserByusername("");
        System.out.println(users);
    }

    @Test
    public void testGetAllUsers(){
        List<Users> list=usersDao.getAllUsers("","","");
        System.out.println(list);

//        System.out.println(usersDao.findUsersbyid(8));

    }

    @Test
    public void testInsertUsers(){
        Users users=new Users();

        users.setUsername("admin000");
        users.setPassword(MD5.MD5("admin000"));
        users.setPhone("16443532533");
        users.setEmail("678347@.com");

        usersDao.insertUsers(users);

    }


}
