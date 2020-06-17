package com.kuang.service;

import com.kuang.bean.Employee;

import java.util.List;

public interface EmployeeService {
    List<Employee> getAllEmps();

    void saveEmp(Employee employee);

    boolean checkUser(String empName);

    Employee getEmp(int id);

    int updateEmp(Employee employee);

    int deleteEmp(int id);

    int deleteBatch(List<Integer> ids);
}
