package com.jcg.controller;

import com.jcg.entity.Subscrible;
import com.jcg.entity.User;
import com.jcg.service.SubscribleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping("subscrible")
public class SubscribleController {
    @Autowired
    private SubscribleService subscribleService;
    @RequestMapping("findAll")
    @ResponseBody
    public List<Subscrible> findAll(HttpServletRequest request) {
        List<Subscrible> subscribles = subscribleService.findAll();
        return subscribles;
    }
    @RequestMapping("findbyname")
    public String findbyname(HttpServletRequest request) {
        User user = (User) request.getSession().getAttribute("user");
        List<Subscrible> subscribles = subscribleService.findAllByName(user.getName());
        request.getSession().setAttribute("subscribles", subscribles);
        return "user/mysubscrible";
    }
    @RequestMapping("delete")
    public String delete(HttpServletRequest request,String id) {
        System.out.println("id"+id);
       subscribleService.remove(id);
        return "redirect:/subscrible/findbyname";
    }
//    @RequestMapping("findById")
//    public String findById(HttpServletRequest request) {
//        User user = (User) request.getSession().getAttribute("user");
//        Subscrible subscrible = subscribleService.findById(user.getId());
//        request.getSession().setAttribute("subscrible", subscrible);
//        return "user/mysubscrible";
//    }
//    @RequestMapping("update")
//    public String update(HttpServletRequest request,Subscrible subscrible) {
//        User user = (User) request.getSession().getAttribute("user");
//        subscribleService.update(subscrible);
//        return "user/mysubscrible";
//    }
}
