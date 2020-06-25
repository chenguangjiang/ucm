package com.jcg.service;

import com.jcg.entity.Equipment;

import java.util.List;

public interface EquipmentService {
    void removeById(String id);

    void saveEquipment(Equipment equipment);

    void modifyEquipment(Equipment equipment);

    Long findTotalcounts();

    //参数1：当前页数 参数2：每页显示几条数据
    List<Equipment> findAll(Integer page, Integer rows);

    List<Equipment> findSearch(String searchField, String searchString, String searchOper, Integer page, Integer rows);

    Long findTotalCountsSearch(String searchField, String searchString, String searchOper);
}
