package com.fengjie.controller;

import com.fengjie.json.RestResponse;
import com.fengjie.model.dto.Theme;
import com.fengjie.model.entity.Options;
import com.fengjie.model.entity.User;
import com.fengjie.service.ThemeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/admin/themes")
public class ThemeController {
    @Autowired
    private ThemeService themeService;

    @RequestMapping(value = "",method = RequestMethod.GET)
    public String index(ModelMap map){
        //并没有提供更多的主题，暂时不设置主题提供方法
        Theme theme = new Theme();
        List<Theme> themes = new ArrayList<>();
        themes.add(theme);
        theme.setName("default");
        map.addAttribute("themes",themes);
        map.addAttribute("current_theme","default");
        return "admin/themes";
    }

    @RequestMapping(value = "/setting",method=RequestMethod.GET)
    public String setting(HttpServletRequest req, ModelMap map){
        User user = (User) req.getSession().getAttribute("user");
        Options options = themeService.getOptions(user.getUid());
        if(options == null) options = new Options();
        map.addAttribute("options",options);
        return "themes/default/setting";
    }

    @RequestMapping(value="/setting",method = RequestMethod.POST)
    public @ResponseBody RestResponse<String> saveSetting(Options options, HttpSession session){
        User user = (User) session.getAttribute("user");
        options.setUid(user.getUid());
        RestResponse<String> build = themeService.updateSetting(options);
        return build;
    }



}
