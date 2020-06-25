package com.jcg.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
@AllArgsConstructor
@NoArgsConstructor
public class Timetable {
    private String id;
    private String weekscount;
    private String teacher;
    private String phases;
    private String curriculum;
    private String classes;
    private String week;

    //机房关系属性
    private Machineroom machineroom;

}
