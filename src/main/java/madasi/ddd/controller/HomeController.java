package madasi.ddd.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.annotation.PostConstruct;
import jakarta.servlet.http.HttpSession;

@Controller
public class HomeController {

	Logger logger = LoggerFactory.getLogger(HomeController.class);

	String PROJECT_NAME = "Romanian TVEE's gaming studio";

//	@Autowired
//	private UserRepository userRepository;
//
//	@Autowired
//	private SettingRepository settingRepository;

	// executes on startup
	@PostConstruct
	void onStartup() {
		try {
			logger.info("HELLO");
//			Optional<Setting> s = settingRepository.findById(1);
//			Setting setupSet;
//			if (s.isEmpty()) {
//				setupSet = new Setting();
//				setupSet.setId(1);
//				settingRepository.save(setupSet);
//			} else {
//				setupSet = s.get();
//			}
//			setupSet.setProjectName(PROJECT_NAME);
//			settingRepository.save(s.get());
//			logger.info(s.toString());

		} catch (Exception e) {
			logger.error("On startup error: ", e);
		}
	}

	// automatically ads settings object to pages
//	@ModelAttribute
//	public void addAttributes(Model model) {
//		Optional<Setting> s = settingRepository.findById(1);
//		model.addAttribute("setting", s.get());
//	}

	//if you want the home page to be something else. 
//	@RequestMapping("/")
//	public String home(Model model, HttpSession session) {
//		String messages = "Hello";
//
//		model.addAttribute("msg", messages);
//
//		return "home";
//	}
	
//	@RequestMapping("/")
//	public String home(Model model, HttpSession session) {
//		String messages = "Hello";
//
//		model.addAttribute("msg", messages);
//
//		return "home";
//	}

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


}