package com.fengjie.controller.themes;

import com.fengjie.init.BlogConst;
import com.fengjie.init.Pages;
import com.fengjie.init.Theme;
import com.fengjie.json.RestResponse;
import com.fengjie.model.entity.Comments;
import com.fengjie.model.entity.Contents;
import com.fengjie.model.entity.Options;
import com.fengjie.service.ArticleService;
import com.fengjie.service.CommentService;
import com.fengjie.service.SiteService;
import com.fengjie.service.ThemeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.Errors;
import org.springframework.validation.ObjectError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import sun.misc.Request;

import javax.servlet.http.HttpServletRequest;
import javax.xml.stream.events.Comment;
import java.util.List;

@Controller
@RequestMapping("")
public class BaseController {
    @Autowired
    private ArticleService articleService;
    @Autowired
    private ThemeService themeService;
    @Autowired
    private SiteService siteService;
    @Autowired
    private CommentService commentService;

    private String[] icons = {"design","link","web","image","note","game","book","lock"};

    @RequestMapping(value = "",method = RequestMethod.GET)
    public String index(ModelMap map) throws Exception {
        return this.index(1,map);
    }


    @RequestMapping(value="page/{present}",method = RequestMethod.GET)
    public String index(@PathVariable int present, ModelMap map) throws Exception {
        Integer total = articleService.getTotalContentsNum(null);
        Pages page = new Pages(total);
        page.setPresent(present);
        page.setLimit(12);
        List<Contents> contents = articleService.getReleasedArticlesByPages(page);
        Options options = themeService.getOptions(BlogConst.AUTHOR_ACCOUNT);
        List<Comments> recentComments = siteService.getRecentComments(8);
        List<Contents> recendArticles = siteService.getRecentReleasedContents(8);
        map.addAttribute("page",page);
        map.addAttribute("recentComments",recentComments);
        map.addAttribute("options",options);
        map.addAttribute("articles",contents);
        map.addAttribute("icons",icons);
        map.addAttribute("recendArticles",recendArticles);
        return "themes/default/index";
    }

    @RequestMapping(value="article/{cid}",method = RequestMethod.GET)
    public String article(@PathVariable int cid,ModelMap map,@RequestParam(name="present",defaultValue = "1") int present) throws Exception {
        //需要文章，is_post,options,comments,评论的page信息
        Integer totalCommentsNum = siteService.getCommentsCount(cid);
        Pages page = new Pages(totalCommentsNum);
        page.setLimit(6);
        page.setPresent(present);
        Options options = themeService.getOptions(BlogConst.AUTHOR_ACCOUNT);
        List<Contents> recendArticles = siteService.getRecentReleasedContents(8);
        List<Comments> recentComments = siteService.getRecentComments(8);
        Contents article = articleService.getArticleByCid(cid);
        List<Comments> comments = commentService.getCommentsByCidAndPage(cid,"comment",page);
        if("markdown".equals(article.getFmtType())){
            String content = Theme.mdToHtml(article.getContent());
            article.setContent(content);
        }
        articleService.addHits(cid);
        //点击进入文章页面，此时将文章的浏览量+1，并修改contents数据
        map.addAttribute("options",options);
        map.addAttribute("page",page);
        map.addAttribute("article",article);
        map.addAttribute("comments",comments);
        map.addAttribute("isPost",true);
        map.addAttribute("recentComments",recentComments);
        map.addAttribute("recendArticles",recendArticles);
        return "themes/default/post";
    }

    @RequestMapping(value = "search/{keyword}",method = RequestMethod.GET)
    public String search(@PathVariable String keyword,ModelMap map) throws Exception {
        Options options = themeService.getOptions(BlogConst.AUTHOR_ACCOUNT);
        List<Contents> recendArticles = siteService.getRecentReleasedContents(8);
        List<Comments> recentComments = siteService.getRecentComments(8);
        List<Contents> articles = siteService.getContentsByBlurry(keyword,"search");
        map.addAttribute("type","搜索");
        map.addAttribute("options",options);
        map.addAttribute("recentComments",recentComments);
        map.addAttribute("icons",icons);
        map.addAttribute("recendArticles",recendArticles);
        map.addAttribute("articles",articles);
        return "themes/default/page-category";
    }

    @RequestMapping(value = "tag/{keyword}",method = RequestMethod.GET)
    public String tag(@PathVariable String keyword,ModelMap map) throws Exception {
        Options options = themeService.getOptions(BlogConst.AUTHOR_ACCOUNT);
        List<Contents> recendArticles = siteService.getRecentReleasedContents(8);
        List<Comments> recentComments = siteService.getRecentComments(8);
        List<Contents> articles = siteService.getContentsByBlurry(keyword,"tag");
        map.addAttribute("type","标签");
        map.addAttribute("options",options);
        map.addAttribute("recentComments",recentComments);
        map.addAttribute("icons",icons);
        map.addAttribute("recendArticles",recendArticles);
        map.addAttribute("articles",articles);
        return "themes/default/page-category";
    }

    @RequestMapping(value = "category/{keyword}",method = RequestMethod.GET)
    public String category(@PathVariable String keyword,ModelMap map) throws Exception {
        Options options = themeService.getOptions(BlogConst.AUTHOR_ACCOUNT);
        List<Contents> recendArticles = siteService.getRecentReleasedContents(8);
        List<Comments> recentComments = siteService.getRecentComments(8);
        List<Contents> articles = siteService.getContentsByBlurry(keyword,"category");
        map.addAttribute("type","分类");
        map.addAttribute("options",options);
        map.addAttribute("recentComments",recentComments);
        map.addAttribute("icons",icons);
        map.addAttribute("recendArticles",recendArticles);
        map.addAttribute("articles",articles);
        return "themes/default/page-category";
    }

    @RequestMapping(value = "about",method = RequestMethod.GET)
    public String about(ModelMap map) throws Exception {
        Options options = themeService.getOptions(BlogConst.AUTHOR_ACCOUNT);
        List<Contents> recendArticles = siteService.getRecentReleasedContents(8);
        List<Comments> recentComments = siteService.getRecentComments(8);
        Contents article = siteService.getOtherPage("about");
        String html = Theme.mdToHtml(article.getContent());
        article.setContent(html);
        map.addAttribute("article",article);
        map.addAttribute("options",options);
        map.addAttribute("recentComments",recentComments);
        map.addAttribute("recendArticles",recendArticles);
        return "themes/default/page";
    }

    @RequestMapping(value = "comment",method = RequestMethod.POST)
    public @ResponseBody RestResponse<Integer> comment(@Validated Comments comment, BindingResult bindingResult, HttpServletRequest req) throws Exception {
        List<ObjectError> allErrors = bindingResult.getAllErrors();
        if(allErrors.size() > 0){
            return RestResponse.fail(allErrors.get(0).getDefaultMessage());
        }
        StringBuffer url = req.getRequestURL();
        String ip = req.getLocalAddr();
        comment.setIp(ip);
        if(comment.getUrl() == null){
            comment.setUrl(url.toString());
        }
        Integer coid = commentService.saveComment(comment);
        return RestResponse.success("修改成功",coid);
    }


    //需要一个补充的评论处理类。

}
