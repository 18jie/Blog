package com.fengjie.service;

import com.fengjie.dao.OptionsDao;
import com.fengjie.json.RestResponse;
import com.fengjie.model.entity.Options;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ThemeService {
    @Autowired
    private OptionsDao optionsDao;

    public Options getOptions(Integer uid){
        Options options = optionsDao.getOptionsByUid(uid);
        if(null == options){
            return null;
        }
        return options;
    }

    public RestResponse<String> updateSetting(Options options){
        Options option = getOptions(options.getUid());
        //一下存在调试语句
        System.out.println("当前是够有options对象 :" +option);
        if(option == null){
            int result = optionsDao.insertOptions(options);
            System.out.println("插入操作返回的结果：" + result);
            if(result == 0) return RestResponse.fail("插入失败");
        }
        int result = optionsDao.updateOptions(options);
        if(result == 0) return RestResponse.fail("修改失败");
        return RestResponse.success("操作成功");
    }

}
