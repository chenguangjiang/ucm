package com.jcg;

import com.aliyuncs.CommonRequest;
import com.aliyuncs.CommonResponse;
import com.aliyuncs.DefaultAcsClient;
import com.aliyuncs.IAcsClient;
import com.aliyuncs.exceptions.ClientException;
import com.aliyuncs.exceptions.ServerException;
import com.aliyuncs.http.MethodType;
import com.aliyuncs.profile.DefaultProfile;
import org.junit.Test;

public class testcode {
    @Test
    public void test() {
        DefaultProfile profile = DefaultProfile.getProfile("cn-hangzhou", "LTAI4FgvWdrfGaP3GN7JoEau", "9S85z2gmCjfwb6ZT92mQLOfY2bXZzM");
        IAcsClient client = new DefaultAcsClient(profile);
        CommonRequest request = new CommonRequest();
        request.setMethod(MethodType.POST);
        request.setDomain("dysmsapi.aliyuncs.com");
        request.setVersion("2017-05-25");
        request.setAction("SendSms");
        request.putQueryParameter("RegionId", "cn-hangzhou");
        request.putQueryParameter("PhoneNumbers", "15939995343");
        request.putQueryParameter("SignName", "机房管理");
        request.putQueryParameter("TemplateCode", "SMS_186613408");
        request.putQueryParameter("TemplateParam", "{\"code\":\"8989\"}");
        try {
            CommonResponse response = client.getCommonResponse(request);
            System.out.println(response.getData());
        } catch (ServerException e) {
            e.printStackTrace();
        } catch (ClientException e) {
            e.printStackTrace();
        }
    }
}
