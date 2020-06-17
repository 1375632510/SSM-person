package com.kuang.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.kuang.bean.Employee;
import com.kuang.bean.Msg;
import com.kuang.service.DepartmentService;
import com.kuang.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/*
处理员工CRUD请求
 */
@Controller
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;

    @Autowired
    DepartmentService departmentService;

    /*
    单个、批量二合一
     */
    @ResponseBody
    @RequestMapping(value = "/emp/{ids}",method = RequestMethod.DELETE)
    public Msg deleteEmp(@PathVariable("ids") String ids){
        if(ids.contains("-")){
            List<Integer> del_ids = new ArrayList<>();
            String[] str_ids = ids.split("-");
            for (String id : str_ids) {
                del_ids.add(Integer.parseInt(id));
            }
            int i = employeeService.deleteBatch(del_ids);
        }else {
            int i = employeeService.deleteEmp(Integer.parseInt(ids));
        }
        return Msg.success();
    }

    /*
    如果直接发送ajax=PUT的请求
    数据封装除了标注的，其他全是null
    问题：请求体有数据，Employee对象封装不上,然后动态sql报出语法服务器
    原因：tomcat，
    将请求体中的数据封装一个map
    request.getParameter("empName")将会从这个map取值
    SpringmVC封装pojo的对象时，调用request.getParameter取值
    AJAX发送PUT请求不能直接发，tomcat一看是PUT请求就不会封装数据为map，只有POST才可以封装
    解决方法：
    我们要能支持PUT请求需要封装请求体的数据
    配置上HttpFromContentFilter
    将请求体中的数据封装成一个map
    Request.getParameter被重写,就会从自己封装的map取数据
     */
    @RequestMapping(value = "/emp/{empId}",method = RequestMethod.PUT)
    @ResponseBody
    public Msg savaEmp(Employee employee, HttpServletRequest request){
        int i = employeeService.updateEmp(employee);
        return null;
    }

    @RequestMapping(value = "/emp/{id}",method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmp(@PathVariable("id") int id) {
        Employee employee = employeeService.getEmp(id);
        return Msg.success().add("emp",employee);
    }

    @RequestMapping("/checkuser")
    @ResponseBody
    public Msg checkuser(@RequestParam("empName") String empName) {
        //判断用户名是否合法的表达式
        String regx = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
        if (!empName.matches(regx)) {
            return Msg.fail().add("va_msg", "用户名必须是6-16位数字和字母的组合或者2-5位中文");
        }

        //数据库校验
        boolean b = employeeService.checkUser(empName);
        if (b) {
            return Msg.success();
        } else {
            return Msg.fail().add("va_msg", "用户名不可用");
        }
    }

    /*
    restful风格
    员工保存
    JSR303校验需要导入hibernate-validator
     */
    @RequestMapping(value = "/emp", method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(@Valid Employee employee, BindingResult result) {
        if (result.hasErrors()) {
            //在后端显示失败信息
            Map<String, Object> map = new HashMap<>();
            List<FieldError> errors = result.getFieldErrors();
            for (FieldError fieldError : errors) {
                System.out.println("错误的字段名:" + fieldError.getField());
                System.out.println("错误信息" + fieldError.getDefaultMessage());
                map.put(fieldError.getField(), fieldError.getDefaultMessage());
            }
            return Msg.fail().add("errorFields", map);
        } else {
            employeeService.saveEmp(employee);
            return Msg.success();
        }
    }

    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmpsWithJson(
            @RequestParam(value = "pn", defaultValue = "1") int pn) {
        PageHelper.startPage(pn, 5);
        //后面紧跟的查询就是分页查询
        List<Employee> emps = employeeService.getAllEmps();
        for (Employee emp : emps) {
            emp.setDepartment(departmentService.getDepartmentById(emp.getdId()));
        }
        //pageinfo包装查询后的结果,封装了详细数据
        PageInfo page = new PageInfo(emps, 5);
        return Msg.success().add("pageInfo", page);
    }


    //@RequestMapping("/emps")
    public String getEmps(@RequestParam(value = "pn", defaultValue = "1") int pn, Model model) {
        //这不是一个分页查询
        //引入PageHelper分页插件
        //在查询之前只需要调用
        PageHelper.startPage(pn, 5);
        //后面紧跟的查询就是分页查询
        List<Employee> emps = employeeService.getAllEmps();
        for (Employee emp : emps) {
            emp.setDepartment(departmentService.getDepartmentById(emp.getdId()));
        }
        //pageinfo包装查询后的结果,封装了详细数据
        PageInfo page = new PageInfo(emps, 5);

        model.addAttribute("pageinfo", page);

        return "list";
    }
}
