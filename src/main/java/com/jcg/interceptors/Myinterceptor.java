package com.jcg.interceptors;

import com.jcg.entity.User;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Component
public class Myinterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object o) throws Exception {
        //强制登陆
        User user = (User) request.getSession().getAttribute("user");
        if (user != null) {
            return true;
        }
        else {
            String homeUrl = request.getContextPath();
            System.out.println("a"+homeUrl);
            if (request.getHeader("x-requested-with") != null && request.getHeader("x-requested-with").equalsIgnoreCase("XMLHttpRequest")){
                response.setHeader("SESSIONSTATUS", "TIMEOUT");
                response.setHeader("CONTEXTPATH", homeUrl+"/user/login.jsp");
                // FORBIDDEN，forbidden。也就是禁止、403
                response.setStatus(HttpServletResponse.SC_FORBIDDEN);
            }else{
                // 如果不是 ajax 请求，则直接跳转即可
                response.sendRedirect(homeUrl+"/login.jsp");
            }
            return false;
        }
    }

    @Override
    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {

    }

    @Override
    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {

    }
}
