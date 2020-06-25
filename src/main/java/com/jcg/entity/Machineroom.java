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
public class Machineroom implements Serializable {
    private String id;
    private String name;
    private Integer capacity;
    private String status;

    private Site site;   //机房位置关系属性
}
