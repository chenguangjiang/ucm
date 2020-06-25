package com.jcg.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
@AllArgsConstructor
@NoArgsConstructor
public class MyFileLog{
    private String id;
    private String oldFileName;
    private String newFileName;
    private String ext;
    private String path;
    private String filesize;
    private String contentType;
    private String uploadDate;
    private Integer downcounts;
    private Boolean isImage;//业务属性


    private User user;//关系属性
}
