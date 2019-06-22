package com.example.flutterapp.service;

import android.util.Log;

import java.util.Map;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

/**
 * create by chenjiajuan on 2019-05-22
 */
public class ServiceLoader implements MethodChannel.MethodCallHandler {
    private  static final  ServiceLoader instance=new ServiceLoader();
    private BinaryMessenger messenger;
    private IPlatform iPlatform;


    public static  ServiceLoader  getInstance(){
        return  instance;
    }

    public  void load(IPlatform platform) {
        this.iPlatform=platform;
        NavigationServiceRegister.register();
    }

    public  void registerWith(PluginRegistry.Registrar registrar){
        messenger =registrar.messenger();
        register();

    }

    @Override
    public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
        Log.e("TAG","onMethodCall......"+methodCall.method);
        if (methodCall.method != null) {
            MessageDispatch.sharedInstance().dispatch(methodCall.method,methodCall.arguments);
        }

    }

    private void  register(){
        MethodChannel methodChannel = new MethodChannel(this.messenger,"native_method_service");
        methodChannel.setMethodCallHandler(this);
    }

    public  IPlatform  getIPlatPlugin(){
        return iPlatform;
    }







}
