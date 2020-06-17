package com.kuang.test;

import com.kuang.service.EmployeeService;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

public class DaoTest {

    @Autowired
    private EmployeeService employeeService;

    @Test
    public void test01(){
        boolean b = employeeService.checkUser("tomcat");
        System.out.println(b);
    }
}
