//
//  WeatherTabeleViewCell.swift
//  Convenient-Swift
//
//  Created by gozap on 16/3/3.
//  Copyright © 2016年 xuzhou. All rights reserved.
//

import UIKit
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l > r
    default:
        return rhs < lhs
    }
}


class Weather_titleTabeleViewCell: UITableViewCell {
    var pm25IconImageView : UIImageView?
    var pm25TiltileLabel : UILabel?
    var weatherRefreshLabel : UILabel?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.subView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.subView()
    }
    
    func subView()->Void{
        
        self.contentView.backgroundColor = XZSwiftColor.convenientBackgroundColor
        
        let pm25BgView = UIView()
        
        self.contentView.addSubview(pm25BgView)
        pm25BgView.backgroundColor = XZSwiftColor.xzGlay230
        pm25BgView.layer.cornerRadius = 15
        pm25BgView.snp_makeConstraints ({ (make) -> Void in
            make.left.equalTo(self.contentView).offset(15)
            make.centerY.equalTo(self.contentView).offset(5)
            make.width.equalTo(80)
            make.height.equalTo(25)
        });
        
        self.pm25IconImageView = UIImageView()
        self.pm25IconImageView!.layer.cornerRadius = 10
        pm25BgView.addSubview(self.pm25IconImageView!)
        self.pm25IconImageView!.snp.makeConstraints({ (make) -> Void in
            make.left.equalTo(pm25BgView).offset(3)
            make.centerY.equalTo(pm25BgView)
            make.width.height.equalTo(18)
        });
        
        self.pm25TiltileLabel = UILabel()
        self.pm25TiltileLabel?.font = XZFont2(13)
        self.pm25TiltileLabel?.textColor = XZSwiftColor.textColor
        pm25BgView.addSubview(self.pm25TiltileLabel!)
        self.pm25TiltileLabel!.snp.makeConstraints({ (make) -> Void in
            make.right.equalTo(pm25BgView).offset(-3)
            make.centerY.equalTo(pm25BgView)
        });
        
        self.weatherRefreshLabel = UILabel()
        self.weatherRefreshLabel?.font = XZFont2(13)
        self.weatherRefreshLabel?.textColor = XZSwiftColor.textColor
        self.contentView.addSubview(self.weatherRefreshLabel!)
        self.weatherRefreshLabel!.snp.makeConstraints({ (make) -> Void in
            make.right.equalTo(self.contentView).offset(-15)
            make.centerY.equalTo(self.contentView).offset(5)
        });
    }
    
    func bind(_ model:WeatherModel?)->Void{
        if model != nil{
            self.weatherRefreshLabel?.text = XZSetting.sharedInstance[KweatherTefurbishTime]! + " 更新"
            
            if Int((model?.pm25?.pm25?.pm25)!) < 50 {
                self.pm25IconImageView?.image = UIImage(named:"优_彩色")
                self.pm25TiltileLabel?.text = model!.pm25!.pm25!.pm25! + " 完美"
            }else if Int((model?.pm25?.pm25?.pm25)!) < 105{
                self.pm25IconImageView?.image = UIImage(named:"良_彩色")
                self.pm25TiltileLabel?.text = model!.pm25!.pm25!.pm25! + " 良好"
            }else if Int((model?.pm25?.pm25?.pm25)!) < 150{
                self.pm25IconImageView?.image = UIImage(named:"轻_彩色")
                self.pm25TiltileLabel?.text = model!.pm25!.pm25!.pm25! + " 轻度"
            }else if Int((model?.pm25?.pm25?.pm25)!) < 250{
                self.pm25IconImageView?.image = UIImage(named:"中_彩色")
                self.pm25TiltileLabel?.text = model!.pm25!.pm25!.pm25! + " 中度"
            }else{
                self.pm25IconImageView?.image = UIImage(named:"重_彩色")
                self.pm25TiltileLabel?.text = model!.pm25!.pm25!.pm25! + " 严重"
            }
        }
    }
}

class WeatherTabeleViewCell: UITableViewCell {
    
    var weatherIconIamgeView : UIImageView?
    var weatherLabel : UILabel?
    var weatherCurrentLabel : UILabel?
    
    var bgView : UIView?
    var oneNambelLabel : UILabel?
    var twoNambelLabel : UILabel?
    
    
    var windLabel : UILabel?
    var humidityLabel : UILabel?
    var warmPromptLabel : UILabel?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.subView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.subView()
    }
    
    func subView()->Void{
        self.contentView.backgroundColor = XZSwiftColor.convenientBackgroundColor
        self.bgView = UIView()
        self.bgView!.backgroundColor = XZSwiftColor.clear
        self.contentView.addSubview(self.bgView!)
        self.bgView!.snp.makeConstraints({ (make) -> Void in
            make.right.equalTo(self.contentView).offset(-15)
            make.top.equalTo(self.contentView).offset(10)
            make.height.equalTo(60)
            make.width.equalTo(85)
        });
        
        let xianXingGrayView = UIView()
        xianXingGrayView.layer.cornerRadius = 5;
        xianXingGrayView.backgroundColor = XZSwiftColor.xzGlay230
        self.bgView!.addSubview(xianXingGrayView)
        xianXingGrayView.snp.makeConstraints({ (make) -> Void in
            
            make.right.equalTo(self.contentView).offset(-15)
            make.top.equalTo(self.contentView).offset(10)
            make.height.equalTo(28)
            make.width.equalTo(85)
        });
        
        let xianXingWView = UIView()
        xianXingWView.backgroundColor = XZSwiftColor.white
        self.bgView!.addSubview(xianXingWView)
        xianXingWView.snp.makeConstraints({ (make) -> Void in
            make.left.right.equalTo(xianXingGrayView)
            make.top.equalTo(xianXingGrayView.snp.bottom).offset(-3)
            make.height.equalTo(33.5)
        });
        
        let xianXingbgView = UIView()
        xianXingbgView.layer.borderWidth = 1.0
        xianXingbgView.layer.cornerRadius = 3.0;
        xianXingbgView.layer.borderColor = XZSwiftColor.xzGlay230.cgColor
        xianXingbgView.backgroundColor = XZSwiftColor.clear
        self.bgView!.addSubview(xianXingbgView)
        xianXingbgView.snp.makeConstraints({ (make) -> Void in
            make.left.right.top.bottom.equalTo(self.bgView!)
        });
        
        let linView = UIView()
        linView.layer.cornerRadius = 5;
        linView.backgroundColor = XZSwiftColor.xzGlay230
        xianXingWView.addSubview(linView)
        linView.snp.makeConstraints({ (make) -> Void in
            make.center.equalTo(xianXingWView)
            make.height.equalTo(25)
            make.width.equalTo(1)
        });
        
        let xianXingLabel = UILabel()
        xianXingLabel.font = XZFont2(13)
        xianXingLabel.text = "今日限行"
        xianXingLabel.textColor = XZSwiftColor.textColor
        xianXingGrayView.addSubview(xianXingLabel)
        xianXingLabel.snp.makeConstraints({ (make) -> Void in
            make.center.equalTo(xianXingGrayView)
        });
        
        let oneView = UIView()
        oneView.backgroundColor = XZSwiftColor.clear
        xianXingWView.addSubview(oneView)
        oneView.snp.makeConstraints({ (make) -> Void in
            make.left.top.bottom.equalTo(xianXingWView)
            make.right.equalTo(xianXingWView.snp.centerX).offset(-0.5)
        });
        
        self.oneNambelLabel = UILabel()
        self.oneNambelLabel!.font = XZFont3(25)
        self.oneNambelLabel!.text = "-"
        self.oneNambelLabel!.textColor = XZSwiftColor.textColor
        oneView.addSubview(self.oneNambelLabel!)
        self.oneNambelLabel!.snp.makeConstraints({ (make) -> Void in
            make.center.equalTo(oneView)
        });
        
        let twoView = UIView()
        twoView.backgroundColor = XZSwiftColor.clear
        xianXingWView.addSubview(twoView)
        twoView.snp.makeConstraints({ (make) -> Void in
            make.right.top.bottom.equalTo(xianXingWView)
            make.left.equalTo(xianXingWView.snp.centerX).offset(0.5)
        });
        
        self.twoNambelLabel = UILabel()
        self.twoNambelLabel!.font = XZFont3(25)
        self.twoNambelLabel!.text = "-"
        self.twoNambelLabel!.textColor = XZSwiftColor.textColor
        twoView.addSubview(self.twoNambelLabel!)
        self.twoNambelLabel!.snp.makeConstraints({ (make) -> Void in
            make.center.equalTo(twoView)
        });
        
        self.weatherIconIamgeView = UIImageView()
        self.contentView.addSubview(self.weatherIconIamgeView!)
        self.weatherIconIamgeView?.snp.makeConstraints({ (make) -> Void in
            make.centerX.equalTo(self.contentView).offset(-10)
            make.top.equalTo(self.contentView).offset(30)
            make.height.equalTo(80)
            make.width.equalTo(80)
        });
        
        self.weatherLabel = UILabel()
        self.weatherLabel?.font = XZFont2(16)
        self.weatherLabel?.textColor = XZSwiftColor.textColor
        self.contentView.addSubview(self.weatherLabel!)
        self.weatherLabel?.snp.makeConstraints({ (make) -> Void in
            make.left.equalTo((self.weatherIconIamgeView?.snp.right)!).offset(10)
            make.bottom.equalTo(self.weatherIconIamgeView!)
        });
        
        
        self.weatherCurrentLabel = UILabel()
        self.weatherCurrentLabel?.font = XZFont3(65)
        
        self.contentView.addSubview(self.weatherCurrentLabel!)
        self.weatherCurrentLabel?.snp.makeConstraints({ (make) -> Void in
            make.right.equalTo((self.weatherIconIamgeView?.snp.centerX)!).offset(-15)
            make.top.equalTo((self.weatherIconIamgeView?.snp.bottom)!).offset(15)
        });
        
        self.humidityLabel = UILabel()
        self.humidityLabel?.font = XZFont2(14)
        self.humidityLabel?.textColor = XZSwiftColor.textColor
        self.contentView.addSubview(self.humidityLabel!)
        self.humidityLabel?.snp.makeConstraints({ (make) -> Void in
            make.left.equalTo((self.weatherIconIamgeView?.snp.centerX)!).offset(20)
            make.top.equalTo(self.weatherCurrentLabel!).offset(18)
        });
        
        self.windLabel = UILabel()
        self.windLabel?.font = XZFont2(14)
        self.windLabel?.textColor = XZSwiftColor.textColor
        self.contentView.addSubview(self.windLabel!)
        self.windLabel?.snp.makeConstraints({ (make) -> Void in
            make.left.equalTo(self.humidityLabel!)
            make.bottom.equalTo(self.weatherCurrentLabel!).offset(-18)
        });
        
        let warmBgView = UIView()
        warmBgView.backgroundColor = XZSwiftColor.xzGlay230
        warmBgView.layer.cornerRadius = 10
        self.contentView.addSubview(warmBgView)
        
        self.warmPromptLabel = UILabel()
        self.warmPromptLabel?.font = XZFont2(14)
        self.warmPromptLabel?.numberOfLines=0
        self.warmPromptLabel?.textColor = XZSwiftColor.textColor
        self.warmPromptLabel?.textAlignment = .center
        self.contentView.addSubview(self.warmPromptLabel!)
        self.warmPromptLabel?.snp.makeConstraints({ (make) -> Void in
            make.centerX.equalTo(self.contentView)
            make.top.equalTo((self.windLabel?.snp.bottom)!).offset(50)
            make.left.greaterThanOrEqualTo(self.contentView).offset(15)
            make.right.greaterThanOrEqualTo(self.contentView).offset(-15)
        });
        
        warmBgView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self.warmPromptLabel!).offset(0)
            make.top.equalTo(self.warmPromptLabel!).offset(-5)
            make.right.equalTo(self.warmPromptLabel!).offset(-0)
            make.bottom.equalTo(self.warmPromptLabel!).offset(5)
        }
    }
    
    func bind(_ weathermodel:WeatherModel?)->Void{
        if weathermodel != nil{
            
            let modelDic = weathermodel!.weather[0]
            let infoDic =  ((modelDic as AnyObject).object(forKey: "info"))! as! NSDictionary
            let dayArray =  (infoDic.object(forKey: "day"))! as! NSArray
            let nightArray =  (infoDic.object(forKey: "night"))! as! NSArray
            
            //当前时间戳
            let date = Date()
            let dateStamp:TimeInterval = date.timeIntervalSince1970
            let dateSt:Int = Int(dateStamp)
            
            let dfmatter = DateFormatter()
            dfmatter.dateFormat="yyyy-MM-dd HH:mm"
            //日出时间戳
            let dayStr = dfmatter.date(from: (modelDic as AnyObject).object(forKey: "date") as! String + " " + (dayArray[5] as! String))
            let dayStamp:TimeInterval = dayStr!.timeIntervalSince1970
            let daySt:Int = Int(dayStamp)
            
            //日落时间戳
            let nightStr = dfmatter.date(from: (modelDic as AnyObject).object(forKey: "date") as! String + " " + (nightArray[5] as! String))
            let nightStamp:TimeInterval = nightStr!.timeIntervalSince1970
            let nightSt:Int = Int(nightStamp)
            
            if dateSt >= daySt && dateSt <= nightSt {
                self.weatherIconIamgeView?.image = UIImage(named:"cm_weathericon_" + (dayArray[0] as! String))
                self.weatherLabel?.text = dayArray[1] as? String
            }else{
                self.weatherIconIamgeView?.image = UIImage(named:"cm_weathericon_" + (nightArray[0] as! String))
                self.weatherLabel?.text = nightArray[1] as? String
            }
            
            self.weatherCurrentLabel?.text = (weathermodel!.realtime?.weather?.temperature)!  + "°"
            self.humidityLabel?.text = "湿度  " + (weathermodel!.realtime?.weather?.humidity)! + "%"
            self.windLabel?.text = (weathermodel?.realtime!.wind!.direct!)! + "  " + weathermodel!.realtime!.wind!.power!
            self.warmPromptLabel?.text = weathermodel?.pm25!.pm25!.des
            
            if (weathermodel?.xxweihao?.Lenght > 0) {
                self.bgView?.isHidden = false
                
                let rang = weathermodel?.xxweihao?.range(of: ",")
                let oneStr = weathermodel?.xxweihao?.substring(to: (rang?.lowerBound)!)
                self.oneNambelLabel?.text = oneStr
                let twoStr = weathermodel?.xxweihao?.substring(from: (rang?.upperBound)!)
                self.twoNambelLabel?.text = twoStr
            }else{
                self.bgView?.isHidden = true
            }
        }
    }
}

class Weather_LineTabeleViewCell: UITableViewCell, UUChartDataSource {
    
    internal var weakWeatherArray : NSMutableArray = []
    
    var chartView : UUChart?
    var maxWeatherArray : NSMutableArray?
    var minWeatherArray : NSMutableArray?
    var maxWeatherStr : String?
    var minWeatherStr : String?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    func configUI()->Void{
        self.contentView.backgroundColor = XZSwiftColor.convenientBackgroundColor
        if (chartView  != nil){
            chartView?.removeFromSuperview()
            chartView = nil
        }
        chartView = UUChart.init(frame: CGRect(x: 0,y: 0,width: UIScreen.main.bounds.size.width, height: 120), dataSource: self, style: .line)
        chartView?.show(in: self.contentView)
    }
    
    func getXTitles(_ num: Int)->[AnyObject]{
        var xTitles = [String]()
        for  i in 0 ..< num {
            let str = "周\(i)"
            xTitles.append(str)
        }
        return xTitles as [AnyObject]
    }
    
    //pragma mark - @required
    func chartConfigAxisXLabel(_ chart: UUChart!) -> [Any]! {
        return self.getXTitles(5)
    }
    
    
    func chartConfigAxisYValue(_ chart: UUChart!) -> [Any]!{
        
        self.minWeatherArray = NSMutableArray()
        self.maxWeatherArray = NSMutableArray()
        for i in 0  ..< self.weakWeatherArray.count {
            let model = self.weakWeatherArray[i]
            let infoDic =  ((model as AnyObject).object(forKey: "info"))! as! NSDictionary
            let dayArray =  (infoDic.object(forKey: "day"))! as! NSArray
            let nightArray =  (infoDic.object(forKey: "night"))! as! NSArray
            self.maxWeatherArray?.add(dayArray[2])
            self.minWeatherArray?.add(nightArray[2])
            
            if i == 0{
                self.maxWeatherStr = dayArray[2] as? String
                self.minWeatherStr = nightArray[2] as? String
            }else{
                
                let maxString = NSString(string: self.maxWeatherStr!)
                
                if maxString.intValue > (dayArray[2] as AnyObject).int32Value {
                    self.maxWeatherStr = dayArray[2] as? String
                }
                
                let minString = NSString(string: self.minWeatherStr!)
                
                if minString.intValue > (nightArray[2] as AnyObject).int32Value {
                    self.minWeatherStr = nightArray[2] as? String
                }
            }
        }
        return [self.minWeatherArray!,self.maxWeatherArray!]
    }
    //pragma mark - @optional
    func chartConfigColors(_ chart: UUChart!) -> [Any]! {
        
        return [XZSwiftColor.textColor,XZSwiftColor.yellow255_194_50,UUColor.green()];
    }
    
    func chartRange(_ chart: UUChart) -> CGRange {
        
        for i in 0  ..< self.weakWeatherArray.count - 1 {
            let model = self.weakWeatherArray[i]
            
            let infoDic =  ((model as AnyObject).object(forKey: "info"))! as! NSDictionary
            let dayArray =  (infoDic.object(forKey: "day"))! as! NSArray
            let nightArray =  (infoDic.object(forKey: "night"))! as! NSArray
            
            if i == 0{
                self.maxWeatherStr = dayArray[2] as? String
                self.minWeatherStr = nightArray[2] as? String
            }else{
                
                let maxString = NSString(string: self.maxWeatherStr!)
                
                if maxString.integerValue < (dayArray[2] as AnyObject).intValue {
                    self.maxWeatherStr = dayArray[2] as? String
                }
                
                let minString = NSString(string: self.minWeatherStr!)
                
                if minString.integerValue > (nightArray[2] as AnyObject).intValue {
                    self.minWeatherStr = nightArray[2] as? String
                }
            }
            
        }
        if let maxStr = self.maxWeatherStr , let max = NSInteger(maxStr) ,let minStr = self.minWeatherStr , let min = NSInteger(minStr){
            
            return CGRangeMake(CGFloat( max + 6 ), CGFloat( min - 1 ))
        }
        return CGRangeMake(0, 0)
    }
    func showHorizonLineAtIndex(_ chart: UUChart!, showMaxMinAtIndex index: Int) -> Bool {
        return true
    }
    
    func chart(_ chart: UUChart!, showMaxMinAt index: Int) -> Bool {
        return false
    }
    
    func chart(_ chart: UUChart!, showHorizonLineAt index: Int) -> Bool {
        return true
    }
}

class Weather_TimeTabeleViewCell: UITableViewCell {
    var tiltileLabel : UILabel?
    var tiltileLabelArray :NSMutableArray?
    var weatherLabel : UILabel?
    var weatherLabelArray :NSMutableArray?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.subView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.subView()
    }
    
    func subView()->Void{
        self.contentView.backgroundColor = XZSwiftColor.convenientBackgroundColor
        
        self.tiltileLabelArray = NSMutableArray()
        self.weatherLabelArray = NSMutableArray()
        let xLabelWidth : CGFloat
        
        xLabelWidth = (UIScreen.main.bounds.size.width)/5.0;
        for i in 0 ..< 5 {
            self.tiltileLabel = UILabel.init(frame: CGRect(x: CGFloat(i) * xLabelWidth, y: self.frame.origin.y, width: xLabelWidth,height: 15))
            self.tiltileLabel?.font = XZFont2(13)
            self.tiltileLabel?.textAlignment = .center
            self.tiltileLabel?.textColor = XZSwiftColor.textColor
            self.contentView.addSubview(self.tiltileLabel!)
            self.tiltileLabelArray?.add(self.tiltileLabel!)
            
            self.weatherLabel = UILabel.init(frame: CGRect(x: CGFloat(i) * xLabelWidth, y: self.frame.origin.y + 18, width: xLabelWidth,height: 15))
            self.weatherLabel?.font = XZFont2(13)
            self.weatherLabel?.textAlignment = .center
            self.weatherLabel?.textColor = XZSwiftColor.textColor
            self.contentView.addSubview(self.weatherLabel!)
            self.weatherLabelArray?.add(self.weatherLabel!)
            
        }
    }
    func bind(_ weathermodel:WeatherModel?)->Void{
        if weathermodel != nil{
            for  i in 0 ..< 5 {
                var label =  UILabel()
                label = self.tiltileLabelArray![i] as! UILabel
                
                let modelDic = weathermodel!.weather[i]
                let str = ((modelDic as AnyObject).object(forKey: "date") as! NSString).substring(from: 5)
                
                switch (i) {
                case 0:
                    label.text = "今天";
                    break;
                case 1:
                    label.text = "明天";
                    break;
                default:
                    label.text = str;
                    break;
                }
                label = self.weatherLabelArray![i] as! UILabel
                let infoDic =  ((modelDic as AnyObject).object(forKey: "info"))! as! NSDictionary
                let dayArray =  (infoDic.object(forKey: "day"))! as! NSArray
                label.text = dayArray[1] as? String
            }
        }
    }
}

class Weather_WeekTabeleViewCell: Weather_TimeTabeleViewCell {
    func binde(_ weathermodel:WeatherModel?)->Void{
        if weathermodel != nil{
            for  i in 0 ..< 5{
                var label =  UILabel()
                label = self.weatherLabelArray![i] as! UILabel
                
                let model = weathermodel?.weather[i]
                let infoDic =  ((model! as AnyObject).object(forKey: "info"))! as! NSDictionary
                let nightArray =  (infoDic.object(forKey: "night"))! as! NSArray
                
                label.text = "周" + ((model! as AnyObject).object(forKey: "week") as? String)!
                
                label = self.tiltileLabelArray![i] as! UILabel
                label.text = nightArray[1] as? String
            }
        }
    }
}















