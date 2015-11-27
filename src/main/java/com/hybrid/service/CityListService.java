package com.hybrid.service;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import com.hybrid.dao.CityDao;
import com.hybrid.model.City;
import com.hybrid.model.CityList;

public class CityListService {
	
	CityDao cityDao;
	public void setCityDao(CityDao dao){
		this.cityDao = dao;
		
	}
	
	@Transactional
	public CityList getList(){
		List<City> citys = cityDao.selectAll();
		CityList rtn = new CityList();
		rtn.setCitys(citys);
		return rtn;
	}

}
