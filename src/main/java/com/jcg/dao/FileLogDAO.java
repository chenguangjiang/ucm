package com.jcg.dao;

import com.jcg.entity.FileLog;

import java.util.List;

public interface FileLogDAO extends BaseDao<FileLog> {

    //根据当前用户id查询文件列表
    List<FileLog> findAllFilesByUserId(String id);

    FileLog find(String id);
}
