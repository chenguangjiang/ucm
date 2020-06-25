package com.jcg.entity;

import com.alibaba.excel.annotation.ExcelIgnore;
import com.alibaba.excel.annotation.ExcelProperty;
import com.alibaba.excel.annotation.write.style.ColumnWidth;
import com.alibaba.excel.annotation.write.style.ContentRowHeight;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ColumnWidth(25)
@ContentRowHeight(20)
public class TimetableData {
    /**
     * 基础数据类
     * @ExcelProperty 指定列名
     * @ExcelIgnore 忽略字段
     **/
    @ExcelProperty("星期")
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
    @ExcelProperty("教室编号")
    private String machineId;

//        @ExcelProperty("数字标题")
//        private Double doubleData;
    /**
     * 忽略这个字段
     */
    @ExcelIgnore
    private String id;

}
