package com.qianfeng.controller;

import com.qianfeng.pojo.Emp;
import com.qianfeng.pojo.User;
import com.qianfeng.pojo.UserList;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import java.util.Arrays;
import java.util.Date;

// 收集参数的7种方式
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
    public String getParam2(String[] skill, String username, int age, @DateTimeFormat(pattern = "yyyy-MM-dd") Date birthday){
        System.out.println("skill = " + Arrays.toString(skill));
        System.out.println("username = " + username);
        System.out.println("age = " + age);
        System.out.println("birthday = " + birthday);
        return "login";
    }
//   参数推荐用包装器类型, 获取不到 是 null 不报错, int没有的话就会报错
//   url: http://localhost:8080/param/getParam3?uname=admin&age=23
//   value = 可以省略
//    @RequestParam()在request种获取值
//   默认 required = true 如果 required = false 参数可以没有, ==> 默认值是 defaultValue = "aaa"
    @RequestMapping("/getParam3")
    public String getParam3(@RequestParam(value = "uname",required = false,defaultValue = "aaa") String username, Integer age){
        System.out.println("username = " + username);
        System.out.println("age = " + age);
        return "login";
    }

//    常用
    @RequestMapping("/getParam4")
    public String getParam4(User user){
        System.out.println("user = " + user);
        return "login";
    }

//    多个对象
    @RequestMapping("/getParam5")
    public String getParam5(User user, Emp emp){
        System.out.println("user = " + user);
        System.out.println("emp = " + emp);
        return "login";
    }

//    组合多个对象收参数
    @RequestMapping("/getParam6")
    public String getParam6(UserList userList){
        System.out.println("userList = " + userList);
        return "login";
    }

//    常用
    //    组合多个对象收参数
//    url: http://localhost:8080/param/getParam7/123
    @RequestMapping("/getParam7/{num}")
    public String getParam7(@PathVariable("num") Integer num){
        System.out.println("num = " + num);
        return "login";
    }
}
