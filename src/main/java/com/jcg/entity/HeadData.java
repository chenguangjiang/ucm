package com.jcg.entity;

import com.alibaba.excel.annotation.ExcelProperty;

public class HeadData {
//    @ExcelProperty({"模板标题","星期"})
    @ExcelProperty({"模板标题","星期"})
    private String week;
    @ExcelProperty("课节")
    private String phases;
    @ExcelProperty("课程周期")
    private String weekscount;
    @ExcelProperty("课目")
    private String curriculum;
    @ExcelProperty("老师")
    private String teacher;
    @ExcelProperty("班级")
    private String classes;
    @ExcelProperty("教室")
    private String machineId;
}
