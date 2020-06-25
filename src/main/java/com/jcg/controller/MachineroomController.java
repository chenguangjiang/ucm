package com.jcg.controller;

import com.jcg.entity.Machineroom;
import com.jcg.service.MachineroomService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("machineroom")
public class MachineroomController {
    @Autowired
    private MachineroomService machineroomService;

    //查询所有机房返回html代码
   @RequestMapping("findAllName")
    public void findAll(HttpServletResponse response) throws IOException {
        List<Machineroom> machineroomList = machineroomService.findAll();
       StringBuilder sb = new StringBuilder();
       sb.append("<select>");
        //构建select代码
        machineroomList.forEach(machineroom->{
            sb.append("<option value='"+machineroom.getId()+"'>"+machineroom.getName()+"</option>");
        });
       sb.append("</select>");
       response.setCharacterEncoding("UTF-8");
       response.getWriter().print(sb.toString());
    }

    //处理编辑操作
    @RequestMapping("edit")
    @ResponseBody
    public void edit(Machineroom machineroom, String oper) {
        //添加
        if (StringUtils.equals("add",oper)) {
            machineroomService.saveMachineroom(machineroom);
        }
//        修改
        if (StringUtils.equals("edit",oper)) {
            machineroomService.modifyMachineroom(machineroom);
        }
//        删除
        if (StringUtils.equals("del",oper)) {
            machineroomService.removeById(machineroom.getId());
        }


    }


    @RequestMapping("findAll")
    @ResponseBody  //jqgrid 分页 key total总页数  page当前页  rows 当前页数据集  records总记录数   参数1字段  参数2值 参数3操作
    public Map<String, Object> findAll(String searchField, String searchString, String searchOper, Integer page, Integer rows, Boolean _search) {

        Map<String, Object> map = new HashMap<>();
        Long totalcounts = null;
        List<Machineroom> lists = null;
        if (_search) {
//            根据搜索条件查询集合
            lists = machineroomService.findSearch(searchField, searchString, searchOper, page, rows);
            //根据搜索条件查询总条数
            totalcounts = machineroomService.findTotalCountsSearch(searchField, searchString, searchOper);
        } else {

//        进行分页查询
            lists = machineroomService.findPage(page, rows);
//        总记录数
            totalcounts = machineroomService.findTotalcounts();

        }
        //公共代码
        Long totalPage = totalcounts % rows == 0 ? totalcounts / rows : totalcounts / rows + 1;
        map.put("total", totalPage);
        map.put("rows", lists);
        map.put("page", page);
        map.put("records", totalcounts);
        return map;
    }


    @RequestMapping("findMachineroomName")
    @ResponseBody
    public  List<Machineroom> findMachineroomName(Model model) {
        List<Machineroom> machineroomList = machineroomService.findAll();
        for (Machineroom machineroom:machineroomList
             ) {
            model.addAttribute("machineroom",machineroom);
        }
        return machineroomList;
    }




}
