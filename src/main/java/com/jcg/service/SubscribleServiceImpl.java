package com.jcg.service;

import com.jcg.dao.SubscribleDao;
import com.jcg.entity.Subscrible;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;

@Service
@Transactional
public class SubscribleServiceImpl implements SubscribleService {
    @Autowired
    private SubscribleDao subscribleDao;
    @Override
    public Subscrible findBySubscrible(String week, String room, String phases,String time) {
        return  subscribleDao.findBySubscrible(week, room, phases,time);
    }

    @Override
    public List<Subscrible> findAll() {
        return subscribleDao.findAll();
    }

    @Override
    public void delete(String id) {
            subscribleDao.delete(id);
    }

    @Override
    public void save(Subscrible subscrible) {
        subscrible.setId(UUID.randomUUID().toString());
        subscribleDao.save(subscrible);
    }

    @Override
    public List<Subscrible> findAllByName(String name) {
        return subscribleDao.findByName(name);
    }

    @Override
    public void remove(String id) {
        subscribleDao.remove(id);
    }

    @Override
    public Subscrible findById(String id) {
        return subscribleDao.findById(id);
    }

    @Override
    public void update(Subscrible subscrible) {
        subscribleDao.update(subscrible);
    }
}
