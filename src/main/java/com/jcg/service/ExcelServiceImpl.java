package com.jcg.service;

import com.jcg.dao.ExcelDataDao;
import com.jcg.entity.TimetableData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;

@Service
@Transactional
public class ExcelServiceImpl implements ExcelService {
    @Autowired
    private ExcelDataDao excelDataDao;
    @Override
    public List<TimetableData> findAll() {
        return excelDataDao.findAll();
    }

    @Override
    public void saveExcelData(TimetableData timetableData) {
        timetableData.setId(UUID.randomUUID().toString());
        excelDataDao.save(timetableData);
    }


}
