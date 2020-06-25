package com.jcg.service;

import com.jcg.entity.TimetableData;

import java.util.List;

public interface ExcelService {
    List<TimetableData> findAll();

    void saveExcelData(TimetableData timetableData);

}
