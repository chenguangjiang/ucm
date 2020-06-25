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
public class Reaction implements Serializable{
    private String atime;
    private String machineroom;
    private String ip;
    private String remark;
    private String aname;
}
