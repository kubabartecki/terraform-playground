package com.bartheme.terraback.service;

import com.bartheme.terraback.model.Terra;
import com.bartheme.terraback.repository.TerraRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TerraService {
    private final TerraRepository repository;

    public TerraService(TerraRepository repository) {
        this.repository = repository;
    }

    public List<String> getTerraList() {
        return repository.findAll().stream()
                .map(Terra::getName)
                .toList();
    }

    public String addTerra(String name) {
        Terra terra = new Terra();
        terra.setName(name);
        return repository.save(terra).getName();
    }
}
