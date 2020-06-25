package com.jcg.service;

import com.jcg.entity.Banner;

import java.util.List;
import java.util.Map;

public interface BannerService {
    List<Banner> findAll();

    Map save(Banner banner);

    Map modify(Banner banner);

    Map remove(String id);

    List<Banner> findSearch(String searchField, String searchString, String searchOper, Integer page, Integer rows);

    Long findTotalCountsSearch(String searchField, String searchString, String searchOper);

    List<Banner> findPage(Integer page, Integer rows);

    Long findTotalcounts();
}
