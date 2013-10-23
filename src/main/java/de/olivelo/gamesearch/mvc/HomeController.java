package de.olivelo.gamesearch.mvc;

import com.google.common.collect.Lists;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.validation.Valid;

@Controller
@RequestMapping("/")
public class HomeController {

    @Autowired
    GameService gameService;

	@RequestMapping(method = RequestMethod.GET)
	public String printWelcome(Game game, ModelMap model) {
        model.addAttribute("message", "Game Search");
        model.addAttribute("newGame", game);
        model.addAttribute("games", Lists.newArrayList(gameService.getAllGames()));
		return "hello";
	}

    @RequestMapping(method = RequestMethod.POST)
    public String submitNewGame(@Valid Game game, BindingResult bindingResult, ModelMap redirectAttributes) {
        if (bindingResult.hasErrors()) {
            redirectAttributes.addAttribute("error", bindingResult.getFieldError().getDefaultMessage());
            return "redirect:/";
        } else {
            redirectAttributes.remove("error");
            gameService.addGame(game);
            return "redirect:/";
        }

    }
}