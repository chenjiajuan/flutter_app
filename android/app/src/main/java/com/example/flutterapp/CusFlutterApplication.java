package com.example.flutterapp;

import android.app.Activity;
import android.app.Application;

import com.example.flutterapp.service.IPlatform;
import com.example.flutterapp.service.ServiceLoader;

import io.flutter.app.FlutterApplication;

/**
 * create by chenjiajuan on 2019-05-22
 */
public class CusFlutterApplication extends FlutterApplication {

    @Override
    public void onCreate() {
        super.onCreate();
        ServiceLoader.getInstance().load(new IPlatform() {
            @Override
            public Application getApplication() {
                return CusFlutterApplication.this;
            }

            @Override
            public Activity getMainActivity() {
                return MainActivity.ref.get();
            }
        });
    }
}
