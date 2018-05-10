package com.guoke.file.controllers;

import java.io.File;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

@Controller
@RequestMapping("/file")
public class FileController {
	
	protected HttpServletRequest request;
	protected HttpServletResponse response;
	protected HttpSession session;
	protected Map<String, String> map;
	
	@ModelAttribute
	public void setReqAndRes(HttpServletRequest request,HttpServletResponse response) {
		this.request = request;
		this.response = response;
		this.session = request.getSession();
	    
		map=new HashMap<String, String>();
		
		Enumeration<String> enu=request.getParameterNames();  
		while(enu.hasMoreElements()){  
			String paraName=(String)enu.nextElement();  
			map.put(paraName, request.getParameter(paraName));
		}
		
	}
	
	@RequestMapping(value = "/upload", produces = "application/json;charset=UTF-8")
	public @ResponseBody String Upload(MultipartFile file,HttpServletRequest request,HttpServletResponse response) {
		 
	    String path = request.getServletContext().getRealPath("/upload");
	    try
	    {
	
	    	String fileName = file.getOriginalFilename();
    		String suffix = fileName.substring(fileName.lastIndexOf(".")); 
    		fileName = java.util.UUID.randomUUID().toString()+suffix;
    		String fileType = file.getContentType();
    		InputStream in = file.getInputStream();
            int size = file.getInputStream().available();
	    	FileUtils.copyInputStreamToFile(in,new File(path+"/"+fileName));
	    	
	    	String host = request.getServerName();
	    	int port = request.getServerPort();
	    	
	    	String serverUrl= request.getScheme()+"://"+host;
	    	if(port!=80||port!=443) {
	    		serverUrl+=":"+port;
	    	}
	    	
	    	Map<String,String> fileinfo = new HashMap<String, String>();
	    	fileinfo.put("fileName",fileName);
	    	fileinfo.put("filePath",serverUrl+"/"+request.getContextPath()+"/upload/"+fileName);
	    	fileinfo.put("fileType",fileType);
	    	fileinfo.put("size",""+size);	    	
	    	return Success("上传成功",fileinfo);
	    	
	    }catch(Exception e) {
	    	return Error("上传失败:"+e.getMessage());
	    }
		
	}
	
	public String JSON(Object obj) {
		String callback = request.getParameter("callback");
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();	
		String json = gson.toJson(obj);
		if(!StringUtils.isEmpty(callback)) {
			return  callback+"("+json+")";
		}
		return json;
	}
	public String Success(String message,Object data) {
		Map<String,Object> msg = new HashMap<>();
		msg.put("data", data);
		msg.put("message", message);
		msg.put("result", true);
		msg.put("code", 0);
		return JSON(msg);
	}
	
	public String Success(String message) {
		return Success(message,null);
	}
	
	public String Error(String message) {
		Map<String,Object> msg = new HashMap<>();
		msg.put("message", message);
		msg.put("result", false);
		msg.put("code", -1);
		return JSON(msg);
	}

}
