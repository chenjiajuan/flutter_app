package com.example.flutterapp.service;

import android.app.Activity;
import android.app.Application;

/**
 * create by chenjiajuan on 2019-05-23
 */
public interface IPlatform {
    /**
     * get current application
     * @return
     */
    Application getApplication();

    /**
     * get main activity, which must always exist at the bottom of task stack.
     * @return
     */
    Activity getMainActivity();
}
