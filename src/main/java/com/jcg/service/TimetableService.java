package com.jcg.service;

import com.jcg.entity.Timetable;

import java.util.List;

public interface TimetableService {
    List<Timetable> findAll();

    void removeById(String id);

    void saveTimetable(Timetable timetable);

    void modifyTimetable(Timetable timetable);

    List<Timetable> findSearch(String searchField, String searchString, String searchOper, Integer page, Integer rows);

    Long findTotalCountsSearch(String searchField, String searchString, String searchOper);

    List<Timetable> findPage(Integer page, Integer rows);

    Long findTotalcounts();

    List<Timetable> findByweekandmachine(String week,String machineId);

    List<Timetable> findByAplicant(String week, String mname, String phases);

    List<Timetable> findByid(String id);

}
