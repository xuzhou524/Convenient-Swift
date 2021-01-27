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
        
        self.frame = CGRect(x: 0,y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        
        self.backGroundView = UIView()
        self.backGroundView?.backgroundColor = XZSwiftColor.black
        self.addSubview(self.backGroundView!)
        self.backGroundView?.alpha = 0.0
        
        let groundViewtap = UITapGestureRecognizer.init(target: self, action: #selector(ShareView.cancelClick))
        self.backGroundView?.addGestureRecognizer(groundViewtap)
        self.backGroundView?.snp.makeConstraints({ (make) -> Void in
            make.top.left.right.bottom.equalTo(self)
        });
        
        self.panelView = UIView.init(frame: CGRect(x: 0, y: UIScreen.main.bounds.size.height, width: UIScreen.main.bounds.size.width, height: 220))
        self.panelView?.backgroundColor = XZSwiftColor.white
        self.panelView!.layer.cornerRadius = 5
        self.panelView?.layer.masksToBounds = true
        self.addSubview(self.panelView!)
        
        let titleLabel = UILabel()
        titleLabel.text = "亲  关心一下身边的人"
        titleLabel.font = XZFont(16)
        titleLabel.textColor = XZSwiftColor.xzGlay142
        self.panelView?.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) -> Void in
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
            
            panel.snp.makeConstraints({ (make) -> Void in
                make.width.equalTo(UIScreen.main.bounds.size.width/3.0)
                make.height.equalTo(106)
                make.top.equalTo(titleLabel.snp.bottom).offset(ah * 75)
                
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
            btn.btn?.setImage(UIImage(named: btnIamgeArray[i]), for:UIControl.State())
            btn.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action:Selector(btnActionArray[i])))
            panel.addSubview(btn)
            
            btn.snp.makeConstraints({ (make) -> Void in
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
            btnArray.add(btn)
        }
    }
    //复制
    func didChangeCapyForFriend(){
        let paseteboard = UIPasteboard.general
        if (self.content == nil) {
            self.content = "想容易，就用易"
        }
        paseteboard.string = self.content
        SVProgressHUD.showSuccess(withStatus: "复制成功")
        self.removeFromWindowAnmated(true)
    }
    
    func WXShare(){
       self.share(.subTypeWechatSession)
    }
    func WXPShare(){
         self.share(.subTypeWechatTimeline)
    }
    func SinaWeiBoShare(){
         self.share(.typeSinaWeibo)
    }
    func QQShare(){
         self.share(.subTypeQQFriend)
    }
    func QZoneShare(){
         self.share(.subTypeQZone)
    }
    func share(_ type: SSDKPlatformType) -> Void{
        self.removeFromWindowAnmated(true)
        
        let shareParames = NSMutableDictionary()
        if (self.content == nil) {
            self.content = "想容易，就用易"
        }
        if (self.url == nil) {
             self.url = "https://itunes.apple.com/cn/app/id1106215431"
        }
        
        if type == .subTypeWechatTimeline{
            shareParames.ssdkSetupWeChatParams(byText: self.content! as String, title: self.content! as String, url: URL(string:self.url! as String), thumbImage: self.image, image: nil, musicFileURL: nil, extInfo: nil, fileData: nil, emoticonData: nil, type: .auto, forPlatformSubType: .subTypeWechatTimeline)
        } else{
            shareParames.ssdkSetupShareParams(byText: self.content! as String,
                                                    images : self.image,
                                                    url : URL(string:self.url! as String),
                                                    title : self.title! as String,
                                                    type : SSDKContentType.auto)
        }

//        ShareSDK.share(type, parameters: shareParames) { (state : SSDKResponseState, userData : [AnyHashable: Any]!, contentEntity :SSDKContentEntity!, error : NSError!) -> Void in
//            switch state{
//            case SSDKResponseState.success:
//                if type == .typeSinaWeibo{
//                    SVProgressHUD.showSuccess(withStatus: "新浪微博分享成功");
//                }
//            break
//            case SSDKResponseState.fail: break
//            case SSDKResponseState.cancel: break
//            default:
//                break
//            }
//        }
    }
    
    @objc func cancelClick(){
        self.removeFromWindowAnmated(true)
    }
    
    func showInWindowAnimated(_ animated: Bool) ->Void{
        let app = UIApplication.shared.delegate  as! AppDelegate
        app.window?.addSubview(self)
        if animated {
            var frames:CGRect = (self.panelView?.frame)!
            frames.origin.y = UIScreen.main.bounds.size.height - frames.size.height;
            UIView.animate(withDuration: 0.5, delay: 0, options: UIView.AnimationOptions(), animations: { () -> Void in
                self.backGroundView?.alpha = 0.3
                self.panelView?.frame = frames
                }, completion: nil)
        }
    }
    
    func removeFromWindowAnmated(_ animated: Bool) -> Void{
        var frame = self.panelView?.frame
        frame?.origin.y  = UIScreen.main.bounds.size.height
        if animated {
            UIView.animate(withDuration: 0.5, delay: 0, options: UIView.AnimationOptions(), animations: { () -> Void in
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
        self.btn?.isUserInteractionEnabled = false
        self.addSubview(self.btn!)
        
        self.label = UILabel()
        self.label?.textColor = XZSwiftColor.xzGlay142
        self.label?.font = XZFont2(10)
        self.label?.text = "微博"
        self.addSubview(self.label!)
    
        self.btn?.snp.makeConstraints({ (make) -> Void in
            make.top.left.right.equalTo(self)
            make.height.equalTo((self.btn?.snp.width)!)
        });
        
        self.label?.snp.makeConstraints({ (make) -> Void in
            make.centerX.equalTo(self)
            make.top.equalTo((self.btn?.snp.bottom)!).offset(-8)
        });
    }
    
    func setSelectedIndex(_ selectedIndex: NSInteger, animated: Bool) ->Void{
        var selectedIndex = selectedIndex
        
        if selectedIndex < 0 {
            selectedIndex = 0
        }else if  selectedIndex > (self.buttonIconArray?.count)! - 1{
            selectedIndex = (self.buttonIconArray?.count)! - 1
        }
        
        self.selectedIndex = selectedIndex
        
        if animated {
         
            UIView.animate(withDuration: 0.15, delay: 0, options: .curveEaseIn, animations: { () -> Void in
                self.transform = CGAffineTransform(scaleX: 1, y: 0.01)
            }, completion: { (finished) -> Void in
                if let image = self.buttonIconArray?.object(at: selectedIndex){
                    self.btn?.setImage(image as? UIImage, for: UIControl.State())
                    UIView.animate(withDuration: 0.15, delay: 0, options: .curveEaseOut, animations: { () -> Void in
                        self.transform = CGAffineTransform(scaleX: 1, y: 1)
                    }, completion: nil)
                }
            })
        }else{
            if let image = self.buttonIconArray?.object(at: selectedIndex){
                self.btn?.setImage(image as? UIImage, for: UIControl.State())
            }
        }
    }
}
