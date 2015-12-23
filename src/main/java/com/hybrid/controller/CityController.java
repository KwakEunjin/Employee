package com.hybrid.controller;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hybrid.command.CityCommand;
import com.hybrid.model.City;
import com.hybrid.model.CityList;
import com.hybrid.model.CityPage;
import com.hybrid.service.CityDetailService;
import com.hybrid.service.CityListService;
import com.hybrid.service.CityModifyService;
import com.hybrid.service.CityPageService;
import com.hybrid.service.CityRegisterService;
import com.hybrid.service.CityUnRegisterService;

@Controller
@RequestMapping("/city")		//요청 맵핑. city라는 요청이 들어오면 이 controller가 처리한다.이름을 xxx해도 상관없다(임의적 이름)
public class CityController {

	static Log log = LogFactory.getLog(CityController.class);
	
	@Autowired		//필드 주입 방식, bean_mvc에 자동으로 controller를 bean등록 할수 있게 해줌.수동으로 bean 등록을 할때는 빼준다.
	CityListService cityListService;
	
	@Autowired
	CityPageService cityPageService;
	
	@Autowired
	CityRegisterService cityRegisterService ;
	
	@Autowired
	CityDetailService cityDetailService ;
	
	@Autowired
	CityModifyService cityModifyService ;
	
	@Autowired
	CityUnRegisterService cityUnRegisterService ;
	
	
	/* 
	 * main.html
	 */
	@RequestMapping(value="/main.html", method = RequestMethod.GET)		/*GET방식으로만 응답 함.*/
	//city 밑에 있는 dept.html을 수행한다. http://localhost:8080/Employee/city/main.html
	public String getMainView() {
		log.info("getMainView()...");
		
		return "city/main";		// 	beans_mvc의 mvc:view-resolvers prefix="/WEB-INF/view/" 밑의 주소가 정확하게 와야 한다.
		// 이후 resolver 로직처럼 main이 main.jsp로 인식이 됨.http://localhost:8080/Employee/city/main.html 치면 최종적으로는 /WEB-INF/view/city/main.jsp 실행 된다. 
	}
	
	/*
	 * list.html
	 */
	
	@RequestMapping(value="/list.html", method = RequestMethod.GET)	
	public String getListView() {
		log.info("getListView()...");
		return "city/list";		
	}
	
	/*
	 * detail.html
	 */
	@RequestMapping(value="/detail.html", method = RequestMethod.GET)	
	public String getDetailView() {
		log.info("getDetailView()...");
		return "city/detail";		 
	}
	
	/*
	 * append.html
	 */
	@RequestMapping(value="/append.html", method = RequestMethod.GET)	
	public String getAppendView() {
		log.info("getAppendView()...");
		return "city/append";		 
	}
	
	/*
	 * modify.html
	 */
	@RequestMapping(value="/modify.html", method = RequestMethod.GET)	
	public String getModifyView() {
		log.info("getModifyView()...");
		return "city/modify";		 
	}
	
	/*
	 * delete.html
	 */
	@RequestMapping(value="/delete.html", method = RequestMethod.GET)	
	public String getDeleteView() {
		log.info("getDeleteView()...");
		return "city/delete";		 
	}
	
	
	/*
	 * URL_GET_LIST = [/city] or [/city/]
	 * Accept = application/json
	 */
	
	@RequestMapping(value={"","/"}, method = RequestMethod.GET)		/*http://localhost:8080/Employee/city , http://localhost:8080/Employee/city/ 둘다 가능하게 함.*/	
	@ResponseBody		//기본적으로 RequestMapping은 view type으로 취급,ResponseBody을 추가 하면 return type을 data로 취급 한다.
	public CityList getCityAll(){		//CityList.java에 @XmlRootElement 추가.
		log.info("getCityAll()...");
		
		CityList list = cityListService.getList();
		
		return list;
	}
	
	/*
	 * URL_GET_ITEM_BASE = [/city/{id}]
	 * Accept = application/json
	 */
	@RequestMapping(value="/{id:[0-9]+}", method = RequestMethod.GET)								//맵핑
	@ResponseBody												//json으로 전송
	public City getCityItem(@PathVariable int id){				//위에 맵핑된 id를 받는다.
		log.info("getCityItem()... id = " + id);
		
		City city = cityDetailService.detail(id);
		
		return city;
	}
	
	/*
	 * URL_GET_PAGE_BASE = [/city/page/{pageNo}]
	 * Accept = application/json
	 */
	
//	@RequestMapping("/page/{pageNo:[\\-\\+]{0,1}[0-9]+}")
	//[0-9]한자리, [0-9][0-9]두자리, [0-9][0-9][0-9]세자리.세자리만 들어올수 있다. [0-9]+ 한자리 이상의 수.\\- 마이너스 표기(\\이스케이프할떄 씀)	{0,1} 
	@RequestMapping(value="/page/{pageNo:[0-9]+}", method = RequestMethod.GET)					//맵핑
	@ResponseBody												//json으로 전송
	public CityPage getCityPage(@PathVariable int pageNo){		//위에 맵핑된 pageNo를 받는다.
		log.info("getCityPage()... pageNo = " + pageNo);
		
		CityPage page = cityPageService.getPage(pageNo);
		
		return page;
	}
	
	/*
	 * URL_POST_ITEM_APPEND = [/city/{id}]
	 * Accept = application/json 
	 */
	@RequestMapping(value={"","/"}, method = RequestMethod.POST)				//POST(insert) 방식
	@ResponseBody																//json으로 전송
	public CityCommand postCityAppend(@RequestBody CityCommand command) {			//@RequestBody. property(변수이름)가 view에서 동일한 이름이 넘어오면 여기에 data가 들어감.
		log.info("postCityAppend()... city id = " + command.getId());
		
		command.validate();
		if(!command.isValid()){						//false 이면
			//throw
		}
		
		int id = cityRegisterService.regist(command.getCity());			//CityCommand를 City로 변환.
		command.setId(id);
		return command;
	}
	
	/*
	 * URL_PUT_ITEM_MODIFY = [/city/{id}]
	 * Accept = application/json 
	 */
	@RequestMapping(value="/{id:[0-9]+}", method = RequestMethod.PUT)			//PUT(modify) 방식
	@ResponseBody																//json으로 전송
	public CityCommand putCityModify(@PathVariable int id, @RequestBody CityCommand command) {		//@RequestBody.property(변수이름)가 view에서 동일한 이름이 넘어오면 여기에 data가 들어감.
		log.info("putCityModify()... id = " + id);
		log.info("putCityModify()... city id = " + command.getId());
		
		cityModifyService.modify(command.getCity());
		
		return command;
	}
	
	
	/*
	 * URL_DELETE_ITEM_DELETE = [/city/{id}]
	 * Accept = application/json 
	 */
	@RequestMapping(value="/{id:[0-9]+}", method = RequestMethod.DELETE)					//DELETE(DELETE) 방식
	@ResponseBody																//json으로 전송
	public void deleteCity(@PathVariable int id) {		/*delete는 리턴 되는 값이 없다.*/	
		log.info("putCityModify()... id = " + id);
		
		cityUnRegisterService.unregist(id);

	}
	
	
}
