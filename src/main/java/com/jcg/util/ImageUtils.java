package com.jcg.util;

import java.util.HashMap;
import java.util.Map;

public class ImageUtils {

    //判断图片类型 如果图片类型为image开头类型
    public static Boolean isImageType(String contentType){
        if(contentType.startsWith("image"))return true;
        return false;
    }

    //参数1: 后缀
    public static Boolean isImage(String ext){
        //保存图片后缀已知的数据模型
        Map<String,Boolean> map = new HashMap<String,Boolean>();
        map.put(".png",true);
        map.put(".jpeg",true);
        map.put(".jpg",true);
        if(map.containsKey(ext)){
            return map.get(ext);
        }
        return false;
    }

}
