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

public class User implements Serializable {
    private String id;
    private String name;
    private String password;
    private String truename;
    private String usertype;
    private String phone;
}
