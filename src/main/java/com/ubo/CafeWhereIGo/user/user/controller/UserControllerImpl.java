package com.ubo.CafeWhereIGo.user.user.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.ubo.CafeWhereIGo.common.base.BaseController;
import com.ubo.CafeWhereIGo.user.user.service.UserService;
import com.ubo.CafeWhereIGo.user.user.vo.UserVO;

@Controller("userController")
public class UserControllerImpl extends BaseController implements UserController {
	Logger logger = LoggerFactory.getLogger(UserControllerImpl.class);
	final String CURR_IMAGE_REPO_PATH = "/Users/choedaelyeon/server_data/cafe/file_repo/photo/userProfilePhoto/";
	
	@Autowired
	private UserService userService;
	
	/* For Password Encryption */
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	@Override
	@RequestMapping(value= "/user/loginform.do" ,method={RequestMethod.POST,RequestMethod.GET})
	public ModelAndView loginform(HttpServletRequest request, HttpServletResponse response) throws Exception{

		
		ModelAndView mav=new ModelAndView();
		String viewName = "/user/loginform";
		mav.setViewName(viewName);
		
		return mav;
	}
	@Override
	@RequestMapping(value= "/user/login.do" ,method={RequestMethod.POST,RequestMethod.GET})
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response) throws Exception{

		String user_id = request.getParameter("user_id");
		String raw_pw = request.getParameter("user_pw");
		System.out.println("user_id: "+user_id);
		System.out.println("user_pw: "+raw_pw);
		
		String isLoginSuccess;
		
		String encoded_pw=bcryptPasswordEncoder.encode(raw_pw);
		String encodedPassword = userService.getUserPassword(user_id);
		if(encodedPassword != null) {
			boolean isMatch = false;
			
			isMatch = bcryptPasswordEncoder.matches(raw_pw, encodedPassword);
			System.out.println("isMatch: "+isMatch);
			if(isMatch) {
				UserVO userVO = new UserVO(user_id, encodedPassword);
				UserVO userInfo = userService.login(userVO);
				HttpSession session = request.getSession();
				session.setAttribute("loginSession", userInfo);
				session.setMaxInactiveInterval(3600);
				isLoginSuccess ="success";
			}else {
				isLoginSuccess = "not match";
			}
		}else {
			isLoginSuccess = "not exist";
		}
		System.out.println("isLogin: "+isLoginSuccess);
		List<String> msgList = new ArrayList<String>();
		ModelAndView mav=new ModelAndView();
		String viewName = "/user/loginform";
		if(isLoginSuccess.equals("success")) {
			viewName = "/main/main";
			
		}else if(isLoginSuccess.equals("not match")) {
			msgList.add("ID ?????? ??????????????? ???????????? ????????????");
			viewName = "/user/loginform";
		}else{
			msgList.add("???????????? ?????? ???????????????");
			viewName = "/user/loginform";
		}
		mav.setViewName(viewName);
		mav.addObject("isLoginSuccess", isLoginSuccess);
		mav.addObject("msgList",msgList);
		return mav;
	}
	
	@Override
	@RequestMapping(value= "/user/logout.do" ,method={RequestMethod.POST,RequestMethod.GET})
	public ModelAndView logout(HttpServletRequest request, HttpServletResponse response) throws Exception{

		HttpSession session = request.getSession();
		session.invalidate();
		
		ModelAndView mav=new ModelAndView();
		String viewName = "/main/main";
		mav.setViewName(viewName);

		return mav;
	}
	
	@Override
	@RequestMapping(value= "/user/registerform.do" ,method={RequestMethod.POST,RequestMethod.GET})
	public ModelAndView registerform(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mav=new ModelAndView();
		String viewName = "/user/registerform";
		mav.setViewName(viewName);
		
		return mav;
	}
	
	@Override
	@RequestMapping(value="/user/overlapped.do" ,method = RequestMethod.POST)
	public ResponseEntity overlapped(@RequestParam("user_id") String id,HttpServletRequest request, HttpServletResponse response) throws Exception{
		ResponseEntity resEntity = null;
		String result = userService.overlapped(id);
		resEntity =new ResponseEntity(result, HttpStatus.OK);
		return resEntity;
	}
	
	
	@RequestMapping(value="/user/registerUser.do" ,method = RequestMethod.POST)
	public ModelAndView registerUser(MultipartHttpServletRequest multipartRequest, HttpServletResponse response) throws Exception {
		multipartRequest.setCharacterEncoding("utf-8");
		Map map = new HashMap();
		Enumeration enu=multipartRequest.getParameterNames();
		
		while(enu.hasMoreElements()) {
			String name = (String)enu.nextElement();
			String value=multipartRequest.getParameter(name);
			if(name.equals("user_pw")) {
				String encryptedPassword = bcryptPasswordEncoder.encode(value);
				System.out.println("[@Sign in] password: "+ encryptedPassword);
				map.put(name, encryptedPassword);
				System.out.println("[@Sign in Hashmap] password: "+ map.get("user_pw"));
			}else {	
				map.put(name, value);
			}
		}
		
		String user_id = (String)map.get("user_id");
		
		Map<String, MultipartFile> fileMap=multipartRequest.getFileMap();
		List fileNameList = new ArrayList<MultipartFile>(fileMap.values());
		Iterator it = fileNameList.iterator();
		if(it.hasNext()){
			MultipartFile multipartFile = (MultipartFile) it.next();
			String multipartFilename =multipartFile.getOriginalFilename();
			logger.debug("[@UserController, registerUser] fileNames: "+ multipartFilename);
			if(multipartFilename!=null && !multipartFilename.equals("")) {
				final String CURR_IMAGE_DIR = CURR_IMAGE_REPO_PATH+"/"+user_id;
				
				List<String> fileList = fileProcess(multipartRequest, user_id);
				String filename = fileList.get(0);
				String filepath = CURR_IMAGE_DIR + "/" + filename;
				
				map.put("filename", filename);
			}
		}
		
		//logger.debug("[@UserService] company_registration_number: " + map.get("bussiness_number"));
		

		

//		if(false){
//			final String CURR_IMAGE_DIR = CURR_IMAGE_REPO_PATH+"/"+user_id;
//			
//			List<String> fileList = fileProcess(multipartRequest, user_id);
//			String filename = fileList.get(0);
//			String filepath = CURR_IMAGE_DIR + "/" + filename;
//			
//			map.put("filename", filename);
//		}
		map.put("join_state", "joined");
		userService.register(map);
		
		ModelAndView mav = new ModelAndView();
		List<String> msgList = new ArrayList<String>();
		String msg="??????????????? ?????????????????????.";
		msgList.add(msg);
		mav.addObject("msgList",msgList);
		mav.addObject("map", map);
		mav.setViewName("/main/main");
		return mav;
	}
	@Override
	@RequestMapping(value= "/user/modifyUser.do" ,method={RequestMethod.POST,RequestMethod.GET})
	public ModelAndView modifyUser (MultipartHttpServletRequest multipartRequest,
			HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		
		multipartRequest.setCharacterEncoding("utf-8");
		Map map = new HashMap();
		Enumeration enu=multipartRequest.getParameterNames();
		
		while(enu.hasMoreElements()) {
			String name = (String)enu.nextElement();
			String value=multipartRequest.getParameter(name);
			if(name.equals("user_pw")) {
				System.out.println("[@UserControllerImpl, modifyUser] password in Hashmap, password: "+ value);
				if(!value.equals("")) {
					String encryptedPassword = bcryptPasswordEncoder.encode(value);
					System.out.println("[@Sign in] password: "+ encryptedPassword);
					map.put(name, encryptedPassword);
				}
				
			}else {	
				map.put(name, value);
			}
		}
		
		
		
		HttpSession loginSession= multipartRequest.getSession();
		
		UserVO userInfo= (UserVO) loginSession.getAttribute("loginSession");
		UserVO userInfoResult = userService.login(userInfo);
		String user_id = userInfo.getUser_id();
		map.put("user_id", user_id);
		String user_role =userInfoResult.getUser_role();
		map.put("user_role", user_role);
		if(user_role.equals("cafe_manager")) { 
			map.put("company_registration_number", userInfoResult.getCompany_registration_number());
		}
		
		Iterator filenameIt = multipartRequest.getFileNames();
		String inputTagName = (String) filenameIt.next();
		MultipartFile mFile = multipartRequest.getFile(inputTagName);
		if(mFile.getSize()>0)
		{
			deleteProfilePhoto(user_id);
			
			Map<String, MultipartFile> fileMap=multipartRequest.getFileMap();
			List fileNameList = new ArrayList<MultipartFile>(fileMap.values());
			Iterator it = fileNameList.iterator();
			if(it.hasNext()){
				MultipartFile multipartFile = (MultipartFile) it.next();
				String multipartFilename =multipartFile.getOriginalFilename();
				logger.debug("[@UserController, registerUser] fileNames: "+ multipartFilename);
				if(multipartFilename!=null && !multipartFilename.equals("")) {
					final String CURR_IMAGE_DIR = CURR_IMAGE_REPO_PATH+"/"+user_id;
					
					List<String> fileList = fileProcess(multipartRequest, user_id);
					String filename = fileList.get(0);
					String filepath = CURR_IMAGE_DIR + "/" + filename;
					
					map.put("filename", filename);
				}
			}
		}
		userService.update(map);
		
		ModelAndView mav = new ModelAndView();
		List<String> msgList = new ArrayList<String>();
		String msg="????????????????????? ?????????????????????.";
		msgList.add(msg);
		mav.addObject("msgList",msgList);
		mav.addObject("map", map);
		mav.setViewName("/main/main");
		return mav;
		
	}
	private List<String> fileProcess(MultipartHttpServletRequest multipartRequest, String user_id) throws Exception{ 
		List<String> fileList = new ArrayList<String>();
		Iterator<String> fileNames = multipartRequest.getFileNames();
		final String CURR_IMAGE_DIR = CURR_IMAGE_REPO_PATH+"/"+user_id;
		while(fileNames.hasNext()) {
			String fileName = fileNames.next();
			MultipartFile mFile = multipartRequest.getFile(fileName);
			String originalFileName = mFile.getOriginalFilename();
			fileList.add(originalFileName);
			File file = new File(CURR_IMAGE_DIR+"/"+fileName);
			if(mFile.getSize()>0) {
				if(!file.exists()) {
					if(file.getParentFile().mkdirs()) {
						file.createNewFile();
					}
				}
				mFile.transferTo((new File(CURR_IMAGE_DIR+"/"+originalFileName)));
			}
		}
		
		//?????? ???????????? ????????????
		File dir = new File(CURR_IMAGE_DIR);
		File filelist[] = dir.listFiles();
		
		for(File file:filelist) {
			if(isDummyFile(file.getName())) {
				file.delete();
			}
		}
		
		filelist = null;
		filelist = dir.listFiles();
		
		return fileList;
	}
	
	private boolean isDummyFile(String name) {
		boolean filenameValidation = false;
		StringTokenizer tokenizer = new StringTokenizer(name,".");
		
		if(tokenizer.countTokens()<=1) {
			filenameValidation=true;
		}
		return filenameValidation;
	}
	
	@RequestMapping("/user/download.do")
	public void download(@RequestParam("user_id") String user_id,
			                 HttpServletResponse response) throws Exception {
		OutputStream out = response.getOutputStream();
		String filePath=CURR_IMAGE_REPO_PATH+"/"+user_id;
		File imageDir=new File(filePath);
		
		
		String imageFileName = userService.getUserProfilePhoto(user_id);
		File imageFile = new File(filePath+"/"+imageFileName);
		logger.debug("imageFileName: "+imageFileName);
		if(imageFile!=null && imageFile.exists()) {
			response.setHeader("Cache-Control","no-cache");
			response.addHeader("Content-disposition", "attachment; fileName="+imageFileName);
			FileInputStream in=new FileInputStream(imageFile); 
			byte[] buffer=new byte[1024*8];
			while(true){
				int count=in.read(buffer); //?????????????? ????????????????? ????????????????????
				if(count==-1)  //?????????????????? ???????????????????????? ?????????????????????????? ????
					break;
				out.write(buffer,0,count);
			}
			in.close();
		}
		out.close();
	}
	public void deleteProfilePhoto(String user_id) {
		String filePath=CURR_IMAGE_REPO_PATH+"/"+user_id;
		String profilePhotoFilename = userService.getUserProfilePhoto(user_id);
		
		File file = new File(filePath+"/"+profilePhotoFilename);
		if(file != null) {
			file.delete();
		}
	}
}
