package com.jcg;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.serializer.Jackson2JsonRedisSerializer;
import org.springframework.data.redis.serializer.StringRedisSerializer;

public class testRides extends UcmApplication{
    @Autowired
   private RedisTemplate redisTemplate;
    @Test
    public void test1() {

        //序列化Key
        redisTemplate.setKeySerializer(new StringRedisSerializer());
        //序列化value
        Jackson2JsonRedisSerializer<Object> objvalue = new Jackson2JsonRedisSerializer<>(Object.class);
        ObjectMapper objectMapper = new ObjectMapper();
        objectMapper.enableDefaultTyping(ObjectMapper.DefaultTyping.NON_FINAL);
        objvalue.setObjectMapper(objectMapper);
        redisTemplate.setValueSerializer(objvalue);

//        Aplicant aplicant = new Aplicant();
//        aplicant.setName("xx老师");
//        aplicant.setRoom("D-301机房");
//        aplicant.setTime("2020-03-15");
//        aplicant.setWeek("星期日");
//        aplicant.setPhases("3-4节");
////     //   redisTemplate.opsForValue().set("a1",aplicant);
////        redisTemplate.opsForList().leftPush("user",aplicant);
////        List user = redisTemplate.opsForList().range("user", 0, -1);
//        redisTemplate.opsForList().remove("aplicant", 1, aplicant);
//        System.out.println(aplicant);
////        Aplicant a1 =(Aplicant) redisTemplate.opsForValue().get("a1");
////        System.out.println(a1);
    }
    @Test
    public void test2() {


    }
}
