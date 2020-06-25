package com.jcg.dao;

import com.jcg.entity.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserDao extends BaseDao<User>{
    User queryUser(@Param("name") String name,@Param("password")String password);
    User findUser(@Param("name") String name,@Param("phone")String phone);
    User findUserByName(String name);
    List<User> findSearch(@Param("searchField") String searchField, @Param("searchString") String searchString, @Param("searchOper") String searchOper, @Param("start") Integer page, @Param("size") Integer rows);

    Long findTotalCountsSearch(@Param("searchField") String searchField,@Param("searchString") String searchString,@Param("searchOper") String searchOper);
}
