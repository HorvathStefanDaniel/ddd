package madasi.ddd.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import madasi.ddd.model.User;
import madasi.ddd.service.UserRepository;

@Controller
@RequestMapping("/")
public class HomeController {
	
	Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	private UserRepository userRepository;

	@GetMapping("/")
    public String home(Model model) {
    	return "home";
    }
	
	@GetMapping("/showUser/{id}")
	public String users(@PathVariable("id") String userId,
			Model model) {
		
		try {
			User u = userRepository.findById(Integer.valueOf(userId)).get();
			model.addAttribute("savedUser", u);
		}catch(Exception e) {
			logger.error("Error in showUser, maybe invalid ID or couldn't connect to database", e);
		}
			
		return "userDetails";
	}
	
}