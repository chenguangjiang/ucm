package com.jcg.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

import java.io.Serializable;

@Data
@Accessors(chain = true)
@AllArgsConstructor
@NoArgsConstructor
public class Subscrible implements Serializable {
    private String id;
    private String time;
    private String week;
    private String room;
    private String phases;
    private String name;
    private String classes;
    private String curriculum;
}
