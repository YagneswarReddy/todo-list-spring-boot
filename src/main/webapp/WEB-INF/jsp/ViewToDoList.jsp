<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>My ToDo List</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css"
          rel="stylesheet">

    <style>
        body {
            background: #f5f7fb;
            color: #243047;
            font-family: Arial, sans-serif;
        }

        .page-container {
            max-width: 1100px;
            margin: 45px auto;
            padding: 0 18px;
        }

        .main-card {
            background: white;
            border: 1px solid #e7eaf0;
            border-radius: 14px;
            padding: 25px;
            box-shadow: 0 5px 20px rgba(20, 40, 80, 0.05);
        }

        .stat-card {
            border: 1px solid #e7eaf0;
            border-radius: 12px;
            padding: 18px;
            background: white;
            height: 100%;
        }

        .stat-number {
            font-size: 27px;
            font-weight: 700;
            margin-bottom: 3px;
        }

        .stat-label {
            color: #758096;
            font-size: 14px;
        }

        .search-input {
            min-width: 220px;
            border-radius: 8px;
            padding: 10px 12px;
        }

        .table thead th {
            background: #f7f8fc;
            color: #667085;
            font-size: 12px;
            text-transform: uppercase;
            letter-spacing: .4px;
            padding: 14px;
            white-space: nowrap;
        }

        .table tbody td {
            padding: 15px 14px;
            vertical-align: middle;
        }

        .table tbody tr {
            transition: background .18s ease;
        }

        .table tbody tr:hover {
            background: #f5f8ff;
        }

        .status-badge {
            display: inline-block;
            padding: 6px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
        }

        .status-completed {
            color: #16794b;
            background: #dcfce7;
        }

        .status-pending {
            color: #9a6700;
            background: #fff2cc;
        }

        .action-btn {
            margin: 2px;
        }

        .filter-btn.active {
            background: #0d6efd;
            color: white;
            border-color: #0d6efd;
        }

        #emptyMessage {
            display: none;
            text-align: center;
            padding: 35px 10px;
            color: #758096;
        }

        @media (max-width: 576px) {
            .page-container {
                margin: 20px auto;
            }

            .main-card {
                padding: 15px;
            }
        }
    </style>
</head>

<body>
<div class="page-container">

    <div class="d-flex flex-wrap justify-content-between align-items-center gap-3 mb-4">
        <div>
            <h2 class="fw-bold mb-1">My ToDo List</h2>
            <p class="text-secondary mb-0">Organize your tasks and get things done.</p>
        </div>

        <a href="${pageContext.request.contextPath}/addToDoItem"
           class="btn btn-primary px-4 py-2">
            + Add Task
        </a>
    </div>

    <!-- Task statistics -->
    <div class="row g-3 mb-4">
        <div class="col-12 col-sm-4">
            <div class="stat-card">
                <div class="stat-label">Total tasks</div>
                <div class="stat-number" id="totalCount">0</div>
            </div>
        </div>

        <div class="col-12 col-sm-4">
            <div class="stat-card">
                <div class="stat-label">Pending</div>
                <div class="stat-number text-warning" id="pendingCount">0</div>
            </div>
        </div>

        <div class="col-12 col-sm-4">
            <div class="stat-card">
                <div class="stat-label">Completed</div>
                <div class="stat-number text-success" id="completedCount">0</div>
            </div>
        </div>
    </div>

    <div class="main-card">

        <!-- Search and filters -->
        <div class="d-flex flex-wrap justify-content-between align-items-center gap-3 mb-4">

            <input type="search"
                   id="searchInput"
                   class="form-control search-input"
                   placeholder="Search tasks by title..."
                   aria-label="Search tasks">

            <div class="d-flex flex-wrap gap-2">
                <button type="button"
                        class="btn btn-outline-primary filter-btn active"
                        data-filter="all">All</button>

                <button type="button"
                        class="btn btn-outline-primary filter-btn"
                        data-filter="pending">Pending</button>

                <button type="button"
                        class="btn btn-outline-primary filter-btn"
                        data-filter="completed">Completed</button>
            </div>

            <select id="sortSelect" class="form-select"
                    style="width: auto; min-width: 150px;"
                    aria-label="Sort tasks">
                <option value="default">Default order</option>
                <option value="title">Sort by title</option>
                <option value="date">Sort by date</option>
            </select>
        </div>

        <!-- Task table -->
        <div class="table-responsive">
            <table class="table align-middle" id="todoTable">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Task</th>
                    <th>Date</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
                </thead>

                <tbody id="todoTableBody">
                <c:forEach var="todo" items="${list}">
                    <tr class="todo-row"
                        data-title="${todo.title}"
                        data-status="${todo.status}"
                        data-date="${todo.date}"
                        data-id="${todo.id}">

                        <td><c:out value="${todo.id}"/></td>

                        <td class="task-title fw-semibold">
                            <c:out value="${todo.title}"/>
                        </td>

                        <td><c:out value="${todo.date}"/></td>

                        <td>
                            <c:choose>
                                <c:when test="${todo.status eq 'Completed'}">
                                    <span class="status-badge status-completed">
                                        Completed
                                    </span>
                                </c:when>
                                <c:otherwise>
                                    <span class="status-badge status-pending">
                                        <c:out value="${todo.status}"/>
                                    </span>
                                </c:otherwise>
                            </c:choose>
                        </td>

                        <td>
                            <div class="d-flex flex-wrap gap-1">
                                <c:if test="${todo.status ne 'Completed'}">
                                    <a href="${pageContext.request.contextPath}/updateToDoStatus/${todo.id}"
                                       class="btn btn-sm btn-success action-btn">
                                        Complete
                                    </a>
                                </c:if>

                                <a href="${pageContext.request.contextPath}/editToDoItem/${todo.id}"
                                   class="btn btn-sm btn-outline-primary action-btn">
                                    Edit
                                </a>

                                <button type="button"
                                        class="btn btn-sm btn-outline-danger action-btn delete-btn"
                                        data-url="${pageContext.request.contextPath}/deleteToDoItem/${todo.id}"
                                        data-title="${todo.title}">
                                    Delete
                                </button>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>

        <div id="emptyMessage">
            <div class="fs-5 mb-2">No tasks found</div>
            <div>Try another search or select a different filter.</div>
        </div>

        <div class="text-secondary small mt-3" id="resultCount"></div>
    </div>
</div>

<!-- Delete confirmation modal -->
<div class="modal fade" id="deleteModal" tabindex="-1"
     aria-labelledby="deleteModalTitle" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 shadow">
            <div class="modal-header">
                <h5 class="modal-title" id="deleteModalTitle">Delete task?</h5>
                <button type="button" class="btn-close"
                        data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <div class="modal-body">
                Are you sure you want to delete
                <strong id="deleteTaskTitle"></strong>?
                This action cannot be undone.
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-light"
                        data-bs-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-danger"
                        id="confirmDeleteBtn">Delete task</button>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>

<script>
    toastr.options = {
        closeButton: true,
        progressBar: true,
        positionClass: "toast-top-right",
        timeOut: 3500
    };

    // Search, filter and sort
    const searchInput = document.getElementById("searchInput");
    const sortSelect = document.getElementById("sortSelect");
    const tableBody = document.getElementById("todoTableBody");
    const emptyMessage = document.getElementById("emptyMessage");
    const resultCount = document.getElementById("resultCount");

    let activeFilter = "all";
    let deleteUrl = "";

    const originalRows = Array.from(tableBody.querySelectorAll(".todo-row"));

    function isCompleted(row) {
        return (row.dataset.status || "").trim().toLowerCase() === "completed";
    }

    function renderTasks() {
        const query = searchInput.value.trim().toLowerCase();

        let visibleRows = originalRows.filter(row => {
            const title = (row.dataset.title || "").toLowerCase();
            const matchesSearch = title.includes(query);
            const matchesFilter =
                activeFilter === "all" ||
                (activeFilter === "completed" && isCompleted(row)) ||
                (activeFilter === "pending" && !isCompleted(row));

            return matchesSearch && matchesFilter;
        });

        const sortMode = sortSelect.value;

        if (sortMode === "title") {
            visibleRows.sort((a, b) =>
                (a.dataset.title || "").localeCompare(b.dataset.title || "")
            );
        } else if (sortMode === "date") {
            visibleRows.sort((a, b) =>
                (a.dataset.date || "").localeCompare(b.dataset.date || "")
            );
        } else {
            visibleRows.sort((a, b) =>
                Number(a.dataset.id) - Number(b.dataset.id)
            );
        }

        originalRows.forEach(row => row.style.display = "none");

        visibleRows.forEach(row => {
            row.style.display = "";
            tableBody.appendChild(row);
        });

        emptyMessage.style.display = visibleRows.length === 0 ? "block" : "none";
        document.getElementById("todoTable").style.display =
            visibleRows.length === 0 ? "none" : "table";

        resultCount.textContent =
            "Showing " + visibleRows.length + " of " + originalRows.length + " tasks";
    }

    function updateStatistics() {
        const completed = originalRows.filter(isCompleted).length;
        const total = originalRows.length;

        document.getElementById("totalCount").textContent = total;
        document.getElementById("completedCount").textContent = completed;
        document.getElementById("pendingCount").textContent = total - completed;
    }

    searchInput.addEventListener("input", renderTasks);
    sortSelect.addEventListener("change", renderTasks);

    document.querySelectorAll(".filter-btn").forEach(button => {
        button.addEventListener("click", function () {
            activeFilter = this.dataset.filter;

            document.querySelectorAll(".filter-btn").forEach(btn => {
                btn.classList.remove("active");
            });

            this.classList.add("active");
            renderTasks();
        });
    });

    // Delete confirmation
    const deleteModal = new bootstrap.Modal(
        document.getElementById("deleteModal")
    );

    document.querySelectorAll(".delete-btn").forEach(button => {
        button.addEventListener("click", function () {
            deleteUrl = this.dataset.url;
            document.getElementById("deleteTaskTitle").textContent =
                this.dataset.title || "this task";

            deleteModal.show();
        });
    });

    document.getElementById("confirmDeleteBtn").addEventListener("click", function () {
        if (deleteUrl) {
            window.location.href = deleteUrl;
        }
    });

    updateStatistics();
    renderTasks();

    // Notifications after redirect
    const message = "${message}";

    if (message === "Save success") {
        toastr.success("Task added successfully!");
    } else if (message === "Edit success") {
        toastr.success("Task updated successfully!");
    } else if (message === "Delete success") {
        toastr.success("Task deleted successfully!");
    } else if (message === "Update success") {
        toastr.success("Task marked as completed!");
    } else if (
        message === "Save failure" ||
        message === "Edit failure" ||
        message === "Delete failure" ||
        message === "Update failure"
    ) {
        toastr.error("The operation could not be completed.");
    }
</script>

</body>
</html>
