package madasi.ddd.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;

import madasi.ddd.model.User;
import madasi.ddd.service.UserRepository;

@Controller
@RequestMapping("/")
public class HomeController {
	
	@Autowired
	private UserRepository userRepository;

	@GetMapping("/")
    public String home() {
    	return "home";
    }
	
	@GetMapping("/test")
    public String ht() {
    	return "redirect: /ddd/ho.html";
    }
	
	@GetMapping("/showUsersTest")
	public String users(Model model) {
		User u = new User();
		u.setName("Stefan");
		userRepository.save(u);
		model.addAttribute("savedUser", u);
		
		return "userDetails";
	}
	
}