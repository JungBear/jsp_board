package com.spring.board.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.board.dto.RecDto;
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
	    } else if("T".equals(resultRecruitVo.getSubmit())) {
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
			) throws JsonGenerationException, JsonMappingException, IOException {
		
		
		RecSessionDto user = (RecSessionDto)session.getAttribute("user");

		if(user == null) {
			return "redirect:/rec/login.do";
		}
		
		
		
		RecruitVo recruitVo = recService.getRecruit(user.getSeq());
		List<EducationVo> educationVos = recService.getEducation(user.getSeq());
		List<CareerVo> careerVos = recService.getCarrer(user.getSeq());
		List<CertificateVo> certificateVos = recService.getCertificate(user.getSeq());
		String status = null;
		
		if(!recruitVo.getSubmit().equals("F")) {	
			String lastEducation = "학력 없음";
			int grade = 0;
			for (EducationVo educationVo : educationVos) {
				if(educationVo.getSchoolName().contains("고등학교")) {
	
					if(lastEducation.equals("대학교")) {
						break;
					}
					lastEducation = "고등학교";
					if(educationVo.getDivision().equals("student")) {
						status = "재학 중";
					}else if(educationVo.getDivision().equals("graduate")) {
						status = "졸업";
					}else {
						status = "중퇴";
					}
					
				}else if(educationVo.getSchoolName().contains("대학교")) {
					lastEducation = "대학교";
					String[] start = educationVo.getStartPeriod().split("\\.");
					String[] end = educationVo.getEndPeriod().split("\\.");
					grade = Integer.parseInt(end[0]) - Integer.parseInt(start[0]);
					if(educationVo.getDivision().equals("student")) {
						status = "재학 중";
					}else if(educationVo.getDivision().equals("graduate")) {
						status = "졸업";
					}else {
						status = "중퇴";
					}
				}
			}
			String educationSummary = null;
			if(lastEducation.equals("고등학교")) {
				educationSummary = String.format("%s %s", lastEducation, status);
			}else if(lastEducation.equals("대학교")) {
				if(recruitVo.getGender().equals("M")) {
					if(grade > 6) {
						grade = 4;
					}else {
						grade = 2;
					}
				}else {
					if(grade > 4) {
						grade = 4;
					}else {
						grade = 2;
					}
				}
				educationSummary = String.format("%s(%d년제) %s", lastEducation, grade, status);										

			}
			model.addAttribute("educationSummary", educationSummary);
			int totalYears = 0;
			int totalMonths = 0;
			
			for (CareerVo career : careerVos) {
				String[] start = career.getStartPeriod().split("\\.");
				String[] end = career.getEndPeriod().split("\\.");
				int startYear = Integer.parseInt(start[0]);
				int startMonth = Integer.parseInt(start[1]);
				int endYear = Integer.parseInt(end[0]);
				int endMonth = Integer.parseInt(end[1]);
				
				totalYears += endYear - startYear;
				totalMonths += endMonth - startMonth;
				
				if (totalMonths >= 12) {
					totalYears += totalMonths / 12;
					totalMonths %= 12;
				} else if(totalMonths <= 0) {
					totalYears -= 1;
					totalMonths = 12 + totalMonths;
				}
				
				
			}
			
			String careerSummary = String.format("%d년 %d개월", totalYears, totalMonths);
			model.addAttribute("careerSummary", careerSummary);
			
		}
		
		model.addAttribute("recruit", recruitVo);
		model.addAttribute("educations", educationVos);
		model.addAttribute("careers", careerVos);
		model.addAttribute("certificates", certificateVos);
	
		return "/rec/main";
	}
	
	@RequestMapping(value = "/rec/{action}.do", method = RequestMethod.POST)
	@ResponseBody
	public String saveOrSubmit(@PathVariable("action") String action, @RequestBody RecDto recDto) throws Exception {
	    HashMap<String, String> result = new HashMap<>();
	    CommonUtil commonUtil = new CommonUtil();

	    System.out.println(recDto);

	    try {
	        recService.save(recDto, action);
	        result.put("success", "Y");
	        result.put("message", action.equals("save") ? "저장이 완료되었습니다." : "제출이 완료되었습니다.");
	    } catch (IllegalArgumentException e) {
	        result.put("success", "N");
	        result.put("message", e.getMessage());
	    } catch (RuntimeException e) {
	        result.put("success", "N");
	        result.put("message", e.getMessage());
	    }

	    String callbackMsg = commonUtil.getJsonCallBackString(" ", result);
	    System.out.println("callbackMsg::" + callbackMsg);

	    return callbackMsg;
	}
	
	@RequestMapping(value = "/rec/getEducationList.do", method = RequestMethod.GET)
	@ResponseBody
	public String getEducationList(HttpSession session) throws Exception {
		HashMap<String, Object> result = new HashMap<>();
	    CommonUtil commonUtil = new CommonUtil();
	    result.put("data", recService.getEducation(((RecSessionDto)session.getAttribute("user")).getSeq()));
	    
	    String callbackMsg = commonUtil.getJsonCallBackString(" ", result);
	    System.out.println("callbackMsg::" + callbackMsg);

	    return callbackMsg;
	}

}
