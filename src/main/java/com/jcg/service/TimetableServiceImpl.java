package com.jcg.service;

import com.jcg.dao.TimetableDao;
import com.jcg.entity.Timetable;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;

@Service
@Transactional
public class TimetableServiceImpl implements TimetableService {
    @Autowired
    private TimetableDao timetableDao;
    @Transactional(propagation = Propagation.SUPPORTS)
    @Override
    public List<Timetable> findAll() {
        return timetableDao.findAll();
    }

    @Override
    public void removeById(String id) {
        timetableDao.delete(id);
    }

    @Override
    public void saveTimetable(Timetable timetable) {
        timetable.setId(UUID.randomUUID().toString());
        timetableDao.save(timetable);
    }

    @Override
    public void modifyTimetable(Timetable timetable) {
        timetableDao.update(timetable);
    }

    @Override
    public List<Timetable> findSearch(String searchField, String searchString, String searchOper, Integer page, Integer rows) {

        if(searchField.equals("machineroom.id")) {
            searchField = "m.name";
        }else {
            searchField = "t." + searchField;
        }
        int start = (page - 1) * rows;
        return timetableDao.findSearch(searchField, searchString, searchOper, start, rows);
    }

    @Override
    public Long findTotalCountsSearch(String searchField, String searchString, String searchOper) {
        if(searchField.equals("machineroom.id")) {
            searchField = "m.name";
        }else {
            searchField = "t." + searchField;
        }
        return timetableDao.findTotalCountsSearch(searchField,searchString,searchOper);
    }

    @Override
    public List<Timetable> findPage(Integer page, Integer rows) {
        int start = (page - 1) * rows;
        return timetableDao.findByPage(start,rows);
    }

    @Override
    public Long findTotalcounts() {
        return timetableDao.findTotalCounts();
    }

    @Override
    public List<Timetable> findByweekandmachine(String week, String machineId) {
       return timetableDao.findByweekandmachine(week, machineId);
    }

    @Override
    public List<Timetable> findByAplicant(String week, String mname, String phases) {
        return timetableDao.findByAplicant(week,mname,phases);
    }

    @Override
    public List<Timetable> findByid(String id) {
        return timetableDao.findAllByid(id);
    }
}
