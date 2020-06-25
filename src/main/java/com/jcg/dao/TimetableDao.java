package com.jcg.dao;

import com.jcg.entity.Timetable;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface TimetableDao extends BaseDao<Timetable> {

    List<Timetable> findSearch(@Param("searchField") String searchField, @Param("searchString") String searchString, @Param("searchOper") String searchOper, @Param("start") Integer page, @Param("size") Integer rows);

    Long findTotalCountsSearch(@Param("searchField") String searchField,@Param("searchString") String searchString,@Param("searchOper") String searchOper);

    List<Timetable> findByweekandmachine(@Param("week") String week, @Param("machineId") String machineId);

    List<Timetable> findByAplicant(@Param("week") String week, @Param("mname") String mname,@Param("phases") String phases);
}
