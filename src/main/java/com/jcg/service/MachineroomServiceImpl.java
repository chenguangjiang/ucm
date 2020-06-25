package com.jcg.service;

import com.jcg.dao.EquipmentDao;
import com.jcg.dao.MachineroomDao;
import com.jcg.dao.TimetableDao;
import com.jcg.entity.Equipment;
import com.jcg.entity.Machineroom;
import com.jcg.entity.Timetable;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;

@Service
@Transactional
public class MachineroomServiceImpl implements MachineroomService {
    @Autowired
    private TimetableDao timetableDao;
    @Autowired
    private MachineroomDao machineroomDao;
    @Autowired
    private EquipmentDao equipmentDao;

    @Transactional(propagation = Propagation.SUPPORTS)
    //查询所有
    @Override
    public List<Machineroom> findAll() {

        return machineroomDao.findAll();
    }
    //删除
    @Override
    public void removeById(String id) {
        try {
            //删除机房并删除该机房下的设备
            List<Equipment> equipmentList = equipmentDao.findAllByRoomId(id);
            for (Equipment equipment:equipmentList
                 ) {
                equipmentDao.delete(equipment.getId());
            }
            //删除机房并删除该机房下的排课
            List<Timetable> daoAllByid = timetableDao.findAllByid(id);
            for (Timetable timetable:daoAllByid
                    ) {
                timetableDao.delete(timetable.getId());
            }
            machineroomDao.delete(id);
        }catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("删除机房失败");
        }

    }
//添加
    @Override
    public void saveMachineroom(Machineroom machineroom) {
        machineroom.setId(UUID.randomUUID().toString());
        machineroomDao.save(machineroom);

    }
//修改
    @Override
    public void modifyMachineroom(Machineroom machineroom) {
        machineroomDao.update(machineroom);
    }
//分页搜索
    @Override
    public List<Machineroom> findSearch(String searchField, String searchString, String searchOper, Integer page, Integer rows) {
        if(searchField.equals("site.id"))
        {
            searchField = "s.name";
        }else {
            searchField = "m." + searchField;
        }
        int start = (page - 1) * rows;
        return machineroomDao.findSearch(searchField, searchString, searchOper, start, rows);

    }
//根据分页查询所有
    @Override
    public Long findTotalCountsSearch(String searchField, String searchString, String searchOper) {
        if(searchField.equals("site.id"))
        {
            searchField = "s.name";
        }else {
            searchField = "m." + searchField;
        }
        return machineroomDao.findTotalCountsSearch(searchField,searchString,searchOper);
    }
//查询总页数
    @Override
    public List<Machineroom> findPage(Integer page, Integer rows) {
        int start = (page - 1) * rows;
        return machineroomDao.findByPage(start,rows);
    }
//查询总记录数
    @Override
    public Long findTotalcounts() {

        return machineroomDao.findTotalCounts();
    }
}
