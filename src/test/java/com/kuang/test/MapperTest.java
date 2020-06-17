package com.kuang.test;

import com.kuang.dao.DepartmentMapper;
import com.kuang.dao.EmployeeMapper;
import com.kuang.service.EmployeeService;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

/*
导入Springtest模块
使用注解@ContextConfiguration
选用SpringJUnit4ClassRunner
autowired
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {

    @Autowired
    DepartmentMapper departmentMapper;

    @Autowired
    EmployeeMapper employeeMapper;


    @Autowired
    SqlSession sqlsesion;

    @Autowired
    EmployeeService employeeService;

    @Test
    public void test01(){
        /*ApplicationContext ac = new ClassPathXmlApplicationContext("classpath:applicationContext.xml");
        DepartmengMapper bean = ac.getBean(DepartmengMapper.class);
        */
        //System.out.println(departmentMapper);
        //departmentMapper.insertSelective(new Department(null,"开发部"));
        //departmentMapper.insertSelective(new Department(null,"测试部"));

        //System.out.println(employeeMapper);
        //employeeMapper.insertSelective(new Employee(null,"Jerry","M","Jerry@ai.com",1));
        //批量插入uuid
        //EmployeeMapper mapper = sqlsesion.getMapper(EmployeeMapper.class);
        /*for (int i = 0; i < 1000; i++) {
            String uuid = UUID.randomUUID().toString().substring(0, 5)+i;
            mapper.insertSelective(new Employee(null,uuid,"M",uuid+"@ai.com",1));
        }*/
        System.out.println(employeeService);
    }
}
