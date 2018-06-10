package com.fengjie.init;


public class Pages {
	//内容总数
	private Integer total;
	//开始页面
	private Integer begin = 1;
	//结束页面
	private Integer end;
	//当前页面
	private Integer present;
	//下一页面
	private Integer next;
	//上一页
	private Integer previous;
	//每页条数
	private Integer limit = 10;
	
	public Pages(int total) {
		this.total = total;
		caculateEnd(total);
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
		if(present > limit){
			begin = present-limit+1;
		}
		if(present < limit){
			begin = 1;
		}
		this.present = present;
		setNext();
		setPrevious();
	}
	
	public Integer getPresent() {
		return present;
	}
	
	public void setLimit(int limit) {
		this.limit = limit;
		caculateEnd(total);
	}
	
	public Integer getLimit() {
		return this.limit;
	}
	
	public Integer getBegin() {
		return this.begin;
	}
	
	public Integer getEnd() {
		return this.end;
	}

	public void caculateEnd(int total){
		this.total = total;
		int temp = total%limit;
		int temp2 = total/limit;
		if(temp == 0 && temp2 == 0) {
			end = 1;
		}else {
			end = temp == 0 ? temp2 : temp2 + 1;
		}
	}
}
