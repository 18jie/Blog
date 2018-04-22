package com.fengjie.init;


public class Pages {
	//内容总数
	private Integer total;
	//结束页面
	private Integer end;
	//当前页面
	private Integer present = 1;
	//下一页面
	private Integer next;
	//上一页
	private Integer previous;
	//每页条数
	private Integer limit = 10;
	
	public Pages(int total) {
		this.total = total;
		int temp = total%limit;
		end = temp == 0 ? total/limit : total/limit + 1;
	}
	
	private void setNext() {
		next = present == end ? end : present + 1;
	}
	
	public Integer getNext() {
		return this.next;
	}
	
	private void setPrevious() {
		previous = present == 1 ? 1 : present - 1;
	}
	
	public Integer getPrevious() {
		return this.previous;
	}
	
	public void setPresent(int present) {
		this.present = present;
		setNext();
		setPrevious();
	}
	
	public Integer getPresent() {
		return present;
	}
	
	public void setLimit(int limit) {
		this.limit = limit;
	}
	
	public Integer getLimit() {
		return this.limit;
	}

}
