package com.todoapp.controller;

import com.todoapp.model.ToDo;
import com.todoapp.service.ToDoService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class ToDoController {

    private final ToDoService service;

    public ToDoController(ToDoService service) {
        this.service = service;
    }

    @GetMapping({"/", "/viewToDoList"})
    public String viewAllToDoItems(
            Model model,
            @ModelAttribute("message") String message) {

        model.addAttribute("list", service.getAllToDoItems());
        model.addAttribute("message", message);

        return "ViewToDoList";
    }

    @GetMapping("/updateToDoStatus/{id}")
    public String updateToDoStatus(
            @PathVariable Long id,
            RedirectAttributes redirectAttributes) {

        if (service.updateStatus(id)) {
            redirectAttributes.addFlashAttribute(
                    "message", "Update success");
        } else {
            redirectAttributes.addFlashAttribute(
                    "message", "Update failure");
        }

        return "redirect:/viewToDoList";
    }

    @GetMapping("/addToDoItem")
    public String addToDoItem(Model model) {
        model.addAttribute("todo", new ToDo());
        return "AddToDoItem";
    }

    @PostMapping("/saveToDoItem")
    public String saveToDoItem(
            @ModelAttribute("todo") ToDo todo,
            RedirectAttributes redirectAttributes) {

        if (service.saveOrUpdateToDoItem(todo)) {
            redirectAttributes.addFlashAttribute(
                    "message", "Save success");

            return "redirect:/viewToDoList";
        }

        redirectAttributes.addFlashAttribute(
                "message", "Save failure");

        return "redirect:/addToDoItem";
    }

    @GetMapping("/editToDoItem/{id}")
    public String editToDoItem(
            @PathVariable Long id,
            Model model) {

        ToDo todo = service.getToDoItemById(id);

        if (todo == null) {
            return "redirect:/viewToDoList";
        }

        model.addAttribute("todo", todo);
        return "EditToDoItem";
    }

    @PostMapping("/editSaveToDoItem")
    public String editSaveToDoItem(
            @ModelAttribute("todo") ToDo todo,
            RedirectAttributes redirectAttributes) {

        if (service.saveOrUpdateToDoItem(todo)) {
            redirectAttributes.addFlashAttribute(
                    "message", "Edit success");

            return "redirect:/viewToDoList";
        }

        redirectAttributes.addFlashAttribute(
                "message", "Edit failure");

        return "redirect:/editToDoItem/" + todo.getId();
    }

    @GetMapping("/deleteToDoItem/{id}")
    public String deleteToDoItem(
            @PathVariable Long id,
            RedirectAttributes redirectAttributes) {

        if (service.deleteToDoItem(id)) {
            redirectAttributes.addFlashAttribute(
                    "message", "Delete success");
        } else {
            redirectAttributes.addFlashAttribute(
                    "message", "Delete failure");
        }

        return "redirect:/viewToDoList";
    }
}