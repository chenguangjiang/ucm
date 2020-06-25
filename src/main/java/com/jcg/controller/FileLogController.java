package com.jcg.controller;

import com.alibaba.druid.util.StringUtils;
import com.jcg.entity.FileLog;
import com.jcg.entity.MyFileLog;
import com.jcg.entity.User;
import com.jcg.service.FileLogService;
import com.jcg.service.MyFileLogService;
import io.goeasy.GoEasy;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("filelog")
public class FileLogController {

    @Autowired
    private FileLogService fileLogService;
    @Autowired
    private MyFileLogService myFileLogService;

    //根据当前登录的用户查询用户的所有文件下载次数
    @RequestMapping("findAllJSON")
    @ResponseBody//使用jackson
    public List<FileLog> findAllJSON(HttpServletRequest request){
        //获取登录系统用户
        //根据用户查询当前用户文件记录的下载次数
        List<FileLog> fileLogs = fileLogService.findAllfile();
        return fileLogs;
    }


    //处理用户的文件删除
    @RequestMapping("delete")
    public String delete(String id,HttpServletRequest request){
        //根据文件id查询文件基础信息
        MyFileLog fileLog = myFileLogService.find(id);
        //根据文件基础信息读取指定文件然后删除
        String newFileName = fileLog.getNewFileName();
        String path = fileLog.getPath();
        String realPath = request.getSession().getServletContext().getRealPath(path);
        File file = new File(realPath, newFileName);
        if(file.exists()){
            file.delete();
        }
        //根据文件id删除文件记录
        myFileLogService.delete(fileLog.getId());
        return "redirect:/filelog/findAll";
    }


    //处理用户下载文件
    @RequestMapping("download")
    public void download(String openStyle,String id, HttpServletRequest request, HttpServletResponse response) throws IOException {
        //获取用户当前下载文件标识attachment以附件的形式下载  inline在线打开
        openStyle = openStyle==null?"attachment":openStyle;
        //根据id获取指定要下载文件的基础信息
        FileLog  fileLog = fileLogService.find(id);
        //更新下载次数  StringUtils判断opensStyle是否等于attachment
        if(StringUtils.equals(openStyle,"attachment")){
            User user = (User) request.getSession().getAttribute("user");
            fileLog.setDowncounts(fileLog.getDowncounts()+1);
            fileLogService.update(fileLog);
            MyFileLog myFileLog = new MyFileLog();
            String date = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
            myFileLog.setExt(fileLog.getExt())
                    .setContentType(fileLog.getContentType())
                    .setFilesize(fileLog.getFilesize())
                    .setOldFileName(fileLog.getOldFileName())
                    .setNewFileName(fileLog.getNewFileName())
                    .setUploadDate(date)
                    .setPath(fileLog.getPath())
                    .setUser(user);
            myFileLogService.save(myFileLog);
        }
        //根据文件基础信息读取指定目录中文件
        String newFileName = fileLog.getNewFileName();
        //获取原始文件名
        String oldFileName = fileLog.getOldFileName();
        String realpath = fileLog.getPath();
        //根据相对获取绝对
        String real = request.getSession().getServletContext().getRealPath(realpath);
        //文件下载操作
        File file = new File(real, newFileName);
        //设置响应类型
        response.setHeader("content-disposition",openStyle+";fileName="+ URLEncoder.encode(oldFileName,"UTF-8"));
        response.setContentType(fileLog.getContentType());
        //通过文件输入流读取下载文件
        FileInputStream is = new FileInputStream(file);
        ServletOutputStream os = response.getOutputStream();
        //文件下载
        IOUtils.copy(is,os);
        IOUtils.closeQuietly(is);
        IOUtils.closeQuietly(os);
    }


    //用来查询当前登录用户的所有文件记录
    @RequestMapping("findAll")
    public String findAll(HttpServletRequest request){
        //获取当前登录用户
        User user = (User) request.getSession().getAttribute("user");
        //根据当前登录用户查询所有文件
        List<MyFileLog> fileLogs =  myFileLogService.findAll(user.getId());
        //保存数据
        request.setAttribute("fileLogs",fileLogs);
        return "user/mydownload";
    }
    //用来查询当前登录用户的所有文件记录
    @RequestMapping("findAllfile")
    public String findAllfile(HttpServletRequest request){


        List<FileLog> fileLogs =  fileLogService.findAllfile();
        //保存数据
        request.setAttribute("fileLogs",fileLogs);
        return "front/main/download";
    }

    //用来处理用户的文件上传    MultipartFile  用来接受文件
    @RequestMapping("save")
    public String saveFileLog(MultipartFile aaa, HttpServletRequest request) throws IOException {

        //原始文件名
        String oldFilename = aaa.getOriginalFilename();
        //扩展名
        String ext = FilenameUtils.getExtension(oldFilename);
        //生成新的文件名
        String newFileName = UUID.randomUUID().toString().replace("-","")
                                + "."
                                + ext;
        //获取文件相关信息
        System.out.println("原始名称: "+ oldFilename);
        //获取文件类型
        String contentType = aaa.getContentType();
        System.out.println("文件类型: "+ contentType);
        //获取文件大小
        long size = aaa.getSize();
        System.out.println("文件大小: "+ size);
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
        //保存文件记录
        FileLog fileLog = new FileLog();
         fileLog.setExt("."+ext)
                .setContentType(contentType)
                .setFilesize(String.valueOf(size))
                .setOldFileName(oldFilename)
                .setNewFileName(newFileName)
                 .setUploadDate(dateDir)
                .setPath("/files/"+dateDir);
        fileLogService.save(fileLog);
        GoEasy goEasy = new GoEasy("http://rest-hangzhou.goeasy.io", "BC-af22f9e733984c9398af346bb6e59d7e");
        goEasy.publish("jcg2", "上传成功。");
        return "redirect:/back/home/home.jsp";
    }

}
