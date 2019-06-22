package io.flutter.plugins;

import android.content.Context;

import com.example.flutterapp.view.CustomerText;

import java.util.Map;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;

/**
 * create by chenjiajuan on 2019-05-21
 */
public class TextViewFactory extends PlatformViewFactory {
    private BinaryMessenger binaryMessenger;

    public TextViewFactory(BinaryMessenger binaryMessenger) {
        super(StandardMessageCodec.INSTANCE);
        this.binaryMessenger = binaryMessenger;

    }

    @Override
    public PlatformView create(Context context, int i, Object o) {
        Map<String,Object> map= (Map<String, Object>) o;
        return new CustomerText(context,binaryMessenger,i,map);
    }

    public static void registerWith(Registrar registrar){
        registrar.platformViewRegistry().registerViewFactory("cjj.flutter.io.viewFactory",new TextViewFactory(registrar.messenger()));
    }
}
