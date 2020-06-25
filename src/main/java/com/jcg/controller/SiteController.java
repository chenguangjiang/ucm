package com.jcg.controller;

import com.jcg.entity.Site;
import com.jcg.service.SiteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@Controller
@RequestMapping("site")
public class SiteController {
    @Autowired
    private SiteService siteService;

    //查询所有机房返回html代码
    @RequestMapping("findAllName")
    public void findAll(HttpServletResponse response) throws IOException {
        List<Site> siteList = siteService.findAll();
        StringBuilder sb = new StringBuilder();
        sb.append("<select>");
        //构建select代码
        siteList.forEach(site->{
            sb.append("<option value='"+site.getId()+"'>"+site.getName()+"</option>");
        });
        sb.append("</select>");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().print(sb.toString());
    }
}
