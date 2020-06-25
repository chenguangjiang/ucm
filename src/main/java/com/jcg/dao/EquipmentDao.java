package com.jcg.dao;

import com.jcg.entity.Equipment;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface EquipmentDao extends BaseDao<Equipment> {
    List<Equipment> findAllByRoomId(String id);

    List<Equipment> findSearch(@Param("searchField") String searchField,@Param("searchString") String searchString,@Param("searchOper") String searchOper,@Param("start") Integer page,@Param("size") Integer rows);

    Long findTotalCountsSearch(@Param("searchField") String searchField,@Param("searchString") String searchString,@Param("searchOper") String searchOper);
}
