package com.hybrid.controller;

import java.util.ArrayList;
import java.util.List;

import javax.xml.bind.annotation.XmlRootElement;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hybrid.model.CityList;
import com.hybrid.model.CityPage;
import com.hybrid.service.CityListService;
import com.hybrid.service.CityPageService;
import com.hybrid.util.Pagination;
import com.hybrid.model.City;

@Controller
@RequestMapping("/city")		//요청 맵핑. city라는 요청이 들어오면 이 controller가 처리한다.
public class CityController {

	static Log log = LogFactory.getLog(CityController.class);
	
	@Autowired		//필드 주입 방식, bean_mvc에 자동으로 controller를 bean등록 할수 있게 해줌.
	CityListService cityListService;
	
	@Autowired
	CityPageService cityPageService;
	
	
	
	@RequestMapping("/city.html")	//city 밑에 있는 dept.html을 수행한다. http://localhost:8085/Employee/city/city.html 하
	public String getView() {
		log.info("getView()...");
		
		return "city/city";		// 	http://localhost:8085/Employee/city/city.html 치면 최종적으로는 /WEB-INF/view/city/city.jsp 실행 된다. 
	}
	
	@RequestMapping({"","/"})		/*http://localhost:8085/Employee/city , http://localhost:8085/Employee/city/ 둘다 가능하게 함.
*/	@ResponseBody		//기본적으로 RequestMapping은 view type으로 취급,ResponseBody을 추가 하면 return type을 data로 취급 한다.
	public CityList getCityAll(){		//CityList.java에 @XmlRootElement 추가.
		
		CityList list = cityListService.getList();
		
		return list;
	}
	
	@RequestMapping("/page/{pageNo:[\\-\\+]{0,1}[0-9]+}")
	//[0-9]한자리, [0-9][0-9]두자리, [0-9][0-9][0-9]세자리.세자리만 들어올수 있다. [0-9]+ 한자리 이상의 수.\\- 마이너스 표기(\\이스케이프할떄 씀)	{0,1} 
	@ResponseBody
	public CityPage getCityPage(@PathVariable int pageNo){		//맵핑된 pageNo를 받는다.
		log.info("pageNo = " + pageNo);
		
		CityPage page = cityPageService.getPage(pageNo);
		
		return page;
	}
	
	
}
