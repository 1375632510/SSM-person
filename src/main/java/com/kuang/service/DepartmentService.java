package com.kuang.service;

import com.kuang.bean.Department;

import java.util.List;

public interface DepartmentService {
    Department getDepartmentById(int id);

    List<Department> getDepts();
}
