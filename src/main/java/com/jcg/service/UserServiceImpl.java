package com.jcg.service;

import com.jcg.dao.UserDao;
import com.jcg.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;

@Service
@Transactional
public class UserServiceImpl implements UserService {
    @Autowired
    private UserDao userDao;
//登录
    @Override
    public User login(String name ,String password) {
        //根据用户名查询用户
        User userDB = userDao.queryUser(name,password);
//        //判断用户是否存在
//        if(userDB!=null){
                return userDB;
//        }else{
//            throw new RuntimeException("你输入的用户名或密码错误,请重新输入~~");
//        }
    }
//修改密码
    @Override
    public void modify(User user) {
        userDao.update(user);
    }

    @Override
    public User findUser(String name, String phone) {
        return userDao.findUser(name,phone);
    }

    @Override
    public User findUserByName(String name) {
        return userDao.findUserByName(name);
    }

    @Override
    public void delete(String id) {
        userDao.delete(id);
    }

    @Override
    public void save(User user) {
        user.setId(UUID.randomUUID().toString());
        userDao.save(user);
    }

    @Override
    public List<User> findSearch(String searchField, String searchString, String searchOper, Integer page, Integer rows) {

          //  searchField = "u." + searchField;
        int start = (page - 1) * rows;
        return userDao.findSearch(searchField, searchString, searchOper, start, rows);
    }

    @Override
    public Long findTotalCountsSearch(String searchField, String searchString, String searchOper) {
       // searchField = "u." + searchField;
        return userDao.findTotalCountsSearch(searchField,searchString,searchOper);
    }

    @Override
    public List<User> findPage(Integer page, Integer rows) {
        int start = (page - 1) * rows;
        return userDao.findByPage(start,rows);
    }

    @Override
    public Long findTotalcounts() {

        return userDao.findTotalCounts();
    }


}
