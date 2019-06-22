package com.example.flutterapp.service;


import android.content.Context;
import android.content.Intent;
import android.util.Log;

import com.example.flutterapp.NativeActivity;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;


/**
 * create by chenjiajuan on 2019-05-22
 */
public class NavigationService_pageOnStart implements MessageHandler {
    private static final String TAG = NavigationService_pageOnStart.class.getSimpleName();


    public static void register() {
        MessageDispatch.sharedInstance().registerHandler(new NavigationService_pageOnStart());

    }


    @Override
    public List<String> handleMessageNames() {
        List<String> h = new ArrayList<>();
        h.add("openPage");
        return h;
    }

    @Override
    public boolean onMethodCall(Map args) {
        Log.e(TAG, "" + args.toString());
        Context activity = ServiceLoader.getInstance().getIPlatPlugin().getMainActivity();
        if (activity != null) {
            Intent intent = new Intent(activity, NativeActivity.class);
            activity.startActivity(intent);
            return true;
        }
        Context context = ServiceLoader.getInstance().getIPlatPlugin().getApplication();
        if (context != null) {
            Intent intent = new Intent(context, NativeActivity.class);
            intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            context.startActivity(intent);
            return true;
        }
        return false;

    }


}
