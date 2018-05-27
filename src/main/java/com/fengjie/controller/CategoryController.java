package com.fengjie.controller;

import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fengjie.json.RestResponse;
import com.fengjie.model.dto.Colors;
import com.fengjie.model.entity.Metas;
import com.fengjie.model.entity.User;
import com.fengjie.service.CategoryService;

@Controller
@RequestMapping("/admin/category")
public class CategoryController {
	@Autowired
	private CategoryService categoryService;
	
	/**
	 * 这个才刚开始写,需要修改前面的文章保存方法,加上判断tags的过程,并且将新的tags储存起来.
	 * 然后刷新缓存.
	 * @param request
	 * @return
	 * @throws Throwable
	 */
	
	@RequestMapping(value="",method=RequestMethod.GET)
	public String index(HttpServletRequest request,ModelMap map) throws Throwable {
		User user = (User) request.getSession().getAttribute("user");
		List<Metas> tags = categoryService.getMetas("tag",user.getUid());
		List<Metas> categories = categoryService.getMetas("category", user.getUid());
		Colors colors = new Colors();
		map.addAttribute("colors", colors);
		map.addAttribute("tags", tags);
		map.addAttribute("categories", categories);
		return "admin/category";
	}
	
	//更像分类标签时,涉及到的关联文章也要进行更新.个人觉得应该用metas的id去关联文章,而不是类型字段
	@RequestMapping(value="/save",method=RequestMethod.POST)
	public @ResponseBody RestResponse<String> saveCategory(Integer mid,String cname,HttpSession session) throws Exception{
		User user = (User) session.getAttribute("user");
		try {
			if(mid == null) {
				Metas meta = new Metas();
				meta.setAuthorId(user.getUid());
				meta.setName(cname);
				meta.setType("category");
				meta.setCount(0);
				Integer inf = categoryService.insertMetas(meta);
				if(inf == 1) {
					return RestResponse.success();
				}
				return RestResponse.fail("数据库错误");
			}
			Metas category = categoryService.getMetasByNameAndType(null, null, null, mid);
			if(category.getCount() > 0) {
				return RestResponse.fail("标签下的文章不为空");
			}
			category.setName(cname);
			Integer inf = categoryService.insertMetas(category);
			if(inf == 1) {
				return RestResponse.success();
			}
		} catch (Exception e) {
			e.printStackTrace();
			return RestResponse.fail("数据库错误");
		}
		return RestResponse.fail("数据库错误");
	}
	
	@RequestMapping(value="/delete",method=RequestMethod.POST)
	public @ResponseBody RestResponse<String> delete(Integer mid) throws Exception{
		Integer inf = categoryService.deleteMetasByMid(mid);
		if(inf == 1) {
			return RestResponse.success();
		}
		return RestResponse.fail("没有此标签,或其他错误");
	}

}
