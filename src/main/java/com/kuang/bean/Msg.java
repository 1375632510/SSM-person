package com.kuang.bean;

import lombok.Data;

import java.util.HashMap;
import java.util.Map;

/*
通用的返回的类
 */
@Data
public class Msg {
    //状态码 100成功，200错误
    private int code;
    //提示信息
    private String msg;
    //用户返回给浏览器的数据
    private Map<String,Object> extend = new HashMap<>();
    
    public static Msg success(){
        Msg result = new Msg();
        result.setCode(100);
        result.setMsg("处理成功！");
        return result;
    }

    public static Msg fail(){
        Msg result = new Msg();
        result.setCode(200);
        result.setMsg("处理失败！");
        return result;
    }

    //链式处理
    public Msg add(String key,Object value){
        this.getExtend().put(key,value);
        return this;
    }
}
