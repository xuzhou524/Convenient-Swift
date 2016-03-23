//
//  AppDelegate.swift
//  Convenient-Swift
//
//  Created by gozap on 16/3/1.
//  Copyright © 2016年 xuzhou. All rights reserved.
//

import UIKit
import CoreLocation
import Fabric
import Crashlytics


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,CLLocationManagerDelegate {

    var window: UIWindow?
    var currLocation : CLLocation!
    //用于定位服务管理类，它能够给我们提供位置信息和高度信息，也可以监控设备进入或离开某个区域，还可以获得设备的运行方向
    var locationManager : CLLocationManager = CLLocationManager()
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        locationManager.delegate = self
        //设备使用电池供电时最高的精度
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //精确到1000米,距离过滤器，定义了设备移动后获得位置信息的最小距离
        locationManager.distanceFilter = kCLLocationAccuracyKilometer
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        self.window = UIWindow();
        self.window?.frame=UIScreen.mainScreen().bounds;
        self.window?.backgroundColor = XZSwiftColor.convenientBackgroundColor;
        self.window?.makeKeyAndVisible();
        
        let centerNav = XZSwiftNavigationController(rootViewController: HomeViewController());
    
        self.window?.rootViewController = centerNav;
        #if DEBUG
        #else
            Fabric.with([Crashlytics.self])
        #endif
      //  Fabric.sharedSDK().debug = true
        
        WXApi.registerApp("wx96ad3427da325ef7", withDescription: "用易")
        self.shareSetup()
        
        return true
    }
    func shareSetup(){
        ShareSDK.registerApp("10ceb4d796c88")
        //当使用新浪微博客户端分享的时候需要按照下面的方法来初始化新浪的平台
        ShareSDK.connectSinaWeiboWithAppKey("3112753426", appSecret: "8d827d8c5849b1d763f2d077d20e109e", redirectUri: "www.xzzai.com")
        
        //添加QQ空间应用  注册网址  http://connect.qq.com/intro/login/
        ShareSDK.connectQZoneWithAppKey("100371282",appSecret:"aed9b0303e3ed1e27bae87c33761161d",qqApiInterfaceCls:QQApiInterface.self,tencentOAuthCls:TencentOAuth.self)
        

        //添加QQ应用  注册网址  http://open.qq.com/
        ShareSDK.connectQQWithQZoneAppKey("1104406915",qqApiInterfaceCls:QQApiInterface.self,tencentOAuthCls:TencentOAuth.self)

        //添加微信应用 注册网址 http://open.weixin.qq.com
        ShareSDK.connectWeChatWithAppId("wx96ad3427da325ef7",appSecret:"62f813deed12407560466d724937900e",wechatCls:WXApi.self)
        
    }
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currLocation = locations.last! as CLLocation
        let geocder = CLGeocoder()
        var p:CLPlacemark?
        geocder.reverseGeocodeLocation(currLocation) { (placemarks, error) -> Void in
            if error != nil {
                return
            }
            let pm = placemarks! as [CLPlacemark]
            if pm.count > 0{
                p = placemarks![0] as CLPlacemark
                
                let lenght :Int = ((p?.locality)! as String).Lenght - 1
                if p?.locality?.Lenght > 0 {
                   XZSetting.sharedInstance[KplacemarkName] = ((p?.locality)! as NSString).substringToIndex(lenght)
                }
            }
        }
       locationManager.stopUpdatingLocation()
    }
    
    func application(application: UIApplication, handleOpenURL url: NSURL) -> Bool {
        return ShareSDK.handleOpenURL(url, wxDelegate: self)
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        return ShareSDK.handleOpenURL(url, sourceApplication: sourceApplication, annotation: annotation, wxDelegate: self)
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

