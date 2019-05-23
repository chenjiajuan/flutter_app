package com.example.flutterapp.service;

import android.os.Message;
import android.util.Log;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * create by chenjiajuan on 2019-05-22
 */
public class MessageDispatch {
    private static final MessageDispatch instance = new MessageDispatch();
    private static final String TAG=MessageDispatch.class.getSimpleName();
    private Map<String, MessageHandler> _handlers = new HashMap<>();

    public static MessageDispatch sharedInstance() {
        return instance;
    }

    public void dispatch(String method, Object argmurs) {
        MessageHandler handler = _handlers.get(method);
        if (handler != null) {
            handler.onMethodCall((Map) argmurs);
        }
    }

    public void registerHandler(MessageHandler handler) {
        if (handler == null) {
            return;
        }
        List<String> messages = handler.handleMessageNames();
        for (String name : messages) {
            if (_handlers.get(name) == null) {
                _handlers.put(name, handler);
            } else {
                assert (false) : "Register mutiple handlers for same key result in undeined error!";
            }
        }
       for (Map.Entry<String,MessageHandler> entry:_handlers.entrySet()){
           Log.e(TAG," key : "+entry.getKey()+" , value : "+entry.getValue());
       }

    }

}
