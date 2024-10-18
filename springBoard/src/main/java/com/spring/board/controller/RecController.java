package com.spring.board.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.board.dto.SessionUserDto;
import com.spring.board.service.impl.RecServiceImpl;
import com.spring.board.vo.RecruitVo;
import com.spring.common.CommonUtil;

@Controller
public class RecController {
	
	@Autowired
	RecServiceImpl recService;
	
	@RequestMapping(value = "/rec/login.do", method = RequestMethod.GET)
	public String login() {
		
		return "/rec/login";
	}
	
	@RequestMapping(value ="/rec/loginAction.do", method = RequestMethod.POST)
	public String loginAction( 
			@RequestBody RecruitVo recruitVo,
			HttpSession session, Model model) throws Exception {
		

		System.out.println(recruitVo);
		
		// �̸��� ��ȭ��ȣ�� ������ ��ȸ
		RecruitVo resultRecruitVo = recService.selectByNameAndPhone(recruitVo);
		
		// �̸��� �޴�����ȣ�� �˻����� �� ������ ����
		if(resultRecruitVo == null) {
			int resultCnt = recService.login(recruitVo);
			resultRecruitVo = recService.selectByNameAndPhone(recruitVo);
			System.out.println("����");
		};
		System.out.println(resultRecruitVo);
		
		model.addAttribute(resultRecruitVo);
		
		session.setAttribute("user", recruitVo);
		session.setMaxInactiveInterval(60*30);
		
		return "/rec/main";
	}

}
