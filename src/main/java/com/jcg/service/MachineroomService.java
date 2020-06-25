package com.jcg.service;

import com.jcg.entity.Machineroom;

import java.util.List;

public interface MachineroomService {
    List<Machineroom> findAll();

    void removeById(String id);

    void saveMachineroom(Machineroom machineroom);

    void modifyMachineroom(Machineroom machineroom);

    List<Machineroom> findSearch(String searchField, String searchString, String searchOper, Integer page, Integer rows);

    Long findTotalCountsSearch(String searchField, String searchString, String searchOper);

    List<Machineroom> findPage(Integer page, Integer rows);

    Long findTotalcounts();
    
}
