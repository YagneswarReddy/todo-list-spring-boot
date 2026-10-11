
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Edit Task</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css"
          rel="stylesheet">

    <style>
        body {
            background: #f5f7fb;
            color: #243047;
        }

        .form-card {
            max-width: 650px;
            margin: 45px auto;
            padding: 30px;
            background: white;
            border: 1px solid #e7eaf0;
            border-radius: 14px;
            box-shadow: 0 5px 20px rgba(20, 40, 80, 0.05);
        }

        .form-control, .form-select {
            padding: 11px 12px;
            border-radius: 8px;
        }

        .form-control:focus, .form-select:focus {
            border-color: #86b7fe;
            box-shadow: 0 0 0 3px rgba(13, 110, 253, .12);
        }
    </style>
</head>

<body>
<div class="container px-3">
    <div class="form-card">
        <h2 class="fw-bold mb-2">Edit task</h2>
        <p class="text-secondary mb-4">Update the task details below.</p>

        <form:form action="${pageContext.request.contextPath}/editSaveTDoItem"
                   method="post"
                   modelAttribute="todo">

            <form:hidden path="id"/>

            <div class="mb-4">
                <label for="title" class="form-label fw-semibold">Task title</label>
                <form:input path="title"
                            id="title"
                            cssClass="form-control"
                            placeholder="Enter task title"
                            required="required"
                            maxlength="200"/>
            </div>

            <div class="mb-4">
                <label for="date" class="form-label fw-semibold">Due date</label>
                <form:input path="date"
                            type="date"
                            id="date"
                            cssClass="form-control"
                            required="required"/>
            </div>

            <div class="mb-4">
                <label for="status" class="form-label fw-semibold">Status</label>
                <form:select path="status" id="status" cssClass="form-select">
                    <form:option value="Incomplete">Pending</form:option>
                    <form:option value="Completed">Completed</form:option>
                </form:select>
            </div>

            <div class="d-flex flex-wrap gap-2">
                <button type="submit" class="btn btn-primary px-4">
                    Update task
                </button>

                <a href="${pageContext.request.contextPath}/viewToDoList"
                   class="btn btn-light border px-4">
                    Cancel
                </a>
            </div>
        </form:form>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>

<script>
    toastr.options = {
        closeButton: true,
        progressBar: true,
        positionClass: "toast-top-right",
        timeOut: 3500
    };

    const message = "${message}";

    if (message === "Edit failure") {
        toastr.error("Unable to update the task. Please try again.");
    }
</script>
</body>
</html>
