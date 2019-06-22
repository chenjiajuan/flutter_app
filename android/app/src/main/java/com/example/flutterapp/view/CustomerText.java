package com.example.flutterapp.view;

import android.content.Context;
import android.util.Log;
import android.view.View;
import android.widget.TextView;

import java.util.Map;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.platform.PlatformView;

/**
 * create by chenjiajuan on 2019-05-21
 */
public class CustomerText implements PlatformView , MethodChannel.MethodCallHandler {
    private static String TAG=CustomerText.class.getSimpleName();
    TextView textView;

    public CustomerText(Context context, BinaryMessenger messenger, int id, Map<String, Object> maps){
        TextView textView=new TextView(context);
        textView.setText("测试");
        if (maps!=null){
            String key= (String) maps.get("key");
            textView.setText("测试 : "+key);
        }

        textView.setTextColor(context.getResources().getColor(android.R.color.black));
        textView.setBackgroundColor(context.getResources().getColor(android.R.color.holo_orange_light));
        this.textView=textView;
        MethodChannel methodChannel = new MethodChannel(messenger, "flutter.view.TextView");
        methodChannel.setMethodCallHandler(this);
    }

    @Override
    public View getView() {
        return textView;
    }

    @Override
    public void dispose() {

    }

    @Override
    public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
        Log.e(TAG," "+methodCall.method);
        if (methodCall.method.contains("updateTextView")){
            Log.e(TAG,""+methodCall.arguments.toString());
            updateTextView(methodCall.arguments.toString());

        }
        result.success("method recive success");
    }

    private void updateTextView(String text){
        textView.setText(text);
    }
}
