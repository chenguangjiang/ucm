package com.jcg.controller;

import com.jcg.entity.User;
import com.jcg.service.UserService;
import com.jcg.util.ImageUtil;
import com.jcg.util.MessageUtil;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;

/**
 * Created by HIAPAD on 2019/10/29.
 */
@Controller
@RequestMapping("user")
public class UserController {

    @Autowired
    private RedisTemplate redisTemplate;
    @Autowired
    private UserService userService;


    //处理登录
    @RequestMapping("login")
    @ResponseBody
    public Map login(String code, String name, String password, HttpServletRequest request,HttpServletResponse response)  {
            Map<String, Object> map = new HashMap();
            //获取session中验证码
            String sessionCode = (String) request.getSession().getAttribute("code");
            //比较验证码 忽略大小写比较
            if (sessionCode.equalsIgnoreCase(code)) {
                //进行登录
                User userDB = userService.login(name, password);
                if (userDB != null) {
                    //保存用户
                    request.getSession().setAttribute("user", userDB);
                    if (userDB.getUsertype().equals("管理员")) {
                        map.put("code", "201");
                        map.put("message", "成功");
                        return map;
                    } else {
                        map.put("code", "200");
                        map.put("username", name);
                        map.put("message", "成功");
                        return map;
                    }
                } else {
                    map.put("code", "203");
                    map.put("message", "用户名或者密码有误，请重新输入！");
                    return map;
                }
            } else {
                map.put("code", "202");
                map.put("message", "验证码错误！");
                // return "redirect:/user/login.jsp?msg=" + URLEncoder.encode(e.getMessage(), "UTF-8");
                return map;
            }
    }
    //验证码
    @RequestMapping("getImageCode")
    @ResponseBody
    public void imageCode(HttpServletRequest request, HttpServletResponse response) throws IOException {
        //获取验证码字符串
        char[] randomChar = ImageUtil.getRandomChar();
        //放入session中
        request.getSession().setAttribute("code",new String(randomChar));
        //根据随机字符串获取验证码
        BufferedImage image = ImageUtil.getImage(randomChar);
        //输出验证码
        ImageIO.write(image,"png",response.getOutputStream());
    }
//    获取验证码
    @RequestMapping("returncode")
    @ResponseBody
    public Map code(HttpServletRequest request,String name,String phone) {
        //生成验证码
        String code = String.valueOf((int)((Math.random()*9+1)*1000));
        Map<String,Object> map=new HashMap();
        //用户查找
        User user = userService.findUser(name, phone);
        request.getSession().setAttribute("user",user);
        if (user==null)
        {
            map.put("code", "201");
            map.put("message", "你的手机号和你的用户名不匹配，请重新输入！");
            return map;
        }else {
            //发送验证信息
            MessageUtil.sendMessage(phone,code);
            request.setAttribute("user",user);
            //往redis存入信息
            redisTemplate.opsForValue().set(phone,code,60, TimeUnit.SECONDS);
            map.put("code", "200");
            map.put("message", "发送成功,请在1分钟内完成输入提交！");
            return map;
        }
    }
//    提交确认
    @RequestMapping("confirm")
    @ResponseBody
    public Map confirm(String phone,String code) {
        Map<String,Object> map=new HashMap();
        Object o = redisTemplate.opsForValue().get(phone);
        if (o.equals(code))
        {
            map.put("code", "200");
            return map;
        }
        else {
            map.put("code", "201");
            map.put("message", "验证码错误！");
            return map;
        }
    }
//    重置密码
    @RequestMapping("reset")
    @ResponseBody
    public Map rest(String name,String password,String password2) {
        Map<String,Object> map=new HashMap();
        if (password.equals(password2))
        {
            //密码重置
            User userByName = userService.findUserByName(name);
            userByName.setPassword(password2);
            userService.modify(userByName);
            map.put("code", "200");
            map.put("message", "重置密码成功！");
            return map;
        }
        else {

            map.put("code", "201");
            map.put("message", "输入两次密码不一致！");
            return map;
        }
    }
    //修改密码
    @RequestMapping("updatepassword")
    @ResponseBody
    public Map updatepassword(HttpServletRequest request,String name,String password,String password2) {
        Map<String,Object> map=new HashMap();
        User user = userService.login(name, password);
        if(user!=null){
            user.setPassword(password2);
            userService.modify(user);
            map.put("code", "200");
            map.put("message", "修改密码成功！");
            request.getSession().invalidate();
            return map;
        }else {
            map.put("code", "300");
            map.put("message", "原始密码不正确！");
            return map;
        }
    }
    //清除缓存
    @RequestMapping("clearname")
    public String clearname(HttpServletRequest request) {
        request.getSession().invalidate();
        return "redirect:/user/login.jsp";
    }



    //处理编辑操作
    @RequestMapping("edit")
    @ResponseBody
    public void edit(User user, String oper) {
        //添加
        if (StringUtils.equals("add",oper)) {
            userService.save(user);
        }
//        修改
        if (StringUtils.equals("edit",oper)) {
            userService.modify(user);
        }
//        删除
        if (StringUtils.equals("del",oper)) {
            userService.delete(user.getId());
        }


    }


    @RequestMapping("findAll")
    @ResponseBody  //jqgrid 分页 key total总页数  page当前页  rows 当前页数据集  records总记录数   参数1字段  参数2值 参数3操作
    public Map<String, Object> findAll(String searchField, String searchString, String searchOper, Integer page, Integer rows, Boolean _search) {

        Map<String, Object> map = new HashMap<>();
        Long totalcounts = null;
        List<User> lists = null;
        if (_search) {
//            根据搜索条件查询集合
            lists = userService.findSearch(searchField, searchString, searchOper, page, rows);
            //根据搜索条件查询总条数
            totalcounts = userService.findTotalCountsSearch(searchField, searchString, searchOper);
        } else {

//        进行分页查询
            lists = userService.findPage(page, rows);
//        总记录数
            totalcounts = userService.findTotalcounts();

        }
        //公共代码
        Long totalPage = totalcounts % rows == 0 ? totalcounts / rows : totalcounts / rows + 1;
        map.put("total", totalPage);
        map.put("rows", lists);
        map.put("page", page);
        map.put("records", totalcounts);
        return map;
    }

//    @RequestMapping("mydownload")
//    public String mydownload(String name,String password, HttpServletRequest request) {
//            User userDB = userService.login(name,password);
//            //放入session作用域
//            request.getSession().setAttribute("user",userDB);
//            return "redirect:/filelog/findAll";
//    }

}
