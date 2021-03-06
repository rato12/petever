package com.kh.petever.message.controller;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
//import com.kh.petever.animalboard.model.vo.AnimalBoard;
import com.kh.petever.message.model.service.MessageService;
import com.kh.petever.message.model.vo.Message;
//import com.kh.petever.reviewBoard.model.vo.ReviewBoard;
import com.kh.petever.user.model.vo.User;
import lombok.extern.slf4j.Slf4j;
@Controller
@Slf4j
public class MessageController {
	@Autowired 
	private MessageService messageService;
//	@Autowired
//	private AnimalBoard animalBoard;
//	@Autowired
//	private ReviewBoard reviewBoard;
	@RequestMapping("/message/messageList.do")
	public ModelAndView msglist(ModelAndView mav, @RequestParam(defaultValue = "1", value="cPage") int cPage, HttpSession session
								) {
		//1.사용자 입력값 
		final int limit = 10;
		int offset = (cPage - 1) * limit;
		RowBounds rowBound = new RowBounds(offset, limit);
		User user = (User)session.getAttribute("loginUser");
		log.debug("loginUser22{}", user);
		//2. 업무로직
		List<Message> messageList = messageService.selectMessageList(user, rowBound);
		log.debug("list = {}", messageList);
		//전체컨텐츠수 구하기
		int totalContents = messageService.selectMessageTotalContents(user);

		//3. view단 처리
		mav.addObject("totalContents", totalContents);
		mav.addObject("list", messageList);
		mav.setViewName("message/messageList");
		return mav;
	}
	@RequestMapping("/message/messageForm.do")
	public ModelAndView messageForm(@RequestParam("receiveId")String receiveId, ModelAndView mav) {
		mav.setViewName("message/messageForm");
		mav.addObject("receiveId", receiveId);
		return mav;
	}
	@RequestMapping("/message/insertmessage")
	@ResponseBody
	public Map<String, Object> insertBoard(Message message, RedirectAttributes redirectAttr, HttpServletRequest req){
		//로그인한 사용자 아이디
		log.debug("Message = {}", message);
		Map<String, Object> msg = new HashMap<>();
		try {
			int result = messageService.insertMessage(message);
			msg.put("msg", "메세지 보내기 성공");
		} catch(Exception e) {
			log.error("메세지 등록 오류", e);
			msg.put("msg", "메세지 보내기실패");
		}
		return msg;
	}
    @RequestMapping("/message/messageDetail")
    public @ResponseBody Map<String, Object> detail(Message msg){
    	log.debug("msg = {}", msg);
    	Map<String, Object> map = new HashMap<>();
    	List<Message> msgDetail = messageService.selectOneUser(msg);
    	List<Message> msgDetailDate = messageService.selectGetDate(msg);
    	log.debug("msgDetail = {}", msgDetail);
    	log.debug("msgDetailDate = {}", msgDetailDate);
    	map.put("msgDetailDate", msgDetailDate);
    	map.put("msgDetail", msgDetail);
    	return map;
    }
    @RequestMapping("/message/messageDetailSend")
	public @ResponseBody Map<String, Object> messageDetailSend(Message message ){
		//로그인한 사용자 아이디
		log.debug("Message = {}", message);
		Map<String, Object> map = new HashMap<>();
		try {
			int result = messageService.insertMessage(message);
			map.put("msg", "성공");
		} catch(Exception e) {
			log.error("게시글 등록 오류", e);
			map.put("msg", "실패");
		}
		return map;
	}
}