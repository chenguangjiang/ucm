package com.jcg.service;

import com.jcg.dao.SiteDao;
import com.jcg.entity.Site;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Transactional
@Service
public class SiteServiceImpl implements SiteService {
    @Autowired
    private SiteDao siteDao;
    @Transactional(propagation = Propagation.SUPPORTS)
    @Override
    public List<Site> findAll() {
        return siteDao.findAll();
    }
}
