//
//  ShareView.swift
//  Convenient-Swift
//
//  Created by gozap on 16/3/18.
//  Copyright © 2016年 xuzhou. All rights reserved.
//

import UIKit
import SVProgressHUD

class ShareView: UIView {
    
    var  content: String?
    var  image: UIImage?
    var  title: String?
    var  url: String?
    var  descriptions: String?
    
    var backGroundView: UIView?
    var panelView: UIView?

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.sebView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.sebView()
    }
    
    func sebView(){
        
        self.frame = CGRectMake(0,0, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height)
        
        self.backGroundView = UIView()
        self.backGroundView?.backgroundColor = XZSwiftColor.blackColor()
        self.addSubview(self.backGroundView!)
        self.backGroundView?.alpha = 0.0
        
        let groundViewtap = UITapGestureRecognizer.init(target: self, action: #selector(ShareView.cancelClick))
        self.backGroundView?.addGestureRecognizer(groundViewtap)
        self.backGroundView?.snp_makeConstraints(closure: { (make) -> Void in
            make.top.left.right.bottom.equalTo(self)
        });
        
        self.panelView = UIView.init(frame: CGRectMake(0, UIScreen.mainScreen().bounds.size.height, UIScreen.mainScreen().bounds.size.width, 220))
        self.panelView?.backgroundColor = XZSwiftColor.whiteColor()
        self.panelView!.layer.cornerRadius = 5
        self.panelView?.layer.masksToBounds = true
        self.addSubview(self.panelView!)
        
        let titleLabel = UILabel()
        titleLabel.text = "亲  关心一下身边的人"
        titleLabel.font = XZFont(16)
        titleLabel.textColor = XZSwiftColor.xzGlay142
        self.panelView?.addSubview(titleLabel)
        titleLabel.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(self.panelView!)
            make.top.equalTo(self.panelView!).offset(20)
        }
        
        let btnTitleArray = ["微信好友","微信朋友圈","新浪微博","QQ好友","QZone","复制天气"]
        let btnIamgeArray = ["fenxiang_weixin","fenxiang_pengyouquan","fenxiang_weibo","fenxiang_QQ","fenxiang_kongjian","fenxiang_fuzhi"]
        
        let btnActionArray = ["WXShare","WXPShare","SinaWeiBoShare","QQShare","QZoneShare","didChangeCapyForFriend"]
        

        let btnArray = NSMutableArray()
        
        for i in 0  ..< 6  {
            let aswitch = i % 3
            let ah = i / 3
            let panel = UIView()
            
            self.panelView?.addSubview(panel)
            
            panel.snp_makeConstraints(closure: { (make) -> Void in
                make.width.equalTo(UIScreen.mainScreen().bounds.size.width/3.0)
                make.height.equalTo(106)
                make.top.equalTo(titleLabel.snp_bottom).offset(ah * 75)
                
                if aswitch == 0{
                    make.left.equalTo(self.panelView!)
                }
                
                else if aswitch == 1 {
                    make.centerX.equalTo(self.panelView!)
                }else{
                    make.right.equalTo(self.panelView!)
                }
            });
            let btn = ShareBaseView()
            btn.label?.text = btnTitleArray[i]
            btn.label?.font = XZFont2(12)
            btn.btn?.setImage(UIImage(named: btnIamgeArray[i]), forState:.Normal)
            btn.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action:Selector(btnActionArray[i])))
            panel.addSubview(btn)
            
            btn.snp_makeConstraints(closure: { (make) -> Void in
                make.width.equalTo(70)
                make.height.equalTo(75)
                make.centerY.equalTo(panel)
                if aswitch == 0{
                    make.centerX.equalTo(panel).multipliedBy(1.25)
                }else if aswitch == 1 {
                    make.centerX.equalTo(panel)
                }else{
                    make.centerX.equalTo(panel).multipliedBy(0.75)
                }
            });
            btnArray.addObject(btn)
        }
    }
    //复制
    func didChangeCapyForFriend(){
        let paseteboard = UIPasteboard.generalPasteboard()
        if (self.content == nil) {
            self.content = "想容易，就用易"
        }
        paseteboard.string = self.content
        SVProgressHUD.showSuccessWithStatus("复制成功")
        self.removeFromWindowAnmated(true)
    }
    
    func WXShare(){
       self.share(ShareTypeWeixiSession)
    }
    func WXPShare(){
         self.share(ShareTypeWeixiTimeline)
    }
    func SinaWeiBoShare(){
         self.share(ShareTypeSinaWeibo)
    }
    func QQShare(){
         self.share(ShareTypeQQ)
    }
    func QZoneShare(){
         self.share(ShareTypeQQSpace)
    }
    func share(type: ShareType) -> Void{
        self.removeFromWindowAnmated(true)
        if type == ShareTypeSMS{
            
        }
        var publishContent: ISSContent
        
        if (self.content == nil) {
            self.content = "想容易，就用易"
        }
        if (self.url == nil) {
             self.url = "www.xzzai.com"
        }
        
        if type == ShareTypeWeixiTimeline || type == ShareTypeQQ {
 
             publishContent = ShareSDK.content(self.content! as String,
                defaultContent: self.content! as String,
                image:ShareSDK.pngImageWithImage(self.image),
                title: self.title! as String,
                url: self.url! as String,
                description: self.content! as String,
                mediaType:SSPublishContentMediaTypeNews)
        }else if type == ShareTypeWeixiSession{
             publishContent = ShareSDK.content(self.content! as String,
                defaultContent: self.content! as String,
                image:ShareSDK.pngImageWithImage(self.image),
                title:"用易",
                url: self.url! as String,
                description: self.content! as String,
                mediaType:SSPublishContentMediaTypeNews)
        }else{
            publishContent = ShareSDK.content(self.content! as String,
                defaultContent: "用易",
                image:ShareSDK.pngImageWithImage(self.image),
                title:"用易分享",
                url: self.url! as String,
                description: self.content! as String,
                mediaType:SSPublishContentMediaTypeText)
        }
        ShareSDK.clientShareContent(publishContent, type: type, statusBarTips: true) { (type:ShareType,state:SSResponseState,statusInfo:ISSPlatformShareInfo!,error:ICMErrorInfo!,end:Bool) -> Void in
            if state == SSResponseStateSuccess{
                print("分享成功")
            }else if state == SSResponseStateFail {
                print(error.errorCode())
                print(error.errorDescription())
            }
        }
    }
    
    func cancelClick(){
        self.removeFromWindowAnmated(true)
    }
    
    func showInWindowAnimated(animated: Bool) ->Void{
        let app = UIApplication.sharedApplication().delegate  as! AppDelegate
        app.window?.addSubview(self)
        if animated {
            var frames:CGRect = (self.panelView?.frame)!
            frames.origin.y = UIScreen.mainScreen().bounds.size.height - frames.size.height;
            UIView.animateWithDuration(0.5, delay: 0, options: .CurveEaseInOut, animations: { () -> Void in
                self.backGroundView?.alpha = 0.3
                self.panelView?.frame = frames
                }, completion: nil)
        }
    }
    
    func removeFromWindowAnmated(animated: Bool) -> Void{
        var frame = self.panelView?.frame
        frame?.origin.y  = UIScreen.mainScreen().bounds.size.height
        if animated {
            UIView.animateWithDuration(0.5, delay: 0, options: .CurveEaseInOut, animations: { () -> Void in
                self.backGroundView?.alpha = 0
                self.panelView?.frame = frame!
                }, completion: { (finished) -> Void in
                    if finished {
                        self.removeFromSuperview()
                    }
            })
        }else{
            self.backGroundView?.alpha = 0
            self.panelView?.frame = frame!
        }
    }
}

class ShareBaseView: UIView {
    var btn: UIButton?
    var label: UILabel?
    
    var buttonIconArray: NSArray?
    var selectedIndex: NSInteger?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.sebView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.sebView()
    }
    
    func sebView(){
        self.btn = UIButton()
        self.btn?.titleLabel?.font = XZFont2(10)
        self.btn?.tintColor = XZSwiftColor.xzGlay142
        self.btn?.userInteractionEnabled = false
        self.addSubview(self.btn!)
        
        self.label = UILabel()
        self.label?.textColor = XZSwiftColor.xzGlay142
        self.label?.font = XZFont2(10)
        self.label?.text = "微博"
        self.addSubview(self.label!)
    
        self.btn?.snp_makeConstraints(closure: { (make) -> Void in
            make.top.left.right.equalTo(self)
            make.height.equalTo((self.btn?.snp_width)!)
        });
        
        self.label?.snp_makeConstraints(closure: { (make) -> Void in
            make.centerX.equalTo(self)
            make.top.equalTo((self.btn?.snp_bottom)!).offset(-15)
        });
    }
    
    func setSelectedIndex(var selectedIndex: NSInteger, animated: Bool) ->Void{
        
        if selectedIndex < 0 {
            selectedIndex = 0
        }else if  selectedIndex > (self.buttonIconArray?.count)! - 1{
            selectedIndex = (self.buttonIconArray?.count)! - 1
        }
        
        self.selectedIndex = selectedIndex
        
        if animated {
         
            UIView.animateWithDuration(0.15, delay: 0, options: .CurveEaseIn, animations: { () -> Void in
                self.transform = CGAffineTransformMakeScale(1, 0.01)
            }, completion: { (finished) -> Void in
                if let image = self.buttonIconArray?.objectAtIndex(selectedIndex){
                    self.btn?.setImage(image as? UIImage, forState: .Normal)
                    UIView.animateWithDuration(0.15, delay: 0, options: .CurveEaseOut, animations: { () -> Void in
                        self.transform = CGAffineTransformMakeScale(1, 1)
                    }, completion: nil)
                }
            })
        }else{
            if let image = self.buttonIconArray?.objectAtIndex(selectedIndex){
                self.btn?.setImage(image as? UIImage, forState: .Normal)
            }
        }
    }
}