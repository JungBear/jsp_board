package com.spring.board.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.board.dto.LoginDto;
import com.spring.board.dto.SessionUserDto;
import com.spring.board.service.impl.UserServiceImpl;
import com.spring.board.service.impl.boardServiceImpl;
import com.spring.board.vo.OptionVo;
import com.spring.board.vo.UserVo;
import com.spring.common.CommonUtil;

@Controller
public class UserController {
	
	@Autowired
	UserServiceImpl userService;
	
	@Autowired
	boardServiceImpl boardService;
	
	
	@RequestMapping(value = "/user/login.do", method = RequestMethod.GET)
	public String login(Locale locale, Model model) {
		return "/user/login";
	}
	
	@RequestMapping(value = "/user/loginAction.do", method = RequestMethod.POST)
	@ResponseBody
	public String loginAction(Locale locale, Model model, 
			@RequestBody LoginDto dto, HttpSession session) throws Exception{
		System.out.println(dto);
		
		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();
		String callbackMsg;
		
		LoginDto loginUser = userService.login(dto);
		
		// 아이디로 찾지 못했을 때
		if(loginUser == null) {
			result.put("success", "N");
			result.put("type", "id");
			callbackMsg = commonUtil.getJsonCallBackString(" ",result);
			return callbackMsg;
		}
		
		if(!loginUser.getUserPw().equals(dto.getUserPw())) {
			result.put("success", "N");
			result.put("type", "pw");
			callbackMsg = commonUtil.getJsonCallBackString(" ",result);
			return callbackMsg;
		}
		result.put("success", "Y");
		callbackMsg = commonUtil.getJsonCallBackString(" ",result);
		
		SessionUserDto sessionUserDto = new SessionUserDto(loginUser.getUserId(), loginUser.getUserName());
		session.setAttribute("user", sessionUserDto);
		session.setMaxInactiveInterval(60*30);
		
		return callbackMsg;
	}
	
	@RequestMapping(value = "/user/join.do", method = RequestMethod.GET)
	public String join(Locale locale, Model model) throws Exception {
		
		List<OptionVo> optionVo = boardService.optionList("phone");
		model.addAttribute("options", optionVo);
		
		return "/user/join";
	}
	
	@RequestMapping(value = "/user/joinAction.do", method = RequestMethod.POST)
	@ResponseBody
	public String joinAction(Locale locale, Model model, 
			@RequestBody UserVo userVo) throws Exception{
		
		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();
		
		int resultCnt = userService.join(userVo);
		System.out.println(resultCnt);
		result.put("success", (resultCnt == 1) ? "Y" : "N");
		System.out.println(result.get("success"));
		String callbackMsg = commonUtil.getJsonCallBackString(" ",result);

		return callbackMsg;
	}
	
	@RequestMapping(value = "/user/duplication.do", method = RequestMethod.POST)
	@ResponseBody
	public String duplication (Locale locale, Model model,
			@RequestBody UserVo userVo) throws Exception {
		String userId = userVo.getUserId();
		
		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();
		
		int resultCnt = userService.isDuplication(userId);
		
		result.put("isDuplicate", (resultCnt > 0)? "true" : "false");
		String callbackMsg = commonUtil.getJsonCallBackString(" ",result);
		
		return callbackMsg;
	}
	
	@RequestMapping(value = "user/logout.do", method = RequestMethod.POST)
	@ResponseBody
	public String logout(Locale locale, HttpSession session) throws Exception {
		
		session.removeAttribute("user");
		session.setMaxInactiveInterval(0);
		
		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();
		
		result.put("success", "Y");
		String callbackMsg = commonUtil.getJsonCallBackString(" ",result);
		
		return callbackMsg;
	}
}
