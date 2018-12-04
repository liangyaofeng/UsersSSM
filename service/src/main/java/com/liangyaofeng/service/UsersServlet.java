package com.liangyaofeng.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.liangyaofeng.entity.Users;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/UsersServlet")
public class UsersServlet extends HttpServlet {

    UserService userService;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }




    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.addHeader("Access-Control-Allow-Origin", "http://127.0.0.1:8020");
        response.addHeader("Access-Control-Allow-Methods", "GET, HEAD, POST, TRACE, OPTIONS,PUT,DELETE");
        response.addHeader("Access-Control-Request-Headers", "Origin,X-Requested-With,Content-Type,Accept");
        response.addHeader("Access-Control-Allow-Credentials", "true");

        ObjectMapper mapper = new ObjectMapper();
        PrintWriter out=response.getWriter();
        Users list=userService.findUsersbyid(18);

        String json = mapper.writeValueAsString(list);
//        out.append(json);
        response.getWriter().write(json);
    }
}
