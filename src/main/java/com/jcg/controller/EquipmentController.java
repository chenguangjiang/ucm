package com.jcg.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.jcg.entity.Equipment;
import com.jcg.entity.Reaction;
import com.jcg.entity.User;
import com.jcg.service.EquipmentService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.serializer.Jackson2JsonRedisSerializer;
import org.springframework.data.redis.serializer.StringRedisSerializer;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("equipment")
public class EquipmentController {
    @Autowired
    private EquipmentService equipmentService;

    //处理编辑操作
    @RequestMapping("edit")
    @ResponseBody
    public void edit(Equipment equipment, String oper) {
        //添加
        if (StringUtils.equals("add", oper)) {
            equipmentService.saveEquipment(equipment);
        }
//        修改
        if (StringUtils.equals("edit", oper)) {
            equipmentService.modifyEquipment(equipment);
        }
//        删除
        if (StringUtils.equals("del", oper)) {
            equipmentService.removeById(equipment.getId());
        }


    }


    @RequestMapping("findAll")
    @ResponseBody  //jqgrid 分页 key total总页数  page当前页  rows 当前页数据集  records总记录数   参数1字段  参数2值 参数3操作
    public Map<String, Object> findAll(String searchField, String searchString, String searchOper, Integer page, Integer rows, Boolean _search) {

        Map<String, Object> map = new HashMap<>();
        Long totalcounts = null;
        List<Equipment> lists = null;
        if (_search) {
//            根据搜索条件查询集合
            lists = equipmentService.findSearch(searchField, searchString, searchOper, page, rows);
            //根据搜索条件查询总条数
            totalcounts = equipmentService.findTotalCountsSearch(searchField, searchString, searchOper);
        } else {

//        进行分页查询
            lists = equipmentService.findAll(page, rows);
//        总记录数
            totalcounts = equipmentService.findTotalcounts();

        }
        //公共代码
        Long totalPage = totalcounts % rows == 0 ? totalcounts / rows : totalcounts / rows + 1;
        map.put("total", totalPage);
        map.put("rows", lists);
        map.put("page", page);
        map.put("records", totalcounts);
        return map;
    }

    @Autowired
    private RedisTemplate redisTemplate;

    @RequestMapping("reaction")
    @ResponseBody
    public Map reaction(HttpServletRequest request, String machineroom, String ip, String remark, String aname) {
        String atime = new SimpleDateFormat("yyyy-MM-dd HH:mm").format(new Date());
       // String atime = new Date().toString();
        Map<String, Object> map = new HashMap();
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            map.put("code", "300");
            return map;
        } else {
            //序列化Key
            redisTemplate.setKeySerializer(new StringRedisSerializer());
            //序列化value
            Jackson2JsonRedisSerializer<Object> objvalue = new Jackson2JsonRedisSerializer<>(Object.class);
            ObjectMapper objectMapper = new ObjectMapper();
            objectMapper.enableDefaultTyping(ObjectMapper.DefaultTyping.NON_FINAL);
            objvalue.setObjectMapper(objectMapper);
            redisTemplate.setValueSerializer(objvalue);
            Reaction reaction = new Reaction();
            reaction.setAtime(atime);
            reaction.setMachineroom(machineroom);
            reaction.setIp(ip);
            reaction.setRemark(remark);
            reaction.setAname(aname);
            redisTemplate.opsForList().leftPush("reaction", reaction);
            map.put("code", 200);
            map.put("message", "提交成功");
            return map;
        }
    }

    @RequestMapping("information")
    @ResponseBody
    public List<Reaction> information(HttpServletRequest request) {
        //序列化Key
        redisTemplate.setKeySerializer(new StringRedisSerializer());
        //序列化value
        Jackson2JsonRedisSerializer<Object> objvalue = new Jackson2JsonRedisSerializer<>(Object.class);
        ObjectMapper objectMapper = new ObjectMapper();
        objectMapper.enableDefaultTyping(ObjectMapper.DefaultTyping.NON_FINAL);
        objvalue.setObjectMapper(objectMapper);
        redisTemplate.setValueSerializer(objvalue);
        List reactions = redisTemplate.opsForList().range("reaction", 0, -1);
      //  Long size = redisTemplate.opsForList().size("reaction");
        request.getSession().setAttribute("reactions", reactions);
     //   request.getSession().setAttribute("size", size);
//        System.out.println(reactions);
        return reactions;
    }
    @ResponseBody
    @RequestMapping("deletereaction")
    public Map deletereaction(HttpServletRequest request,String atime,String machine,String ip,String remark,String aname) {
        Reaction reaction = new Reaction();
        reaction.setAname(aname);
        reaction.setAtime(atime);
        reaction.setRemark(remark);
        reaction.setIp(ip);
        reaction.setMachineroom(machine);
        //序列化Key
        redisTemplate.setKeySerializer(new StringRedisSerializer());
        //序列化value
        Jackson2JsonRedisSerializer<Object> objvalue = new Jackson2JsonRedisSerializer<>(Object.class);
        ObjectMapper objectMapper = new ObjectMapper();
        objectMapper.enableDefaultTyping(ObjectMapper.DefaultTyping.NON_FINAL);
        objvalue.setObjectMapper(objectMapper);
        redisTemplate.setValueSerializer(objvalue);
        redisTemplate.opsForList().remove("reaction", 1, reaction);
        Map<String,Object> map=new HashMap();
        map.put("code",200);
        map.put("message","delete success");
       return map;
    }
}
