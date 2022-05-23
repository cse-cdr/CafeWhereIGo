package com.ubo.CafeWhereIGo.user.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ubo.CafeWhereIGo.user.vo.UserVO;

@Repository("userDAO")
public class UserDAOImpl implements UserDAO{
	Logger logger = LoggerFactory.getLogger(UserDAOImpl.class);
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public UserVO login(UserVO loginInfo) {
		// TODO Auto-generated method stub
		UserVO userInfo=(UserVO)sqlSession.selectOne("mapper.user.login",loginInfo);
		if(userInfo == null) {
			System.out.println("(@UserDAO)userInfo is null.");
			
		}
		return userInfo;
	}
	@Override
	public void register(Map<String,String> userInfo) {
		UserVO userVO= convertMapToVO(userInfo);
		logger.debug("company_registration_number: " + userVO.getCompany_registration_number());
		sqlSession.insert("mapper.user.register",userVO);
	}
	@Override
	public String overlapped(String user_id) {
		// TODO Auto-generated method stub
		String isOverlapped = (String)sqlSession.selectOne("mapper.user.userOverlapCheck", user_id);
		return isOverlapped;
	}
	
	private UserVO convertMapToVO(Map<String, String> userInfo) {
		String user_id = userInfo.get("user_id");
		String user_pw = userInfo.get("user_pw");
		String user_name = userInfo.get("user_name");
		String phonenum1 = userInfo.get("user_phone_num1");
		String phonenum2 = userInfo.get("user_phone_num2");
		String phonenum3 = userInfo.get("user_phone_num3");
		String user_email = userInfo.get("user_email");
		String user_role = userInfo.get("user_role");
		String join_state = userInfo.get("join_state");
		String company_registration_number = userInfo.get("bussiness_number");
		boolean sns_account = Boolean.parseBoolean(userInfo.get("sns_account"));
		
		UserVO userVO = 
				new UserVO(
						user_id, 
						user_pw, 
						user_name, 
						phonenum1, 
						phonenum2, 
						phonenum3, 
						user_email, 
						user_role, 
						join_state, 
						company_registration_number, 
						sns_account
				);
		
		return userVO;
	}
	@Override
	public String getUserPassword(String user_id) {
		// TODO Auto-generated method stub
		String user_pw=(String) sqlSession.selectOne("mapper.user.getUserPassword",user_id);
		return user_pw;
	}
	@Override
	public List<UserVO> getUserList(String user_role) {
		// TODO Auto-generated method stub
		List<UserVO> userList = sqlSession.selectList("mapper.selectAllUser",user_role); 
		return userList;
	}
	@Override
	public List<UserVO> getUserList() {
		// TODO Auto-generated method stub
		List<UserVO> userList = sqlSession.selectList("mapper.selectAllUser"); 
		return userList;
	}
	
	
}
