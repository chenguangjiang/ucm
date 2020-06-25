package com.jcg.dao;

import com.jcg.entity.MyFileLog;

import java.util.List;

public interface MyFileLogDao extends BaseDao<MyFileLog> {
    //根据当前用户id查询文件列表
    List<MyFileLog> findAllFilesByUserId(String id);

    MyFileLog find(String id);
}
