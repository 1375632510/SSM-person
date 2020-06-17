package com.kuang.service;

import com.kuang.bean.Employee;
import com.kuang.bean.EmployeeExample;
import com.kuang.bean.EmployeeExample.Criteria;
import com.kuang.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmployeeServiceImpl implements EmployeeService {

    @Autowired
    EmployeeMapper employeeMapper;

    @Override
    public List<Employee> getAllEmps() {
        return employeeMapper.selectByExample(null);
    }

    @Override
    public void saveEmp(Employee employee) {
        employeeMapper.insertSelective(employee);
    }

    @Override
    public boolean checkUser(String empName) {
        EmployeeExample example = new EmployeeExample();
        Criteria criteria = example.createCriteria();
        criteria.andEmpNameEqualTo(empName);
        long count = employeeMapper.countByExample(example);
        return count==0;
    }

    @Override
    public Employee getEmp(int id) {
        Employee employee = employeeMapper.selectByPrimaryKey(id);
        return employee;
    }

    @Override
    public int updateEmp(Employee employee) {
        int i = employeeMapper.updateByPrimaryKeySelective(employee);
        return i;
    }

    @Override
    public int deleteEmp(int id) {
        int i = employeeMapper.deleteByPrimaryKey(id);
        return i;
    }

    @Override
    public int deleteBatch(List<Integer> ids) {
        EmployeeExample example = new EmployeeExample();
        Criteria criteria = example.createCriteria();
        criteria.andEmpIdIn(ids);
        int i = employeeMapper.deleteByExample(example);
        return i;
    }


}
