package com.jcg.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
@AllArgsConstructor
@NoArgsConstructor
public class FileLog {
    private String id;
    private String oldFileName;
    private String newFileName;
    private String ext;
    private String path;
    private String filesize;
    private String contentType;
    private Integer downcounts;
    private String uploadDate;

    private Boolean isImage;//业务属性

}
