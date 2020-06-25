package com.jcg.service;

import com.jcg.dao.BannerDao;
import com.jcg.entity.Banner;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Service
@Transactional
public class BannerServiceImpl implements BannerService {
    @Autowired
    private BannerDao bannerDao;
    @Override
    public List<Banner> findAll() {
        return bannerDao.findAll();
    }

    @Override
    public Map save(Banner banner) {
        Map<String,Object> map=new HashMap();
        String s = UUID.randomUUID().toString();
        banner.setId(s);
        bannerDao.save(banner);
        map.put("status", 200);
        map.put("bannerId", s);
        return map;
    }

    @Override
    public Map modify(Banner banner) {
        Map<String,Object> map=new HashMap();
        map.put("status", "200");
        bannerDao.update(banner);
        return map;
    }

    @Override
    public Map remove(String id) {
        Map<String,Object> map=new HashMap();
        map.put("status", "200");
        bannerDao.delete(id);
        return map;
    }

    @Override
    public List<Banner> findSearch(String searchField, String searchString, String searchOper, Integer page, Integer rows) {
        int start = (page - 1) * rows;
        return bannerDao.findSearch(searchField, searchString, searchOper, start, rows);
    }

    @Override
    public Long findTotalCountsSearch(String searchField, String searchString, String searchOper) {
        return bannerDao.findTotalCountsSearch(searchField,searchString,searchOper);
    }

    @Override
    public List<Banner> findPage(Integer page, Integer rows) {
        int start = (page - 1) * rows;
        return bannerDao.findByPage(start,rows);
    }

    @Override
    public Long findTotalcounts() {
        return bannerDao.findTotalCounts();
    }
}
