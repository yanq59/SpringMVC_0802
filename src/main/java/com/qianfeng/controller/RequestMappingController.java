package com.qianfeng.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
// value = 可以忽略
// name = 注释
@RequestMapping(value = "/emp") //父级路径 ==> http://localhost:8080/emp/testReq
public class RequestMappingController {
//    请求方式必须是 get 的 requestMapping
//    @GetMapping("/testReq")
//    请求方式必须是 post 的 requestMapping
//    @PostMapping("/testReq")

//   method = RequestMethod.GET ==> 请求该方法的方式只能是Get
//   method = {RequestMethod.GET,RequestMethod.POST} ==> get,post都行
//   params = {"flag=test"} ==> 请求的参数必须有 flag = test
    @RequestMapping(value = "/testReq", name = "测试",method = {RequestMethod.GET,RequestMethod.POST},params = {"flag=test"})
    public String test1(){
        System.out.println("test1()");
        return "login";
    }
}
