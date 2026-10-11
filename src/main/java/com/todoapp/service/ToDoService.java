package com.todoapp.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.todoapp.model.ToDo;
import com.todoapp.repository.IToDoRepo;

@Service
@Transactional
public class ToDoService {

    private final IToDoRepo repo;

    public ToDoService(IToDoRepo repo) {
        this.repo = repo;
    }

    @Transactional(readOnly = true)
    public List<ToDo> getAllToDoItems() {
        return repo.findAll();
    }

    @Transactional(readOnly = true)
    public ToDo getToDoItemById(Long id) {
        return repo.findById(id).orElse(null);
    }

    public boolean updateStatus(Long id) {
        ToDo todo = getToDoItemById(id);

        if (todo == null) {
            return false;
        }

        todo.setStatus("Completed");
        repo.save(todo);
        return true;
    }

    public boolean saveOrUpdateToDoItem(ToDo todo) {
        if (todo == null
                || todo.getTitle() == null
                || todo.getTitle().isBlank()
                || todo.getDate() == null
                || todo.getStatus() == null
                || todo.getStatus().isBlank()) {
            return false;
        }

        if (todo.getId() > 0 && !repo.existsById(todo.getId())) {
            return false;
        }

        repo.save(todo);
        return true;
    }

    public boolean deleteToDoItem(Long id) {
        if (!repo.existsById(id)) {
            return false;
        }

        repo.deleteById(id);
        return !repo.existsById(id);
    }
}