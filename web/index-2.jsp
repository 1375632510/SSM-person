<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: cheny
  Date: 2020/6/7
  Time: 13:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String ctx = request.getContextPath();
    pageContext.setAttribute("ctx", ctx);
%>
<html>
<head>
    <title>员工页面</title>
    <!-- web路径：
    不以/开始的相对路径，找资源，以当前资源的路径为基准，经常容易报错
    以/开始的相对路径找资源，以服务器的路径为标准 http://localhost:8080 需要加上项目名
    必须有网
    -->
    <link href="${ctx}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
    <%--    <script src="https://cdn.bootcss.com/jquery/1.12.4/jquery.min.js"></script>--%>
    <script src="${ctx}/static/js/jquery-3.1.1.js"></script>
    <!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
    <script src="${ctx}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
<!-- 员工修改的模态框 -->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">员工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="email" name="email" class="form-control" id="email_update_input"
                                   placeholder="email@ai.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update_input" value="M" checked> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <!-- 部门提交id提交 -->
                            <select class="form-control" name="dId"">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
            </div>
        </div>
    </div>
</div>

<!-- 员工添加的模态框 -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empName_add_input"
                                   placeholder="empName">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="email" name="email" class="form-control" id="email_add_input"
                                   placeholder="email@ai.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="M" checked> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <!-- 部门提交id提交 -->
                            <select class="form-control" name="dId" id="dept_add_select">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>
<!-- 搭建显示页面 -->
<div class="container">
    <!-- 标题 -->
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <!-- 按钮 -->
    <div class="row">
        <div class="col-md-4 col-md-offset-10">
            <button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
            <button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
        </div>
    </div>
    <!-- 显示表格数据 -->
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                <tr>
                    <th>
                        <input type="checkbox" id="check_all"/>
                    </th>
                    <th>#</th>
                    <th>empName</th>
                    <th>gender</th>
                    <th>email</th>
                    <th>deptName</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>
    <!-- 显示分页信息 -->
    <div class="row">
        <!-- 分页信息 -->
        <div class="col-md-6" id="page_info_area">

        </div>
        <!-- 分页条 -->
        <div class="col-md-6" id="page_nav_area">

        </div>
    </div>
</div>
<script type="text/javascript">

    var totalRecord, currentPage;
    //1.页面加载完成以后，直接去发送一个ajax请求，要到分页数据
    $(function () {
        to_Page(1);
    });

    function to_Page(pn) {
        $.ajax({
            url: "${ctx}/emps",
            data: "pn=" + pn,
            type: "get",
            success: function (result) {
                //console.log(result)
                //1.解析员工数据
                build_emps_table(result);
                build_page_info(result);
                build_page_nav(result);
            }
        });
    }

    function build_emps_table(result) {
        //清空table表格
        $("#emps_table tbody").empty();
        var emps = result.extend.pageInfo.list;
        $.each(emps, function (index, item) {
            var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
            //alert(item.empName);
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var genderTd = $("<td></td>").append(item.gender == 'M' ? "男" : "女");
            var emailTd = $("<td></td>").append(item.email);
            var deptNameTd = $("<td></td>").append(item.department.deptName);
            var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil"))
                .append("编辑");
            var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash"))
                .append("删除");
            //为编辑按钮添加自定义的属性，来表示当前员工id
            editBtn.attr("edit-id", item.empId);
            var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
            $("<tr></tr>").append(checkBoxTd)
                .append(empIdTd).append(empNameTd)
                .append(genderTd).append(emailTd)
                .append(deptNameTd).append(btnTd)
                .appendTo("#emps_table tbody");
            delBtn.attr("del-id", item.empId);
        });
    }

    //解析分页信息
    function build_page_info(result) {
        $("#page_info_area").empty();
        $("#page_info_area").append("当前" + result.extend.pageInfo.pageNum +
            "页，总" + result.extend.pageInfo.pages +
            "页，" + result.extend.pageInfo.total + "条记录");
        totalRecord = result.extend.pageInfo.total;
        currentPage = result.extend.pageInfo.pageNum;
    }

    //解析分页条,点击动作
    function build_page_nav(result) {
        $("#page_nav_area").empty();
        var ul = $("<ul></ul>").addClass("pagination");
        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));
        var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
        if (result.extend.pageInfo.hasPreviousPage == false) {
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled")
        } else {
            firstPageLi.click(function () {
                to_Page(1);
            });
            prePageLi.click(function () {
                to_Page(result.extend.pageInfo.pageNum - 1);
            });
        }
        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
        var LastPageLi = $("<li></li>").append($("<a></a>").append("尾页").attr("href", "#"));
        if (result.extend.pageInfo.hasNextPage == false) {
            nextPageLi.addClass("disabled");
            LastPageLi.addClass("disabled");
        } else {
            nextPageLi.click(function () {
                to_Page(result.extend.pageInfo.pageNum + 1);
            });
            LastPageLi.click(function () {
                to_Page(result.extend.pageInfo.pages);
            });
        }
        ul.append(firstPageLi).append(prePageLi);
        $.each(result.extend.pageInfo.navigatepageNums, function (index, item) {
            var numLi = $("<li></li>").append($("<a></a>").append(item));
            if (result.extend.pageInfo.pageNum == item) {
                numLi.addClass("active");
            }
            numLi.click(function () {
                to_Page(item);
            });
            ul.append(numLi);
        });
        ul.append(nextPageLi).append(LastPageLi);

        var navEle = $("<nav></nav>").append(ul);
        navEle.appendTo("#page_nav_area");
    }

    /**
     * 表单重置
     */
    function reset_form(ele) {
        //重置表单内容
        $(ele)[0].reset();
        //重置表单样式
        $(ele).find("*").removeClass("has-error has_success");
        $(ele).find(".help-block").text("");
    }

    //点进新增按钮当初模态框
    $("#emp_add_modal_btn").click(function () {
        //清楚表单数据
        //$("#empAddModal form")[0].reset();
        reset_form("#empAddModal form");
        //发送ajax请求，查出部门信息，显示在下拉列表
        getDepts("#empAddModal select");
        $("#empAddModal").modal({
            backdrop: "static"
        });
    });

    //查询部门信息
    function getDepts(ele) {
        //清楚下拉列表信息
        $(ele).empty();
        $.ajax({
            url: "${ctx}/depts",
            type: "GET",
            success: function (result) {
                //console.log(result);
                //$("#dept_add_select").append("");
                //每次使用之前记得清空
                $("#dept_add_select").empty();
                $.each(result.extend.depts, function (index, item) {
                    var optionEle = $("<option></option>").append(item.deptName).attr("value", item.deptId);
                    optionEle.appendTo(ele);
                });
            }
        });
    }

    //校验表单数据
    function validate_add_form() {
        //拿到数据、使用正则表达式
        var empName = $("#empName_add_input").val();
        var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
        if (!regName.test(empName)) {
            //alert("用户名是可以是2-5位中文或者是6-16英文和数字的组合");
            show_validate_msg("#empName_add_input", "error", "用户名是可以是2-5位中文或者是6-16英文和数字的组合");
            return false;
        } else {
            show_validate_msg("#empName_add_input", "success", "");
        }

        var email = $("#email_add_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regEmail.test(email)) {
            //alert("邮箱格式不正确");
            show_validate_msg("#email_add_input", "error", "邮箱格式不正确");
            return false;
        } else {
            show_validate_msg("#email_add_input", "success", "");
        }
        return true;
    }

    function show_validate_msg(ele, status, msg) {
        //清除当前状态
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text("");
        if ("success" == status) {
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        } else if ("error" == status) {
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }

    //校验用户名是否可用
    $("#empName_add_input").change(function () {
        //发送ajax请求校验用户名是否可用
        var empName = this.value;
        $.ajax({
            url: "${ctx}/checkuser",
            data: "empName=" + empName,
            type: "POST",
            success: function (result) {
                if (result.code == 100) {
                    show_validate_msg("#empName_add_input", "success", "用户名可用");
                    $("#emp_save_btn").attr("ajax-va", "success");
                } else {
                    show_validate_msg("#empName_add_input", "error", result.extend.va_msg);
                    $("#emp_save_btn").attr("ajax-va", "error");
                }
            }
        });
    });

    //点击保存，员工
    $("#emp_save_btn").click(function () {
        //1.模态框中填写的表单数据提交给服务器进行保存
        //需要提交校验
        //2.发送ajax请求
        //alert($("#empAddModal form").serialize());
        if (!validate_add_form()) {
            return false;
        }
        //判断之前的ajax用户名校验是否成功
        if ($(this).attr("ajax-va") == "error") {
            return false;
        }
        $.ajax({
            url: "${ctx}/emp",
            type: "POST",
            data: $("#empAddModal form").serialize(),
            success: function (result) {
                //alert(result.msg);
                if (result.code == 100) {
                    //员工保存成功
                    //关闭模态框
                    $("#empAddModal").modal('hide');
                    //来到最后一页
                    //发送ajax请求显示最后一页数据即可
                    to_Page(totalRecord);
                } else {
                    //显示失败信息
                    //console.log((result))
                    if (undefined != result.extend.errorFields.email) {
                        //显示邮箱错误信息
                        show_validate_msg("#email_add_input", "error", result.extend.errorFields.email)
                    }
                    if (undefined != result.extend.errorFields.empName) {
                        //显示员工名字的错误信息
                        show_validate_msg("#empName_add_input", "error", result.extend.errorFields.empName)
                    }
                }
            }
        });
    });

    //live()绑定方法,新版本使用on
    $(document).on("click", ".edit_btn", function () {
        //查出员工信息
        //查出部门信息
        getDepts("#empUpdateModal select");
        getEmp($(this).attr("edit-id"));

        //打开模态框传递id到更新
        $("#emp_update_btn").attr("edit-id", $(this).attr("edit-id"));
        $("#empUpdateModal").modal({
            backdrop: "static"
        });
    });

    function getEmp(id) {
        $.ajax({
            url: "${ctx}/emp/" + id,
            type: "get",
            success: function (result) {
                //console.log(result)
                var empData = result.extend.emp;
                $("#empName_update_static").text(empData.empName);
                $("#email_update_input").val(empData.email);
                $("#empUpdateModal input[name=gender]").val([empData.gender]);
                $("#empUpdateModal select").val([empData.dId]);
            }
        })
    }

    //点击更新，更新员工信息
    $("#emp_update_btn").click(function () {
        var email = $("#email_update_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regEmail.test(email)) {
            //alert("邮箱格式不正确");
            show_validate_msg("#email_update_input", "error", "邮箱格式不正确");
            return false;
        } else {
            show_validate_msg("#email_update_input", "success", "");
        }
        //发送ajax请求
        $.ajax({
            url: "${ctx}/emp/" + $(this).attr("edit-id"),
            type: "PUT",
            data: $("#empUpdateModal form").serialize(),
            success: function (result) {
                //alert(result.msg)
                //关闭对话框
                $("#empUpdateModal").modal("hide");
                //回到本页面
                to_Page(currentPage);
            }
        })
    })

    //单个删除
    $(document).on("click", ".delete_btn", function () {
        //弹出确认删除的确认框
        var empName = $(this).parents("tr").find("td:eq(2)").text();
        var empId = $(this).attr("del-id");
        //alert($(this).parents("tr").find("td:eq(1)").text());
        if (confirm("确认删除[" + empName + "]吗？")) {
            //确认，发送ajax请求
            $.ajax({
                url: "${ctx}/emp/" + empId,
                type: "DELETE",
                success: function (result) {
                    //alert(result.msg);
                    to_Page(currentPage);
                }
            })
        }
    })

    //完成全选和全不选
    $("#check_all").click(function () {
        $(".check_item").prop("checked", $(this).prop("checked"));
    })

    //check_item
    $(document).on("click", ".check_item", function () {
        var flag = $(".check_item:checked").length == $(".check_item").length
        $("#check_all").prop("checked", flag);
    })

    //点进全部删除就批量删除
    $("#emp_delete_all_btn").click(function () {
        var empNames = "";
        var del_idstr = "";
        $.each($(".check_item:checked"), function () {
            empNames += $(this).parents("tr").find("td:eq(2)").text() + ",";
            del_idstr += $(this).parents("tr").find("td:eq(1)").text() + "-";
        });
        empNames = empNames.substring(0, empNames.length - 1);
        del_idstr = del_idstr.substring(0,del_idstr.length-1);
        if (confirm("确认删除[" + empNames + "]吗？")) {
            //发送ajax请求
            $.ajax({
                url: "${ctx}/emp/" + del_idstr,
                type: "delete",
                success: function (result) {
                    alert(result.msg);
                    //回到当前页
                    to_Page(currentPage)
                }
            })
        }
    })
</script>

</body>
</html>
