package com.bartheme.terraback.repository;

import com.bartheme.terraback.model.Terra;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;


public interface TerraRepository extends JpaRepository<Terra, Long> {
}
