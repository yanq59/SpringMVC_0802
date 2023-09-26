package com.qianfeng.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class FirstController {
    @RequestMapping("/hello") // 请求的映射
    public String helloController(){
        System.out.println("Hello wyq");
//        返回值作为视图的名字
        return "login";
    }

    @RequestMapping("/testjsp") // 请求的映射
    public String test(){
        System.out.println("WEB-INF");
//        返回值作为视图的名字
        return "test";
    }

    @RequestMapping("/testhtml") // 请求的映射
    public String testhtml(){
        System.out.println("WEB-INF");
//        返回值作为视图的名字
        return "test.html";
    }

    @RequestMapping("/github") // 请求的映射
    public String github(){
        System.out.println("WEB-INF");
//        返回值作为视图的名字
        return "test.html";
    }
}
