package com.jcg.service;

import com.jcg.dao.FileLogDAO;
import com.jcg.entity.FileLog;
import com.jcg.util.ImageUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;

@Service("fileLogService")
@Transactional
public class FileLogServiceImpl implements FileLogService {

    @Autowired
    private FileLogDAO fileLogDAO;

    @Override
    public void delete(String id) {
        fileLogDAO.delete(id);
    }

    @Override
    public List<FileLog> findAllfile() {
        return fileLogDAO.findAll();
    }

    @Override
    public void update(FileLog fileLog) {
        fileLogDAO.update(fileLog);
    }

    @Override
    public List<FileLog> findAll(String id) {
        List<FileLog> fileLogs = fileLogDAO.findAllFilesByUserId(id);
        fileLogs.forEach(fileLog->{
            fileLog.setIsImage(ImageUtils.isImageType(fileLog.getContentType()));
        });
        return fileLogs;
    }

    @Override
    public FileLog find(String id) {
        return fileLogDAO.find(id);
    }

    @Override
    public void save(FileLog fileLog) {
        //生成主键
        fileLog.setId(UUID.randomUUID().toString());
        //赋值上传时间

        //赋值下载次数
        fileLog.setDowncounts(0);
        //保存fileLog
        fileLogDAO.save(fileLog);
    }
}
