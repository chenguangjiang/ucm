package com.jcg.dao;

import com.jcg.entity.Banner;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface BannerDao extends BaseDao<Banner> {

    List<Banner> findSearch(@Param("searchField") String searchField, @Param("searchString") String searchString, @Param("searchOper") String searchOper, @Param("start") Integer page, @Param("size") Integer rows);

    Long findTotalCountsSearch(@Param("searchField") String searchField,@Param("searchString") String searchString,@Param("searchOper") String searchOper);
}
