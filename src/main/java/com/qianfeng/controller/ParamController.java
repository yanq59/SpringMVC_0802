package com.qianfeng.controller;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;

@Controller
@RequestMapping("/param")
public class ParamController {
//    方法1: 直接在方法中添加request参数
//   url: http://localhost:8080/param/getParam1?username=admin
    @RequestMapping("/getParam1")
    public String getParam1(HttpServletRequest request){
        String username = request.getParameter("username");
        System.out.println("username = " + username);
        return "login";
    }
//    方法2:形参名字接收
//    username 名字跟name对应上
//    日期格式默认: yyyy/MM/dd 可以自动转换成 Date
//    url: http://localhost:8080/param/getParam2?username=admin&age=23&birthday=2023/08/02
//    @DateTimeFormat 修改默认的日期格式
    @RequestMapping("/getParam2")
    public String getParam2(String username, int age, @DateTimeFormat(pattern = "yyyy-MM-dd") Date birthday){
        System.out.println("username = " + username);
        System.out.println("age = " + age);
        System.out.println("birthday = " + birthday);
        return "login";
    }
}
