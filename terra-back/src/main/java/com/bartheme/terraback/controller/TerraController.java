package com.bartheme.terraback.controller;


import com.bartheme.terraback.service.TerraService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("api/v1/terra")
public class TerraController {
    private final TerraService service;

    public TerraController(TerraService service) {
        this.service = service;
    }

    @GetMapping("hello")
    public String getTerra() {
        return "Hello Terra";
    }

    @GetMapping("all")
    public List<String> getTerraList() {
        return service.getTerraList();
    }

    @PostMapping("add/{name}")
    public String addTerra(@PathVariable String name) {
        return service.addTerra(name);
    }
}
