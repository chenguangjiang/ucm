package com.jcg.service;

import com.jcg.dao.MyFileLogDao;
import com.jcg.entity.MyFileLog;
import com.jcg.util.ImageUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;

@Service
@Transactional
public class MyFileLogServiceImpl implements MyFileLogService {

    @Autowired
    private MyFileLogDao myFileLogDAO;

    @Override
    public void delete(String id) {
        myFileLogDAO.delete(id);
    }

    @Override
    public List<MyFileLog> findAllfile() {
        return myFileLogDAO.findAll();
    }

    @Override
    public void update(MyFileLog fileLog) {
        myFileLogDAO.update(fileLog);
    }

    @Override
    public List<MyFileLog> findAll(String id) {
        List<MyFileLog> fileLogs = myFileLogDAO.findAllFilesByUserId(id);
        fileLogs.forEach(fileLog->{
            fileLog.setIsImage(ImageUtils.isImageType(fileLog.getContentType()));
        });
        return fileLogs;
    }

    @Override
    public MyFileLog find(String id) {
        return myFileLogDAO.find(id);
    }

    @Override
    public void save(MyFileLog myFileLog) {
        //生成主键
        myFileLog.setId(UUID.randomUUID().toString());
        //赋值上传时间

        //赋值下载次数
        myFileLog.setDowncounts(0);
        //保存fileLog
        myFileLogDAO.save(myFileLog);
    }
}
