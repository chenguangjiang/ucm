package com.jcg.service;

import com.jcg.entity.FileLog;

import java.util.List;

public interface FileLogService {
    //保存文件上传记录
    void save(FileLog fileLog);

    //根据用户id获取指定用户的文件记录
    List<FileLog> findAll(String id);

    //根据文件id查询一个文件详细
    FileLog find(String id);

    //根据id更新下载次数
    void update(FileLog fileLog);

    //根据id删除指定的文件
    void delete(String id);

    List<FileLog> findAllfile();
}
