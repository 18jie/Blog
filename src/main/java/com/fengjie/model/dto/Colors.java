package com.fengjie.model.dto;

import java.util.Random;

public class Colors {
	
	private String[] colorArray = {"red","green","blue","yellow","graw","pink"};
	
	private String color;
	
	public String getColor() {
		Random random = new Random();
		return colorArray[random.nextInt(6)];
	}

}
