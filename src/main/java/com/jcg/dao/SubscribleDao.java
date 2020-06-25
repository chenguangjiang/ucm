package com.jcg.dao;

import com.jcg.entity.Subscrible;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface SubscribleDao extends BaseDao<Subscrible> {
    Subscrible findBySubscrible(@Param("week") String week, @Param("room") String room, @Param("phases") String phases,@Param("time") String time);

    List<Subscrible> findByName(String name);

    void remove(String id);
}
