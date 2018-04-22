package com.fengjie.kit;
/**
 * 
 * @author 丰杰
 *
 */

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * 一个自定的缓存,其实在mybatis中有二级缓存,可以使用mybatis自带的二级缓存
 * 这个类可以交给sping管理,不用做成这种类似于工具类的东西.
 * @author 丰杰
 *
 */
public class MapCache {
	
	/**
	 * 默认储存1024
	 */
	private static final int DEFAULT_CACHES = 1024;
	
	private static final MapCache INS = new MapCache();
	
	//单例缓存,交给spring管理,默认就是单例的
	public static MapCache single() {return INS;}
	
	
	/**
	 * 缓存容器
	 */
	private Map<String, CacheObject> cachePool;
	
	public MapCache() {
		this(DEFAULT_CACHES);
	}
	
	
	public MapCache(int capcity) {
		cachePool = new ConcurrentHashMap<>(capcity);
	}
	
	/**
	 * 取出一个缓存
	 * @param key
	 * @return
	 */
	public <T> T get(String key) {
		CacheObject cacheObject = cachePool.get(key);
		if(null != cacheObject) {
			long cur = System.currentTimeMillis() / 1000; //转化成秒
			if(cacheObject.getExpired() <= 0 || cacheObject.getExpired() > cur) {
				Object result = cacheObject.getValue();
				return (T) result;
			}else {
				del(key);
			}
		}
		return null;
	}
	
	/**
	 * 获取一个hash类型的对象
	 * @param key
	 * @param field
	 * @return
	 */
	public <T> T hget(String key,String field) {
		key = key + ":" + field;
		return get(key);
	}
	/**
	 * 设置一个默认时间的缓存
	 * @param key
	 * @param value
	 */
	public void set(String key,Object value) {
		this.set(key, value,(long)-1);
	}
	
	/**
	 * 设置一个自定义过期时间的缓存
	 * @param key
	 * @param value
	 * @param expired 过期时间
	 */
	public void set(String key,Object value,Long expired) {
		expired = expired > 0 ? System.currentTimeMillis()/1000 + expired : expired;
		CacheObject cacheObject = new CacheObject(key, value, expired);
		cachePool.put(key, cacheObject);
	}
	
	public void hset(String key,String filed,Object value) {
		this.hset(key, filed, value, (long)-1);
	}
	
	/**
	 * 设置一个hash类型,自定义过期时间的缓存
	 * @param key
	 * @param filed
	 * @param value
	 * @param expired
	 */
	public void hset(String key,String filed,Object value,Long expired) {
		key = key + ":" + filed;
		expired = expired > 0 ? System.currentTimeMillis() /1000 + expired : expired;
		CacheObject cacheObject = new CacheObject(key, value, expired);
		cachePool.put(key, cacheObject);
	}
	
	/**
	 * 删除一个缓存
	 * @param key
	 */
	public void del(String key) {
		cachePool.remove(key);
	}
	
	/**
	 * 根据key和filed删除一个缓存
	 * @param key
	 * @param filed
	 */
	public void hdel(String key,String filed) {
		key = key + ":" + filed;
		this.del(key);
	}
	
	/**
	 * 清空缓存
	 */
	public void clean() {
		cachePool.clear();
	}
	
	static class CacheObject{
		private String key;
		private Object value;
		private Long expired;
		
		public CacheObject(String key, Object value, long expired) {
            this.key = key;
            this.value = value;
            this.expired = expired;
        }
		
		public String getKey() {
			return this.key;
		}
		
		public Object getValue() {
			return this.value;
		}
		
		public Long getExpired(){
			return this.expired;
		}
		
	}
	
}


