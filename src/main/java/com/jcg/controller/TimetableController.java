package com.jcg.controller;

import com.alibaba.excel.EasyExcel;
import com.alibaba.excel.ExcelReader;
import com.alibaba.excel.read.metadata.ReadSheet;
import com.jcg.entity.Subscrible;
import com.jcg.entity.Timetable;
import com.jcg.entity.TimetableData;
import com.jcg.entity.User;
import com.jcg.service.ExcelService;
import com.jcg.service.SubscribleService;
import com.jcg.service.TimetableService;
import com.jcg.util.TimetableDataListener;
import com.jcg.util.dateToWeekUtil;
import io.goeasy.GoEasy;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.*;
@Controller
@RequestMapping("timetable")
public class TimetableController {
    @Autowired
    private TimetableService timetableService;

    //处理编辑操作
    @RequestMapping("edit")
    @ResponseBody
    public void edit(Timetable timetable, String oper) {
        //添加
        if (StringUtils.equals("add",oper)) {
            timetableService.saveTimetable(timetable);
        }
//        修改
        if (StringUtils.equals("edit",oper)) {
            timetableService.modifyTimetable(timetable);
        }
//        删除
        if (StringUtils.equals("del",oper)) {
            timetableService.removeById(timetable.getId());
        }
    }

    @RequestMapping("findAll")
    @ResponseBody  //jqgrid 分页 key total总页数  page当前页  rows 当前页数据集  records总记录数   参数1字段  参数2值 参数3操作
    public Map<String, Object> findAll(String searchField, String searchString, String searchOper, Integer page, Integer rows, Boolean _search) {

        Map<String, Object> map = new HashMap<>();
        Long totalcounts = null;
        List<Timetable> lists = null;
        if (_search) {
//            根据搜索条件查询集合
            lists = timetableService.findSearch(searchField, searchString, searchOper, page, rows);
            //根据搜索条件查询总条数
            totalcounts = timetableService.findTotalCountsSearch(searchField, searchString, searchOper);
        } else {

//        进行分页查询
            lists = timetableService.findPage(page, rows);
//        总记录数
            totalcounts = timetableService.findTotalcounts();

        }
        //公共代码
        Long totalPage = totalcounts % rows == 0 ? totalcounts / rows : totalcounts / rows + 1;
        map.put("total", totalPage);
        map.put("rows", lists);
        map.put("page", page);
        map.put("records", totalcounts);
        return map;
    }

    @RequestMapping("findByweekandroom")
    @ResponseBody
    public List<Timetable> findByweekandroom(String machineroom, String weeks, Model model) {
        List<Timetable> timetables = timetableService.findByweekandmachine(weeks, machineroom);
        return timetables;

    }
    //导出课程
    @Autowired
    private ExcelService excelService;
    @RequestMapping("exportData")
    @ResponseBody
    public void importData() {
        List<TimetableData> timetableList =excelService.findAll() ;
        String dateDir = new SimpleDateFormat("yyyy-MM-dd-HH-mm").format(new Date());
        String fileName = "C:\\Users\\姜晨光\\Desktop\\" + dateDir + "TimetableData.xls";
        EasyExcel.write(fileName, TimetableData.class).sheet().doWrite(timetableList);
    }
    //导出模板
    @RequestMapping("exportModel")
    @ResponseBody
    public void exportModel() {
        TimetableData timetableData = new TimetableData();
        List<TimetableData> asList = Arrays.asList(timetableData);
        String dateDir = new SimpleDateFormat("yyyy-MM-dd-HH-mm").format(new Date());
        String fileName = "C:\\Users\\姜晨光\\Desktop\\" + dateDir + "TimetableHeadData.xls";
        EasyExcel.write(fileName, TimetableData.class).sheet().doWrite(asList);
    }

    //导入课程
    @RequestMapping("importData")
    public String exportData(MultipartFile aaa, HttpServletRequest request) throws IOException {
        //原始文件名
        String oldFilename = aaa.getOriginalFilename();
        //扩展名
        String ext = FilenameUtils.getExtension(oldFilename);
        //生成新的文件名
        String newFileName = UUID.randomUUID().toString().replace("-","")
                + "."
                + ext;
        //根据相对files路径获取绝对路径
        String realPath = request.getSession().getServletContext().getRealPath("/files");
        //每天创建一个日期文件夹
        String dateDir = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
        //创建不存在目录
        File dirDirectory = new File(realPath, dateDir);
        if(!dirDirectory.exists()){
            dirDirectory.mkdirs();//递归创建目录
        }
        //文件上传
        aaa.transferTo(new File(dirDirectory,newFileName));
        String name = dirDirectory+"\\"+newFileName;
        ExcelReader reader = EasyExcel.read(name, TimetableData.class, new TimetableDataListener()).build();
        ReadSheet sheet = EasyExcel.readSheet(0).build();
        reader.read(sheet);
        reader.finish();
//        GoEasy goEasy = new GoEasy("http://rest-hangzhou.goeasy.io", "BC-af22f9e733984c9398af346bb6e59d7e");
//        goEasy.publish("jcg", "恭喜你导入数据成功");
        return "redirect:/back/home/home.jsp";
    }
    @Autowired
    private DeleteController deleteController;
//    预约申请
    @Autowired
    private SubscribleService subscribleService;
    @RequestMapping("applicant")
    @ResponseBody
    public Map applicant(HttpServletRequest request,String time, String phases, String room, String name, String curriculum, String classes) {
        Map<String, Object> map = new HashMap();
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            map.put("code", "300");
            return map;
        } else {
            String week = dateToWeekUtil.dateToWeek(time);
            List<Timetable> timetable = timetableService.findByAplicant(week, room, phases);
            Subscrible subscribles = subscribleService.findBySubscrible(week, room, phases, time);
            //判断日期是否为当前月
            Calendar cal = Calendar.getInstance();
            Integer month = cal.get(Calendar.MONTH) + 1;
            String month2 = "";
            if (month < 10) {
                month2 = "0" + month.toString();
            } else {
                month2 = month.toString();
            }
            String str = time.substring(5, 7);
            if (timetable != null && !timetable.isEmpty() || subscribles != null) {
                map.put("code", 200);
                return map;
            } else {
                if (month2.equals(str)) {
                    Subscrible subscrible = new Subscrible();
                    subscrible.setName(name);
                    subscrible.setWeek(week);
                    subscrible.setClasses(classes);
                    subscrible.setTime(time);
                    subscrible.setCurriculum(curriculum);
                    subscrible.setPhases(phases);
                    subscrible.setRoom(room);
                    subscribleService.save(subscrible);
                    deleteController.run();
                    map.put("code", 202);
                    GoEasy goEasy = new GoEasy("http://rest-hangzhou.goeasy.io", "BC-af22f9e733984c9398af346bb6e59d7e");
                    goEasy.publish("jcg", "恭喜用户 " + name + " 成功预约" + room + ",上课时间:" + time + "第" + phases);
                    return map;
                } else {
                    map.put("code", 201);
                    return map;
                }
            }
        }
    }
}
