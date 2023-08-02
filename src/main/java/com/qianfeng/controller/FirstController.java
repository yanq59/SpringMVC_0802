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
}
