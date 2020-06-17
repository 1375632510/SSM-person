package com.kuang.test;

import com.github.pagehelper.PageInfo;
import com.kuang.bean.Employee;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;


/*
使用Spring测试，测试CRUD的请求
spring4测试的时候，需要Servlet3.0以上的支持
 */
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {"classpath:applicationContext.xml", "classpath:spring-mcv.xml"})
public class MvcTest {
    //springmvc的ioc
    @Autowired
    WebApplicationContext context;

    MockMvc mockMvc;

    @Before
    public void initMockMvc() {
        mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
    }

    //Servlet2.5使用不了，升级至3.0，servlet-api --》 javax.servlet-api
    @Test
    public void testPage() throws Exception {
        //模拟请求
        MvcResult result = mockMvc.perform(MockMvcRequestBuilders
                .get("/emps").param("pn", "5"))
                .andReturn();
        System.out.println(result);
        MockHttpServletRequest request = result.getRequest();
        PageInfo p = (PageInfo) request.getAttribute("pageinfo");
        System.out.println("当前页码：" + p.getPageNum());
        System.out.println("总页码：" + p.getPages());
        System.out.println("总记录数：" + p.getTotal());
        System.out.println("连续页码:");
        int[] nums = p.getNavigatepageNums();
        for (int num : nums) {
            System.out.print(num+" ");
        }
        System.out.println();
        //获取员工数据
        List<Employee> list = p.getList();
        for (Employee employee : list) {
            System.out.println(employee);
        }

    }
}
