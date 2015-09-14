package com.polytech.utility;

public class Encoding {
	public String toKorUTF(String code){
		String encode="";
		try{
			encode = new String(code.getBytes("ISO-8859-1"),"UTF-8");
		}catch(Exception e){
			e.printStackTrace();
		}
		return encode;
	}
}
