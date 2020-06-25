package com.jcg.controller;

import com.jcg.service.SubscribleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.scheduling.concurrent.ThreadPoolTaskScheduler;
import org.springframework.scheduling.support.CronTrigger;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import java.util.Date;

@Component
@Service
public class DeleteController {
    @Autowired
    private SubscribleService subscribleService;
    @Autowired
    private ThreadPoolTaskScheduler threadPoolTaskScheduler;
    @Bean
    public ThreadPoolTaskScheduler threadPoolTaskScheduler() {
        return new ThreadPoolTaskScheduler();
    }
    public void run() {
        Runnable runnable = new Runnable() {
            @Override
            public void run() {
                subscribleService.delete("1");
                System.out.println(new Date()+"已经清空预约课程信息");

            }
        };
        //threadPoolTaskScheduler.schedule(runnable, new CronTrigger("0/5 * * * * ?"));//每搁五秒执行
        threadPoolTaskScheduler.schedule(runnable, new CronTrigger("0 0 0 1 * ?"));//每月1号0点执行
    }
    public void shutDown() {
        threadPoolTaskScheduler.shutdown();
    }
}
