package madasi.ddd.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;

@Controller
@RequestMapping("/")
public class HomeController {

	@GetMapping("/")
    public String home() {
    	return "home";
    }
	
	@GetMapping("/test")
    public String ht() {
    	return "redirect: /ddd/ho.html";
    }
	
}