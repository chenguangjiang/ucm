package com.jcg.controller;

import com.jcg.entity.Banner;
import com.jcg.service.BannerService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("banner")
@ResponseBody
public class BannerController {
    @Autowired
    private BannerService bannerService;
    //处理编辑操作
    @RequestMapping("edit")
    @ResponseBody
    public Map edit(Banner banner, String oper,String [] id) {
            Map<String,Object> map=new HashMap();
        //添加
        if (StringUtils.equals("add",oper)) {

             map = bannerService.save(banner);
        }
//        修改
        if (StringUtils.equals("edit",oper)) {
            map=bannerService.modify(banner);
        }
//        删除
        if (StringUtils.equals("del",oper)) {
            map=bannerService.remove(banner.getId());
        }
        System.out.println("sss"+map);
        return map;
    }

    @RequestMapping("upload")
    @ResponseBody
    public void upload(MultipartFile url,String bannerId) {
//        //获取路径
//        String realPath = session.getServletContext().getRealPath("/statics/image");
//        //判断是否存在
//        File file = new File(realPath);
//        if (!file.exists()) {
//            file.mkdirs();
//        }
//        //防止重名
//        String originalFilename = url.getOriginalFilename();
//        originalFilename = new Date().getTime() + "_"+originalFilename;
//        try {
//            url.transferTo(new File(realPath,originalFilename));
//        } catch (IOException e) {
//            e.printStackTrace();
//        }
//        //相对路径： ../xx/xx/xx.jpg
//        //网络路径： http：//ip：端口号/项目名/文件位置
//        String http = request.getScheme();
//        String localHost = InetAddress.getLocalHost().toString();
//        int serverPort = request.getServerPort();
//        String contextPath = request.getContextPath();

        System.out.println(url);
        System.out.println(bannerId);
    }

    @RequestMapping("findAll")
    @ResponseBody  //jqgrid 分页 key total总页数  page当前页  rows 当前页数据集  records总记录数   参数1字段  参数2值 参数3操作
    public Map<String, Object> findAll(String searchField, String searchString, String searchOper, Integer page, Integer rows, Boolean _search) {

        Map<String, Object> map = new HashMap<>();
        Long totalcounts = null;
        List<Banner> lists = null;
        if (_search) {
//            根据搜索条件查询集合
            lists = bannerService.findSearch(searchField, searchString, searchOper, page, rows);
            //根据搜索条件查询总条数
            totalcounts = bannerService.findTotalCountsSearch(searchField, searchString, searchOper);
        } else {

//        进行分页查询
            lists = bannerService.findPage(page, rows);
//        总记录数
            totalcounts = bannerService.findTotalcounts();

        }
        //公共代码
        Long totalPage = totalcounts % rows == 0 ? totalcounts / rows : totalcounts / rows + 1;
        map.put("total", totalPage);
        map.put("rows", lists);
        map.put("page", page);
        map.put("records", totalcounts);
        return map;
    }
}
