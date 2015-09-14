<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.io.File"%>
<%@page import="java.io.BufferedInputStream"%>
<%@page import="java.io.BufferedOutputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.net.URLEncoder"%>
<%
	//request.setCharacterEncoding("UTF-8");
	
	String filename = request.getParameter("filename");
	
	String filePath = "d:/fileupload/";
	
	response.setContentType("application/x-msdownload");
	
	String strClient = request.getHeader("user-agent");
	
	boolean ie = (strClient.indexOf("MSIE") > -1) || (strClient.indexOf("Trident") > -1);
	
	
	String convName1 = "";
	if(ie){
		convName1 = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", "%20");
		
	}else{
		convName1 = new String(filename.getBytes("UTF-8"), "8859_1");
	}

	response.setHeader("Content-Disposition", "attachment; filename="+convName1+";");
	
	//String convName2 = new String(filename.getBytes("ISO_8859_1"), "UTF-8");

	File file = new File(filePath+filename);
	
	byte b[] = new byte[(int)file.length()];
	
	if(file.length()>0 && file.isFile()){
		BufferedInputStream bis = new BufferedInputStream(new FileInputStream(file));
		BufferedOutputStream bos = new BufferedOutputStream(response.getOutputStream());
		int read=0;
		try{
			out.clear();
			while((read=bis.read(b)) != -1){
				bos.write(b, 0, read);
			}
			bos.close();
			bis.close();
			
		}catch(Exception e)
		{
			e.printStackTrace();
		}finally{
			if(bos!=null) bos.close();
			if(bis!=null) bis.close();
		}
	}
%>