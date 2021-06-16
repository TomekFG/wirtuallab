package com.example.accessingdatamysql;

import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

import java.util.List;

// This will be AUTO IMPLEMENTED by Spring into a Bean called userRepository
// CRUD refers Create, Read, Update, Delete

public interface ZapisyRepository extends CrudRepository<Zapisy, Integer> {

    List<Zapisy> findByCzuId(@Param("czuId") int czuId);

    Zapisy findByZapId(int id);

}