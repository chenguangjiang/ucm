package com.jcg.config;

import com.jcg.interceptors.Myinterceptor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

@Component
//用来自定义拦截器
public class InterceptConfig extends WebMvcConfigurerAdapter {
    @Autowired
    private Myinterceptor myinterceptor;
    //覆盖父类添加拦截器方法  参数  拦截器注册对象
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
//               registry.addInterceptor(myinterceptor)
//                .addPathPatterns("/machineroom/**")
//                .excludePathPatterns("/machineroom/findMachineroomName")
//                .addPathPatterns("/timetable/**")
//                       .excludePathPatterns("/timetable/findByweekandroom")
//                .excludePathPatterns("/user/returncode");

    }
}
