package com.cesco.api.cesnetapi.ec.services;

import com.cesco.api.cesnetapi.ec.mappers.TestMapper;
import com.cesco.api.cesnetapi.ec.models.ServerInfo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class TestService {
    
    @Autowired
    private TestMapper mapper;

    public ServerInfo getServerTime() {

        try {
            // todo... 비즈니스 로직 들...
            return mapper.getServerDateTime();
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            return null;
        }
    }

    public ServerInfo getServerTime(String parameter) {

        try {
            // todo... 비즈니스 로직 들...
            return mapper.getServerDateTime2(parameter);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            return null;
        }
    }
}
