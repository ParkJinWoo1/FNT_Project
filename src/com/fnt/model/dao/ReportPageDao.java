package com.fnt.model.dao;

import java.util.List;

import com.fnt.model.dto.ReportDto;

public interface ReportPageDao {
	public List<ReportDto> selectList();
	public ReportDto selectOne(int reportno);
}
