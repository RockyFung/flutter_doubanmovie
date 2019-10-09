//
//  FlutterNativePlugin.swift
//  Runner
//
//  Created by 冯剑 on 2019/10/8.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

import Foundation
import Flutter

class FlutterNativePlugin:NSObject,FlutterPlugin {

    
    static func register(with registrar: FlutterPluginRegistrar) {
        let channel:FlutterMethodChannel = FlutterMethodChannel(name: "flutter.doubanmovie/buy", binaryMessenger: registrar.messenger())
        let instance = FlutterNativePlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
        
    }
    
    func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "buyTicket":
            
            let para = call.arguments as? String
            print("flutter调用成功，参数：\(String(describing: para))")
            result(0)
        default:
            result(FlutterMethodNotImplemented)
        }

    }
    
   
}


