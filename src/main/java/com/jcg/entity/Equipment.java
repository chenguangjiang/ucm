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
public class Equipment implements Serializable {
    private String id;
    private String name;
    private String ipadress;
    private String software;
    private boolean status;
    private String remark;

    private Machineroom machineroom;  //机房关系属性
}
