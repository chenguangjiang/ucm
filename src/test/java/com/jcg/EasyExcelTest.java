package com.jcg;

import com.alibaba.excel.EasyExcel;
import com.alibaba.excel.ExcelReader;
import com.alibaba.excel.read.metadata.ReadSheet;
import com.jcg.entity.TimetableData;
import com.jcg.util.TimetableDataListener;
import org.junit.Test;

import java.io.FileNotFoundException;
import java.util.Date;

public class EasyExcelTest extends UcmApplication  {
    @Test
    public void testInput() throws FileNotFoundException {
        String str="C:\\Users\\姜晨光\\Desktop\\excel\\2020-03-17-17-24TimetableData.xls";
        ExcelReader reader = EasyExcel.read(str, TimetableData.class, new TimetableDataListener()).build();
        ReadSheet sheet = EasyExcel.readSheet(0).build();
        reader.read(sheet);
        reader.finish();
    }
    @Test
    public void testTimeStap(){
        Date date = new Date();
        long time = date.getTime();
        System.out.println(time);

    }
}
