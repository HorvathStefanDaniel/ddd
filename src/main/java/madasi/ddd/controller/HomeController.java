package madasi.ddd.controller;

import jakarta.annotation.PostConstruct;
import jakarta.servlet.http.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import madasi.ddd.model.Setting;
import madasi.ddd.model.User;
import madasi.ddd.service.SettingRepository;
import madasi.ddd.service.UserRepository;

@Controller
public class HomeController {

	Logger logger = LoggerFactory.getLogger(HomeController.class);

	String PROJECT_NAME = "Romanian TVEE's gaming studio";

	@Autowired
	private UserRepository userRepository;

	@Autowired
	private SettingRepository settingRepository;

	// executes on startup
	@PostConstruct
	void onStartup() {
		try {
			logger.info("HELLO");
			Optional<Setting> s = settingRepository.findById(1);
			Setting setupSet;
			if (s.isEmpty()) {
				setupSet = new Setting();
				setupSet.setId(1);
				settingRepository.save(setupSet);
			} else {
				setupSet = s.get();
			}
			setupSet.setProjectName(PROJECT_NAME);
			settingRepository.save(s.get());
			logger.info(s.toString());

		} catch (Exception e) {
			logger.error("On startup error: ", e);
		}
	}

	// automatically ads settings object to pages
	@ModelAttribute
	public void addAttributes(Model model) {
		Optional<Setting> s = settingRepository.findById(1);
		model.addAttribute("setting", s.get());
	}

	@RequestMapping("/")
	public String home(Model model, HttpSession session) {
		String messages = "Hello";

		model.addAttribute("msg", messages);

		return "home";
	}

	@RequestMapping("/demo")
	public String demo(Model model, HttpSession session) {
		return "demo";
	}

//	@PostMapping("/persistMessage")
//	public ResponseEntity<List<String>> persistMessage(@RequestParam("msg") String msg, HttpServletRequest request) {
//		@SuppressWarnings("unchecked")
//		List<String> messages = (List<String>) request.getSession().getAttribute("MY_SESSION_MESSAGES");
//		if (messages == null) {
//			messages = new ArrayList<>();
//			request.getSession().setAttribute("MY_SESSION_MESSAGES", messages);
//		}
//		messages.add(msg);
//		request.getSession().setAttribute("MY_SESSION_MESSAGES", messages);
//		return new ResponseEntity<>(messages,HttpStatus.OK);
//	}

	@GetMapping("/showUser/{id}")
	public String users(@PathVariable("id") String userId, Model model) {

		try {
			User u = userRepository.findById(Integer.valueOf(userId)).get();
			model.addAttribute("savedUser", u);
		} catch (Exception e) {
			logger.error("Error in showUser, maybe invalid ID or couldn't connect to database", e);
		}

		return "userDetails";
	}

}