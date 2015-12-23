package com.hybrid.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

import com.hybrid.command.LoginCommand;
import com.hybrid.exception.LoginFailException;
import com.hybrid.model.Member;
import com.hybrid.service.LoginService;

@Controller
@RequestMapping("/user")
public class LoginController {
	static Log log = LogFactory.getLog(LoginController.class);
	
	@Autowired
	LoginService loginService;
	
	@RequestMapping(value = "/login.html", method = RequestMethod.GET)
	public String getLoginView(){
		
		return "user/login";
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	@ResponseBody		//기본적으로 RequestMapping은 view type으로 취급,ResponseBody을 추가 하면 return type을 data로 취급 한다.
	public LoginCommand login (@RequestBody LoginCommand command, HttpSession session){		
		//@RequestBody. property(변수이름)가 동일한 이름이 넘어오면 여기에 data가 들어감.
		/*HttpSession - spring에서 session을 생성하기 위해서는 위와 같이 해야 한다. 
		 *HttpSession session = new HttpSession 이런식으로는 안됨. 기존에 session이 있으면 자동으로 받고 아니면 그냥 생성만 함.*/
		log.info("email = " + command.getEmail());
		log.info("password = " + command.getPassword());
		
		Member member = loginService.login(command.getEmail(), command.getPassword());
		//위의 email과 password가 정확 하지 않으면 error가 발생해서 아래의 setAttribute가 수행이 안됨.
		
		session.setAttribute("login", true);
		//email과 password가 정확하다면, error에 걸리지 않고 여기까지 수행됨. 이후 setAttribute("login")에서의 값이 true일 경우 로그인 상태 유지.
		session.setAttribute("member", member);
		
		return command;
	}
	
	@RequestMapping(value="logout", method = RequestMethod.GET)
	public String logout(HttpSession session){
		/*HttpSession - spring에서 session을 생성하기 위해서는 위와 같이 해야 한다. 
		 *HttpSession session = new HttpSession 이런식으로는 안됨. 기존에 session이 있으면 자동으로 받고 아니면 그냥 생성만 함.*/
		log.info("logout...");
		session.invalidate();				//session 종료
					
		return "redirect:/user/login.html";
	}
	
	
	@RequestMapping(value = "/logincheck", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> logincheck(HttpSession session){
		Map<String, Object> map = new HashMap<>();
		
		Boolean login = (Boolean) session.getAttribute("login");
		if (login != null && login == true){
			map.put("login", true);
			map.put("member", session.getAttribute("member"));
			
		} else {
			map.put("login", false);
		}
		
		return map;
	}
	
	
	@ExceptionHandler					//spring에서 exception이 발생했을때 작동됨.
	@ResponseBody						
	@ResponseStatus(HttpStatus.BAD_REQUEST)				
	//잘못된 email,password를 넣어도 Status가 200으로 나온다. 잘못된 경우 알수 있게, 400(BAD_REQUEST)으로 status를 나타내는  구문
	public Map<String, Object> loginfail(LoginFailException e){
		Map<String,Object> error = new HashMap<String,Object>();
		error.put("message", e.getMessage());
		return error;
	}
}
