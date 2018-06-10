package com.fengjie.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.fengjie.init.Pages;
import com.fengjie.json.RestResponse;
import com.fengjie.kit.DateKit;
import com.fengjie.kit.StringUtils;
import com.fengjie.model.entity.Attach;
import com.fengjie.model.entity.User;
import com.fengjie.service.AttachService;
import com.fengjie.service.SiteService;

@Controller
@RequestMapping(value = "/admin/attach")
public class AttachController {
	@Autowired
	private AttachService attachService;
	@Autowired
	private SiteService siteService;

	/**
	 * 文件管理主界面
	 * 
	 * @param present
	 * @param map
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "", method = RequestMethod.GET)
	public String index(@RequestParam(defaultValue = "1") int page, ModelMap map, HttpSession session,HttpServletRequest request)
			throws Exception {
		int limit = 12;
		User user = (User) session.getAttribute("user");
		Pages pages = new Pages(siteService.getAttachCount(user));
		pages.setPresent(page);
		pages.setLimit(limit);
		List<Attach> attachs = attachService.getAttachs(user, pages);
		map.addAttribute("attachs", attachs);
		map.addAttribute("page", pages);
		map.addAttribute("max_file_size", 2048000 / 1024);
		//下面代码存在硬编码
		map.addAttribute("attach_url", "/Blog/upload/");
		return "admin/attach";
	}

	@RequestMapping(value = "/upload", method = RequestMethod.POST)
	public @ResponseBody RestResponse<List<Attach>> upload(MultipartHttpServletRequest request1, HttpServletRequest request)
			throws Exception {
		User user = (User) request.getSession().getAttribute("user");
		String basePath = request.getServletContext().getRealPath("/upload");
		List<Attach> errorFiles = new ArrayList<Attach>();
		List<Attach> successFiles = new ArrayList<Attach>();
		try {
			for (MultipartFile multiFile : request1.getFileMap().values()) {
				System.out.println("进入上传文件");
				String tempName = multiFile.getOriginalFilename();;
				String fname = FilenameUtils.getName(tempName);
				if (multiFile.getBytes().length/1024 <= 204800) {
					// 下面一行有硬编码
					System.out.println(multiFile.getContentType());
					String ftype = multiFile.getContentType().contains("image") ? "image" : "file";
					String ext = FilenameUtils.getExtension(fname);
					String fkey = StringUtils.getUUID() + "." + ext;
					
					Attach attach = new Attach();
					attach.setAuthorId(user.getUid());
					attach.setCreated(DateKit.nowUnix());
					attach.setFkey(fkey);
					attach.setFname(fname);
					attach.setFtype(ftype);
					
					String filePath = basePath + StringUtils.getDaliyFilePath(attach.getCreated());
					File filePathTemp = new File(filePath);
					if(!filePathTemp.exists()) {
						filePathTemp.mkdirs();
					}
					File file = new File(filePath, fkey);
					if(!file.exists()) {
						file.mkdir();
						file.createNewFile();
					}
					multiFile.transferTo(file);
					attachService.addAttach(attach);
					successFiles.add(attach);
				}else {
					Attach attach = new Attach();
					attach.setFname(fname);
					errorFiles.add(attach);
				}
			}
			if (errorFiles.size() > 0) {
				System.out.println("上传文件出错");
				return RestResponse.fail(errorFiles,"文件过大");
			}
			if(successFiles.size() > 0) {
				return RestResponse.success(successFiles);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return RestResponse.fail("内部错误");
		}
		return RestResponse.fail("未收到文件");
	}
	
	@RequestMapping(value="/delete",method=RequestMethod.POST)
	public @ResponseBody RestResponse<String> deleteFile(@RequestParam int id,HttpSession session,HttpServletRequest request) throws Exception{
		String basePath = request.getServletContext().getRealPath("/upload");
		User user = (User) session.getAttribute("user");
		Attach attach = attachService.getAttachById(user, id);
		if(attach == null) {
			return RestResponse.fail("无此文件");
		}
		String path = basePath + StringUtils.getDaliyFilePath(attach.getCreated());
		try {
			File file = new File(path, attach.getFkey());
			if(file.exists()) {
				
				//重点跟踪本处
				Integer column = attachService.deleteAttachById(id);
				file.delete();
				if(column == 1) {
					return RestResponse.success();
				}
				return RestResponse.fail("数据库错误");
			}else {
				return RestResponse.fail("路径错误");
			}
		} catch (Exception e) {
			e.printStackTrace();
			return RestResponse.fail("未知错误");
		}
	}

}
