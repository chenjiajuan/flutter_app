package com.example.flutterapp.service;

import java.util.List;
import java.util.Map;

/**
 * create by chenjiajuan on 2019-05-22
 */
public interface MessageHandler {

    List<String> handleMessageNames();

    boolean onMethodCall(Map args);
}
