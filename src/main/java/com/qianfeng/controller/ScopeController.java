package com.qianfeng.controller;

import com.qianfeng.pojo.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("scope")
// 放在类上面 如果Model中username password 属性 放在session中
@SessionAttributes(value = {"username","password"})
public class ScopeController {
//  ------------------------ request 对象的数据共享  ----------------------------

    @RequestMapping("test1")
    public String test1(HttpServletRequest request){
        request.setAttribute("msg","success");
        return "scope";
    }

    @RequestMapping("test2")
    public ModelAndView test2(){
        ModelAndView mv = new ModelAndView();
//        也相当于放进 request 对象中
        mv.addObject("msg",new Date());
        mv.setViewName("scope");
        return mv;
    }

//    常用:
    @RequestMapping("test3")
//    Model model ==> 模型 ==> 作用域跟 request相同 ==> 当前的请求 ==> 看做封装好的 request
    public String test3(Model model){
        model.addAttribute("msg",Math.random());
        return "scope";
    }

    //    常用:
//    ModelMap 作用域也是 request put{key,value} ==> key 属性名, value属性值
    @RequestMapping("test4")
    public String test4(ModelMap map){
        map.put("msg",new String[10]);
        return "scope";
    }

//  ------------------------  Session 对象的数据共享  ----------------------

    @RequestMapping("/test5")
    public String test5(HttpSession session){
        session.setAttribute("realName","king");
        return "scope";
    }

//  ------------------------  application 对象的数据共享  ----------------------

    @RequestMapping("/test6")
    public String test6(HttpServletRequest request){
//        request 中获取 application
        ServletContext sc = request.getServletContext();
        sc.setAttribute("times",222);
        return "scope";
    }

    @RequestMapping("/test7")
    public String test7(HttpSession session){
//        session 中获取 application
        ServletContext sc = session.getServletContext();
        sc.setAttribute("times",444);
        return "scope";
    }

//    将方法的返回值 添加到 Model 的 listUser 属性中
//    每次发送请求 都自动的执行此方法 放在request中
//    每次请求对应的处理器方法之前, 先执行该方法
    @ModelAttribute(value = "listUser")
    public List<User> selectAllUser(HttpSession session){
        List<User> list = new ArrayList<>();
        User user1 = new User();
        user1.setUsername("test");
        user1.setPassword("123456");
        User user2 = new User();
        user2.setUsername("allen");
        user2.setPassword("9999");
        list.add(user1);
        list.add(user2);
        System.out.println("list = " + list);

        session.setAttribute("user",user1);
        return list;
    }

//    ------------- ModelAttribute --------------
    @RequestMapping("/test8")
//    用在参数上，user 赋值给 model 的 u 属性
//    表示该参数会从Model中获取值
    public String getParam8(@ModelAttribute("u") User user){
        System.out.println("user = " + user);
        return "scope";
    }

//    --------------- SessionAttribute --------------
//       表示该参数会从Model中获取值
//       @SessionAttribute(value = "username",required = false) ==> 从 session 中获取 username
//    url: http://localhost:8080/scope/test9?username=eee&password=3333
    @RequestMapping("/test9")
    public String getParam9(@SessionAttribute(value = "username",required = false) @RequestParam("username") String username){
        System.out.println("username = " + username);
        return "scope";
    }

}
