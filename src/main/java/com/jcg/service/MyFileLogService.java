package com.jcg.service;

import com.jcg.entity.MyFileLog;

import java.util.List;

public interface MyFileLogService {
    //保存文件上传记录
    void save(MyFileLog myFileLog);

    //根据用户id获取指定用户的文件记录
    List<MyFileLog> findAll(String id);

    //根据文件id查询一个文件详细
    MyFileLog find(String id);

    //根据id更新下载次数
    void update(MyFileLog myFileLog);

    //根据id删除指定的文件
    void delete(String id);

    List<MyFileLog> findAllfile();
}
