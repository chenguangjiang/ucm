package com.jcg;

import io.goeasy.GoEasy;
import org.junit.Test;

public class testgoeasy extends UcmApplication {
    @Test
    public  void test2() {
//          String jsonString = JSONObject.toJSONString(userDto);
        GoEasy goEasy = new GoEasy("http://rest-hangzhou.goeasy.io","BC-64449ef96f244726825d3b4f26fa7e3c");
//          System.out.println(jsonString);
//          goEasy.publish("jg",jsonString);
        goEasy.publish("jcg","hello");
    }
}
