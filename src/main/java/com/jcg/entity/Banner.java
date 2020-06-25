package com.jcg.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Banner implements Serializable{
    private String id;
    private String title;
    private String url;
    private String href;
    private String ldate;
    private String ldesc;
    private String lstatus;

}
