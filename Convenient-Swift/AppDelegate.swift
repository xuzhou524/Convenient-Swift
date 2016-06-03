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
        
        WXApi.registerApp("wx88234dc1246eb81b", withDescription: "用易")
        self.shareSetup()
        
        return true
    }
    func shareSetup(){
        ShareSDK.registerApp("10ceb4d796c88",
                             activePlatforms:
                [SSDKPlatformType.TypeSinaWeibo.rawValue,
                SSDKPlatformType.TypeQQ.rawValue,
                SSDKPlatformType.TypeWechat.rawValue,],
                             onImport: {
                                (platform : SSDKPlatformType) -> Void in
                                switch platform{
                                case SSDKPlatformType.TypeWechat:
                                    ShareSDKConnector.connectWeChat(WXApi.classForCoder())
                                case SSDKPlatformType.TypeSinaWeibo:
                                    ShareSDKConnector.connectWeibo(WeiboSDK.classForCoder())
                                case SSDKPlatformType.TypeQQ:
                                    ShareSDKConnector.connectQQ(QQApiInterface.classForCoder(), tencentOAuthClass: TencentOAuth.classForCoder())
                                default:
                                    break
                                }
            },
                onConfiguration: {(platform : SSDKPlatformType,appInfo : NSMutableDictionary!) -> Void in
                    switch platform {
                    case SSDKPlatformType.TypeSinaWeibo:
                        //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                            appInfo.SSDKSetupSinaWeiboByAppKey("3112753426",
                            appSecret : "8d827d8c5849b1d763f2d077d20e109e",
                            redirectUri : "http://www.xzzai.com",
                            authType : SSDKAuthTypeBoth)
                    break
                    case SSDKPlatformType.TypeWechat:
                        //设置微信应用信息
                        appInfo.SSDKSetupWeChatByAppId("wx88234dc1246eb81b", appSecret: "1c4d416db0008c17e01d616cb3866db7")
                    break
                    case SSDKPlatformType.TypeQQ:
                        appInfo.SSDKSetupQQByAppId("1105277654", appKey: "bQcT8M8lTt9MATbY", authType: SSDKAuthTypeBoth)
                        break
                    default:
                        break
                    }
        })
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
                    if XZClient.sharedInstance.username != XZSetting.sharedInstance[KplacemarkName]{
                      XZClient.sharedInstance.username = XZSetting.sharedInstance[KplacemarkName]
                    }
                }
            }
        }
       locationManager.stopUpdatingLocation()
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

