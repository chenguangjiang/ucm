package com.jcg.service;

import com.jcg.dao.EquipmentDao;
import com.jcg.entity.Equipment;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;

@Service
@Transactional
public class EquipmentServiceImpl implements EquipmentService {
    @Autowired
    private EquipmentDao equipmentDao;
    //删除
    @Override
    public void removeById(String id) {
        equipmentDao.delete(id);
    }
    //添加
    @Override
    public void saveEquipment(Equipment equipment)
    {
        equipment.setId(UUID.randomUUID().toString());
        equipmentDao.save(equipment);
    }
    //修改
    @Override
    public void modifyEquipment(Equipment equipment) {
        equipmentDao.update(equipment);
    }

    @Override
    public Long findTotalcounts() {
        return equipmentDao.findTotalCounts();
    }


    @Override
    public List<Equipment> findAll(Integer page, Integer rows) {
        int start = (page - 1) * rows;
        return equipmentDao.findByPage(start,rows);
    }

    @Override
    public List<Equipment> findSearch(String searchField, String searchString, String searchOper, Integer page, Integer rows) {
        if(searchField.equals("machineroom.id"))
        {
            searchField = "m.name";
        }else {
            searchField = "e." + searchField;
        }
        int start = (page - 1) * rows;
        return equipmentDao.findSearch(searchField, searchString, searchOper, start, rows);
    }

    @Override
    public Long findTotalCountsSearch(String searchField, String searchString, String searchOper) {
        if(searchField.equals("machineroom.id"))
        {
            searchField = "m.name";
        }else {
            searchField = "e." + searchField;
        }
        return equipmentDao.findTotalCountsSearch(searchField,searchString,searchOper);
    }
}
