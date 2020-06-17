package com.kuang.service;

import com.kuang.bean.Department;
import com.kuang.dao.DepartmentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DepartmentServiceImpl implements DepartmentService {

    @Autowired
    DepartmentMapper departmentMapper;

    @Override
    public Department getDepartmentById(int id) {
        return departmentMapper.selectByPrimaryKey(id);
    }

    @Override
    public List<Department> getDepts() {
        return departmentMapper.selectByExample(null);
    }
}
