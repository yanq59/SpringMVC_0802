package com.qianfeng.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

// 页面跳转
@Controller
@RequestMapping("/forward")
public class ForwardController {
    @RequestMapping("/delete")
    public String delete(){
        System.out.println("删除操作");
//        删除以后刷新数据 跳转到selectAll
//        forward:url ==> 请求转发的地址
//       就是:  request.getRequestDispatcher("selectAll").forward(request,respond)
//        return "forward:selectAll";
//        响应重定向
        return "redirect:selectAll";
    }


    @RequestMapping("/selectAll")
    public String selectAll(){
        System.out.println("查询所有操作");
        return "index";
    }


    @RequestMapping("/insert")
    public ModelAndView test(){
        System.out.println("进行了新建操作");
        ModelAndView mv = new ModelAndView();
//        mv.setViewName("forward:selectAll");
        mv.setViewName("redirect:selectAll");
        return mv;
    }

}
