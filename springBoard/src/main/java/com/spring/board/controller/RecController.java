package com.spring.board.controller;

import java.io.IOException;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.board.dto.RecSessionDto;
import com.spring.board.dto.SessionUserDto;
import com.spring.board.service.impl.RecServiceImpl;
import com.spring.board.vo.CareerVo;
import com.spring.board.vo.CertificateVo;
import com.spring.board.vo.EducationVo;
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
	@ResponseBody
	public String loginAction( 
			@RequestBody RecruitVo recruitVo,
			HttpSession session, Model model) throws Exception {
	
		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();
		
		RecruitVo resultRecruitVo = recService.selectByNameAndPhone(recruitVo);
		int resultCnt = 0;
		
		 if(resultRecruitVo == null) {
	        resultCnt = recService.login(recruitVo);
	        resultRecruitVo = recService.selectByNameAndPhone(recruitVo);
	        result.put("status", "NEW");
	    } else if("Y".equals(resultRecruitVo.getSubmit())) {
	        result.put("status", "SUBMITTED");
	    } else {
	        result.put("status", "SAVED");
	    }
		 result.put("success", "Y");
		
		RecSessionDto sessionDto = new RecSessionDto(resultRecruitVo.getSeq(),resultRecruitVo.getName(), resultRecruitVo.getPhone());
		session.setAttribute("user", sessionDto);
		session.setMaxInactiveInterval(60*30);
		
		String callbackMsg = commonUtil.getJsonCallBackString(" ",result);
		
		System.out.println("callbackMsg::"+callbackMsg);
		
		return callbackMsg;
	}
	
	@RequestMapping(value = "/rec/main.do", method = RequestMethod.GET)
	public String main(
			Model model,
			HttpSession session
			) {
		
		
		RecSessionDto user = (RecSessionDto)session.getAttribute("user");

		if(user == null) {
			return "redirect:/rec/login.do";
		}
		
		RecruitVo recruitVo = recService.getRecruit(user.getSeq());
		System.out.println("recruitVo : " + recruitVo);
		List<EducationVo> educationVos = recService.getEducation(user.getSeq());
		System.out.println("educationVos : " + educationVos);
		List<CareerVo> careerVos = recService.getCarrer(user.getSeq());
		System.out.println("careerVos : " + careerVos);
		List<CertificateVo> certificateVos = recService.getCertificate(user.getSeq());
		System.out.println("certificateVos : " + certificateVos);
		
		model.addAttribute("recruit", recruitVo);
		model.addAttribute("educations", educationVos);
		model.addAttribute("careers", certificateVos);
		model.addAttribute("certificates", certificateVos);
		
		return "/rec/main";
	}

}
