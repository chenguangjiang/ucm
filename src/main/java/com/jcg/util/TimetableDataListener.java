package com.jcg.util;

import com.alibaba.excel.context.AnalysisContext;
import com.alibaba.excel.event.AnalysisEventListener;
import com.jcg.entity.TimetableData;
import com.jcg.service.ExcelService;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class TimetableDataListener extends AnalysisEventListener<TimetableData> {

    private List<TimetableData> lists = new ArrayList<>();

    @Override
    public void invoke(TimetableData timetableData, AnalysisContext analysisContext) {

        lists.add(timetableData);

    }

    @Override
    public void doAfterAllAnalysed(AnalysisContext analysisContext) {
       input();
    }
    public void input(){
        ExcelService excelService = (ExcelService)SpringUtil.getBean(ExcelService.class);
        for (TimetableData list : lists) {
            System.out.println(list);
        }
        for(int i=0;i<lists.size();i++){
              excelService.saveExcelData(lists.get(i));
            System.out.println(lists.get(i).getId()+"入库成功");
        }


    }
}
