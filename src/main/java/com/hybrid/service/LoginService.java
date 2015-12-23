package com.hybrid.service;

import com.hybrid.dao.MemberDao;
import com.hybrid.exception.LoginFailException;
import com.hybrid.model.Member;

public class LoginService {

	MemberDao memberDao;
	
	public void setMemberDao(MemberDao dao){
		this.memberDao = dao;
	}
	
	public Member login(String email, String password) {
		Member member =  memberDao.selectByEmailAndPassword(email, password);
		if(member == null) {
			throw new LoginFailException("존재하지 않는 user 이거나 password가 틀렸습니다.");
			// 존재하지 않는~~~  가 message로 들어가서 return 된다.
		}
		return member;
	}
}
