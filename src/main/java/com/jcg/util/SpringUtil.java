package com.jcg.util;

import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Component;

@Component
public class SpringUtil implements ApplicationContextAware {
    private static ApplicationContext applicationContext;
    //已经创建好的工厂对象
    @Override
    public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
        SpringUtil.applicationContext=applicationContext;
    }
    //工具对象根据Bean名字获取对象
    public static Object getBean(String name){

      return applicationContext.getBean(name);
    }
    //根据类型获取工厂对象
    public static Object getBean(Class c){
        return applicationContext.getBean(c);
    }
    //联合获取
    public static Object getBean(String name,Class c) {
        return applicationContext.getBean(name, c);
    }
}
