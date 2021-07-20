package com.cesco.api.cesnetapi.ec.controllers;

import com.cesco.api.cesnetapi.ec.models.ServerInfo;
import com.cesco.api.cesnetapi.ec.services.TestService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class TestController {

    @Autowired
    private TestService testService;

    @GetMapping("/dbinfo")
    @ResponseBody
    public ServerInfo getServerDateTime() {

        // 리턴할 데이터 정리만...
        ServerInfo serverInfo = new ServerInfo();
        serverInfo = testService.getServerTime();

        return serverInfo;
    }

    @GetMapping("/dbinfo/{parameter}")
    @ResponseBody
    public ServerInfo getServerDateTimeProc(@PathVariable(value = "parameter") String parameter) {

        // 리턴할 데이터 정리만...
        ServerInfo serverInfo = new ServerInfo();
        serverInfo = testService.getServerTime(parameter);

        return serverInfo;
    }
}
