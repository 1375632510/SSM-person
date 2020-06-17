package com.kuang.controller;

import com.kuang.bean.Department;
import com.kuang.bean.Msg;
import com.kuang.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/*
处理部门请求
 */
@Controller
public class DepartmentController {

    @Autowired
    private DepartmentService departmentService;

    @ResponseBody
    @RequestMapping("/depts")
    public Msg getDepts() {
        List<Department> depts = departmentService.getDepts();
        return Msg.success().add("depts",depts);
    }
}
