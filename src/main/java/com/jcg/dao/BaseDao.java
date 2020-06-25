package com.jcg.dao;

import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface BaseDao<T> {
    void save(T t);

    void update(T t);

    void delete(String id);

    T findById(String id);

    List<T> findAll();

    Long findTotalCounts();

    List<T> findByPage(@Param("start") Integer start, @Param("size") Integer size);

    List<T> findAllByid(String id);
}
