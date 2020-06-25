package com.jcg.cache;


import com.jcg.util.SpringUtil;
import org.apache.ibatis.cache.Cache;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.serializer.StringRedisSerializer;

import java.util.concurrent.locks.ReadWriteLock;
import java.util.concurrent.locks.ReentrantReadWriteLock;

public class RedisCahe implements Cache{
    public String id;
    public RedisCahe (String id) {
        this.id = id;
    }
    @Override
    public String getId() {
        return id;
    }
    //放入缓存
    @Override
    public void putObject(Object Key, Object Value) {
        //获取对象
        RedisTemplate redisTemplate = (RedisTemplate) SpringUtil.getBean("redisTemplate");
        //存储缓存数据
        redisTemplate.setKeySerializer(new StringRedisSerializer());
        //设置hashkey序列化
        redisTemplate.setHashKeySerializer(new StringRedisSerializer());

        redisTemplate.opsForHash().put(id.toString(),Key.toString(),Value);
    }
    //获取缓存
    @Override
    public Object getObject(Object key) {
        //获取对象
        RedisTemplate redisTemplate = (RedisTemplate) SpringUtil.getBean("redisTemplate");
        //存储缓存数据
        redisTemplate.setKeySerializer(new StringRedisSerializer());
        redisTemplate.setHashKeySerializer(new StringRedisSerializer());
       return redisTemplate.opsForHash().get(id.toString(),key.toString());
    }
    //删除缓存
    @Override
    public Object removeObject(Object o) {
        return null;
    }
    //清除缓存
    @Override
    public void clear() {
        //获取对象
        RedisTemplate redisTemplate = (RedisTemplate) SpringUtil.getBean("redisTemplate");
        //存储缓存数据
        redisTemplate.setKeySerializer(new StringRedisSerializer());
        //清除namespace当中缓存数据
        redisTemplate.delete(id.toString());

    }
    //缓存命中概率
    @Override
    public int getSize() {
        RedisTemplate redisTemplate = (RedisTemplate) SpringUtil.getBean("redisTemplate");
        redisTemplate.setKeySerializer(new StringRedisSerializer());
        //获取namespace当中缓存数据
        return redisTemplate.opsForHash().size(id.toString()).intValue();
    }
    //读写锁  写写互斥  读写不互斥
    @Override
    public ReadWriteLock getReadWriteLock() {
        return new ReentrantReadWriteLock();
    }
}
