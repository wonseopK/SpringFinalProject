package data.notice;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.Enumeration;
import java.util.EventListener;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.Filter;
import javax.servlet.FilterRegistration;
import javax.servlet.RequestDispatcher;
import javax.servlet.Servlet;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRegistration;
import javax.servlet.ServletRegistration.Dynamic;
import javax.servlet.SessionCookieConfig;
import javax.servlet.SessionTrackingMode;
import javax.servlet.descriptor.JspConfigDescriptor;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.MimeTypeUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.ServletConfigAware;
import org.springframework.web.context.ServletContextAware;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


import data.member.MemberService;

@Controller
public class NoticeController implements ServletContextAware {
	
//	@Autowired
//	NoticeService service;
	@Autowired
	MemberService memberService;
	@Autowired
	NoticeMapper mapper;
	
	@GetMapping("/notice")
	public ModelAndView noticeList(
			@RequestParam(defaultValue = "1") int currentPage,
			HttpSession session
			) {
		
		ModelAndView mview = new ModelAndView();
		String id = (String) session.getAttribute("id");
		String loginok = (String) session.getAttribute("loginok");
		
		int totalCount = mapper.getTotalCount();
		
		int perPage = 10; // 한페이지에 보여질 글의 갯수
		int totalPage; // 총 페이지수
		int start; // 각페이지에서 불러올 db 의 시작번호
		int perBlock = 5; // 몇개의 페이지번호씩 표현할것인가
		int startPage; // 각 블럭에 표시할 시작페이지
		int endPage; // 각 블럭에 표시할 마지막페이지

		// 총 페이지 갯수 구하기
		totalPage = totalCount / perPage + (totalCount % perPage == 0 ? 0 : 1);
		// 각 블럭의 시작페이지
		startPage = (currentPage - 1) / perBlock * perBlock + 1;
		endPage = startPage + perBlock - 1;
		if (endPage > totalPage)
			endPage = totalPage;
		// 각 페이지에서 불러올 시작번호
		start = (currentPage - 1) * perPage;
		
		List<NoticeDTO> noticeList = mapper.getNoticeList(start, perPage);
		
		mview.addObject("noticeList", noticeList);
		mview.addObject("startPage", startPage);
		mview.addObject("endPage", endPage);
		mview.addObject("totalPage", totalPage);
		mview.addObject("currentPage", currentPage);
		mview.addObject("totalCount", totalCount);
		mview.setViewName("/notice/noticeList");
		
		return mview;
	}
	
	
	private ServletContext servletContext;
	
	@GetMapping("/notice/wrtieform")
	public String writeForm() {
		
		return "/notice/noticeAddForm";
	}
	
//	이미지 업로드
	@PostMapping(value = "/notice/upload_ckeditor", produces = { MimeTypeUtils.APPLICATION_JSON_VALUE })
	public ResponseEntity<JSONFileUpload> UploadCKEditor(@RequestParam("upload") MultipartFile upload) {
		try {
			String fileName = UploadFileHelper.upload(servletContext, upload);
			return new ResponseEntity<JSONFileUpload>(new JSONFileUpload("/webapp/ckupload/" + fileName), HttpStatus.OK);
		} catch (Exception e) {
			return new ResponseEntity<JSONFileUpload>(HttpStatus.BAD_REQUEST);
		}
	}
	@Override
	public void setServletContext(ServletContext servletContext) {
		this.servletContext = servletContext;
	}
	
//	isnert
	@PostMapping("/notice/insert")
	public String noticeInsert(
			@ModelAttribute NoticeDTO dto,
			HttpSession session
			) {
		
		String loginok = (String) session.getAttribute("loginok");
		if(loginok == null) {
			return "/notice/loginmsg";
		}
		
		String id = (String) session.getAttribute("id");
		dto.setId(id);
		
		mapper.insertNotice(dto);
		return "redirect:detail?num=" + mapper.getMaxNum();
	}
	
//	디테일
	@GetMapping("/notice/detail")
	public ModelAndView getData(
			@RequestParam String num, 
			HttpSession session, 
			@RequestParam (defaultValue = "1") int currentPage
			) {
		
		ModelAndView mview = new ModelAndView();
		String id = (String) session.getAttribute("id");
		NoticeDTO ndto = mapper.getNoticeData(num);
		
		mview.addObject("ndto", ndto);
		mview.addObject("currentPage", currentPage);
		mview.addObject("before", mapper.getBeforeData(num));
		mview.addObject("after", mapper.getAfterData(num));
		mview.setViewName("/notice/noticeDetail");
		
		return mview;
	}
	
//	수정폼
	@GetMapping("/notice/updateform")
	public ModelAndView updateForm(@RequestParam String num, HttpSession session, String currentPage) {
		
		ModelAndView mview = new ModelAndView();
		
		String id = (String) session.getAttribute("id");
		String login = (String) session.getAttribute("login");
		NoticeDTO ndto = mapper.getNoticeData(num);
		
		mview.addObject("ndto", ndto);
		mview.addObject("currentPage", currentPage);
		mview.setViewName("/notice/noticeUpdateForm");
		return mview;
	}
	
//	수정
	@PostMapping("/notice/update")
	public String noticeUpdate(
			@ModelAttribute NoticeDTO ndto,
			String currentPage,
			HttpSession session
			) {
		
		mapper.updateNotice(ndto);
		return "redirect:detail?num=" + ndto.getNum() + "&currentPage=" + currentPage;
	}
	
//	삭제
	@GetMapping("/notice/delete")
	public String deleteNotice(@RequestParam String num, String currentPage, HttpSession session) {
		
		mapper.deleteNotice(num);
		return "redirect:/notice?currentPage=" + currentPage;
	}
		
}


