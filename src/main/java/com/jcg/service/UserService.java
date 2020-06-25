package com.jcg.service;

import com.jcg.entity.User;

import java.util.List;

public interface UserService {
    User login(String name,String password);

    void modify(User user);

    User findUser(String name, String phone);

    User findUserByName(String name);

    void delete(String id);

    void save(User user);

    List<User> findSearch(String searchField, String searchString, String searchOper, Integer page, Integer rows);

    Long findTotalCountsSearch(String searchField, String searchString, String searchOper);

    List<User> findPage(Integer page, Integer rows);

    Long findTotalcounts();
}
