package com.spring.board.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.board.HomeController;
import com.spring.board.service.impl.MbtiServiceImpl;
import com.spring.board.vo.QuestionVo;
import com.spring.board.vo.ResultVo;

@Controller
public class MbtiController {
	
	@Autowired
	MbtiServiceImpl mbtiService;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@RequestMapping(value = "/mbti/mbtiList.do", method = RequestMethod.GET)
	public String mbtiList(Locale locale, Model model, 
			@RequestParam(defaultValue = "1") int page,
			HttpSession session) {
		
		if(page == 1) {
			session.removeAttribute("mbtiAnswers");
		}
		
		List<QuestionVo> question = mbtiService.questionList(page);
		
		model.addAttribute("question", question);
		model.addAttribute("currentPage", page);
		model.addAttribute("totalPages", 4);
		
		return "/mbti/mbtiList";
	}
	
	@RequestMapping(value="/mbti/mbtiAction.do", method = RequestMethod.POST)
	public String mbtiAction(Locale locale, Model model, 
			@RequestParam int page, 
			@RequestParam Map<String, String> answers,
			HttpServletRequest request) throws Exception{
		
		List<Integer> listAnswers = new ArrayList<>();
		
		answers.remove("page");
	    for (String key : answers.keySet()) {
	    	listAnswers.add(Integer.parseInt(answers.get(key)));
	    }
		
		HttpSession session = request.getSession();
		List<Integer> allAnswers = (List<Integer>)session.getAttribute("mbtiAnswers");
		
		if(allAnswers == null) {
			allAnswers = new ArrayList<>();
		}
		
		allAnswers.addAll(listAnswers);
		
		session.setAttribute("mbtiAnswers", allAnswers);
		if(page >= 4) {
			
			ResultVo result = mbtiService.calculateMbtiResult(allAnswers);
			session.setAttribute("mbtiResult", result);
			return "redirect:/mbti/mbtiResult.do";
		}
		return "redirect:/mbti/mbtiList.do?page=" + (page + 1);
	}
	
	@RequestMapping(value = "/mbti/mbtiResult.do", method = RequestMethod.GET)
	public String mbtiResult(Locale locale, Model model, HttpSession session) {
		
		ResultVo resultVo = (ResultVo)session.getAttribute("mbtiResult");
		if(resultVo == null) {
			return "redirect:/mbti/mbtiList.do?page=1";
		}
		
		model.addAttribute("result", resultVo);
		session.removeAttribute("mbtiResult");
		session.removeAttribute("mbtiAnswers");
		
		return "/mbti/mbtiResult";
	}
	
}
