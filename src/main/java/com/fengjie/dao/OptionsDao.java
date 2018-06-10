package com.fengjie.dao;

import com.fengjie.model.entity.Options;

public interface OptionsDao {

    public Options getOptionsByUid(Integer uid);

    public int insertOptions(Options options);

    public int updateOptions(Options options);

}
