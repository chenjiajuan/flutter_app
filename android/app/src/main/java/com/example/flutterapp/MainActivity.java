package com.example.flutterapp;

import android.os.Bundle;

import com.example.flutterapp.service.ServiceLoader;

import java.lang.ref.WeakReference;

import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.plugins.TextViewFactory;

public class MainActivity extends FlutterActivity {
  private  static  final  String TAG=MainActivity.class.getSimpleName();
  public static WeakReference<MainActivity> ref;

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    ref=new WeakReference<>(this);
    TextViewFactory.registerWith(this.registrarFor("io.flutter.plugins.TextViewPlugin"));
    ServiceLoader.getInstance().registerWith(this.registrarFor("io.flutter.plugins.ServicePlugin"));
    GeneratedPluginRegistrant.registerWith(this);

  }


}
