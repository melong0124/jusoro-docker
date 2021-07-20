package com.cesco.api.cesnetapi.ec.mappers;

import java.sql.SQLException;

import com.cesco.api.cesnetapi.ec.models.ServerInfo;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface TestMapper {
    
    /**
     * 서버시간 가져오기
     * @return 서버시간
     * @throws SQLException SQL Exception
     */
    ServerInfo getServerDateTime() throws SQLException;

    /**
     * 서버시간 가져오기
     * @return 서버시간
     * @throws SQLException SQL Exception
     */
    ServerInfo getServerDateTime2(String names) throws SQLException;
}
