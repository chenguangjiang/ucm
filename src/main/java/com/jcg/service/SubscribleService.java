package com.jcg.service;

import com.jcg.entity.Subscrible;

import java.util.List;

public interface SubscribleService {
    Subscrible findBySubscrible(String week, String room, String phases,String time);

    List<Subscrible> findAll();

    void delete(String id);

    void save(Subscrible subscrible);

    List<Subscrible> findAllByName(String name);

    void remove(String id);

    Subscrible findById(String id);

    void update(Subscrible subscrible);
}
