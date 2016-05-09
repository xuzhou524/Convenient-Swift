//
//  WeatherTabeleViewCell.swift
//  Convenient-Swift
//
//  Created by gozap on 16/3/3.
//  Copyright © 2016年 xuzhou. All rights reserved.
//

import UIKit

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
        pm25BgView.snp_makeConstraints (closure: { (make) -> Void in
            make.left.equalTo(self.contentView).offset(15)
            make.centerY.equalTo(self.contentView).offset(5)
            make.width.equalTo(80)
            make.height.equalTo(25)
         });
        
        self.pm25IconImageView = UIImageView()
        self.pm25IconImageView!.layer.cornerRadius = 10
        pm25BgView.addSubview(self.pm25IconImageView!)
        self.pm25IconImageView!.snp_makeConstraints(closure: { (make) -> Void in
            make.left.equalTo(pm25BgView).offset(3)
            make.centerY.equalTo(pm25BgView)
            make.width.height.equalTo(18)
        });
        
        self.pm25TiltileLabel = UILabel()
        self.pm25TiltileLabel?.font = XZFont2(13)
        self.pm25TiltileLabel?.textColor = XZSwiftColor.textColor
        pm25BgView.addSubview(self.pm25TiltileLabel!)
        self.pm25TiltileLabel!.snp_makeConstraints(closure: { (make) -> Void in
            make.right.equalTo(pm25BgView).offset(-3)
            make.centerY.equalTo(pm25BgView)
         });
        
        self.weatherRefreshLabel = UILabel()
        self.weatherRefreshLabel?.font = XZFont2(13)
        self.weatherRefreshLabel?.textColor = XZSwiftColor.textColor
        self.contentView.addSubview(self.weatherRefreshLabel!)
        self.weatherRefreshLabel!.snp_makeConstraints(closure: { (make) -> Void in
            make.right.equalTo(self.contentView).offset(-15)
            make.centerY.equalTo(self.contentView).offset(5)
         });
    }
    
    func bind(model:WeatherModel?)->Void{
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
        self.bgView?.hidden = true
        self.bgView!.backgroundColor = XZSwiftColor.clearColor()
        self.contentView.addSubview(self.bgView!)
        self.bgView!.snp_makeConstraints(closure: { (make) -> Void in
            make.right.equalTo(self.contentView).offset(-15)
            make.top.equalTo(self.contentView).offset(10)
            make.height.equalTo(60)
            make.width.equalTo(85)
        });
        
        let xianXingGrayView = UIView()
        xianXingGrayView.layer.cornerRadius = 5;
        xianXingGrayView.backgroundColor = XZSwiftColor.xzGlay230
        self.bgView!.addSubview(xianXingGrayView)
        xianXingGrayView.snp_makeConstraints(closure: { (make) -> Void in
            
            make.right.equalTo(self.contentView).offset(-15)
            make.top.equalTo(self.contentView).offset(10)
            make.height.equalTo(28)
            make.width.equalTo(85)
        });
        
        let xianXingWView = UIView()
        xianXingWView.backgroundColor = XZSwiftColor.whiteColor()
        self.bgView!.addSubview(xianXingWView)
        xianXingWView.snp_makeConstraints(closure: { (make) -> Void in
            make.left.right.equalTo(xianXingGrayView)
            make.top.equalTo(xianXingGrayView.snp_bottom).offset(-3)
            make.height.equalTo(33.5)
        });
        
        let xianXingbgView = UIView()
        xianXingbgView.layer.borderWidth = 1.0
        xianXingbgView.layer.cornerRadius = 3.0;
        xianXingbgView.layer.borderColor = XZSwiftColor.xzGlay230.CGColor
        xianXingbgView.backgroundColor = XZSwiftColor.clearColor()
        self.bgView!.addSubview(xianXingbgView)
        xianXingbgView.snp_makeConstraints(closure: { (make) -> Void in
            make.left.right.top.bottom.equalTo(self.bgView!)
        });
        
        let linView = UIView()
        linView.layer.cornerRadius = 5;
        linView.backgroundColor = XZSwiftColor.xzGlay230
        xianXingWView.addSubview(linView)
        linView.snp_makeConstraints(closure: { (make) -> Void in
            make.center.equalTo(xianXingWView)
            make.height.equalTo(25)
            make.width.equalTo(1)
        });
        
        let xianXingLabel = UILabel()
        xianXingLabel.font = XZFont2(13)
        xianXingLabel.text = "今日限行"
        xianXingLabel.textColor = XZSwiftColor.textColor
        xianXingGrayView.addSubview(xianXingLabel)
        xianXingLabel.snp_makeConstraints(closure: { (make) -> Void in
            make.center.equalTo(xianXingGrayView)
        });
        
        let oneView = UIView()
        oneView.backgroundColor = XZSwiftColor.clearColor()
        xianXingWView.addSubview(oneView)
        oneView.snp_makeConstraints(closure: { (make) -> Void in
            make.left.top.bottom.equalTo(xianXingWView)
            make.right.equalTo(xianXingWView.snp_centerX).offset(-0.5)
        });
        
        self.oneNambelLabel = UILabel()
        self.oneNambelLabel!.font = XZFont3(25)
        self.oneNambelLabel!.text = "0"
        self.oneNambelLabel!.textColor = XZSwiftColor.textColor
        oneView.addSubview(self.oneNambelLabel!)
        self.oneNambelLabel!.snp_makeConstraints(closure: { (make) -> Void in
            make.center.equalTo(oneView)
        });
        
        let twoView = UIView()
        twoView.backgroundColor = XZSwiftColor.clearColor()
        xianXingWView.addSubview(twoView)
        twoView.snp_makeConstraints(closure: { (make) -> Void in
            make.right.top.bottom.equalTo(xianXingWView)
            make.left.equalTo(xianXingWView.snp_centerX).offset(0.5)
        });
        
        self.twoNambelLabel = UILabel()
        self.twoNambelLabel!.font = XZFont3(25)
        self.twoNambelLabel!.text = "1"
        self.twoNambelLabel!.textColor = XZSwiftColor.textColor
        twoView.addSubview(self.twoNambelLabel!)
        self.twoNambelLabel!.snp_makeConstraints(closure: { (make) -> Void in
            make.center.equalTo(twoView)
        });
    
        self.weatherIconIamgeView = UIImageView()
        self.contentView.addSubview(self.weatherIconIamgeView!)
        self.weatherIconIamgeView?.snp_makeConstraints(closure: { (make) -> Void in
            make.centerX.equalTo(self.contentView).offset(-10)
            make.top.equalTo(self.contentView).offset(30)
            make.height.equalTo(80)
            make.width.equalTo(80)
        });
        
        self.weatherLabel = UILabel()
        self.weatherLabel?.font = XZFont2(16)
        self.weatherLabel?.textColor = XZSwiftColor.textColor
        self.contentView.addSubview(self.weatherLabel!)
        self.weatherLabel?.snp_makeConstraints(closure: { (make) -> Void in
            make.left.equalTo((self.weatherIconIamgeView?.snp_right)!).offset(10)
            make.bottom.equalTo(self.weatherIconIamgeView!)
        });
        
        
        self.weatherCurrentLabel = UILabel()
        self.weatherCurrentLabel?.font = XZFont3(65)
      
        self.contentView.addSubview(self.weatherCurrentLabel!)
        self.weatherCurrentLabel?.snp_makeConstraints(closure: { (make) -> Void in
            make.right.equalTo((self.weatherIconIamgeView?.snp_centerX)!).offset(-15)
            make.top.equalTo((self.weatherIconIamgeView?.snp_bottom)!).offset(15)
        });
        
        self.humidityLabel = UILabel()
        self.humidityLabel?.font = XZFont2(14)
        self.humidityLabel?.textColor = XZSwiftColor.textColor
        self.contentView.addSubview(self.humidityLabel!)
        self.humidityLabel?.snp_makeConstraints(closure: { (make) -> Void in
            make.left.equalTo((self.weatherIconIamgeView?.snp_centerX)!).offset(20)
            make.top.equalTo(self.weatherCurrentLabel!).offset(18)
        });
        
        self.windLabel = UILabel()
        self.windLabel?.font = XZFont2(14)
        self.windLabel?.textColor = XZSwiftColor.textColor
        self.contentView.addSubview(self.windLabel!)
        self.windLabel?.snp_makeConstraints(closure: { (make) -> Void in
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
        self.warmPromptLabel?.textAlignment = .Center
        self.contentView.addSubview(self.warmPromptLabel!)
        self.warmPromptLabel?.snp_makeConstraints(closure: { (make) -> Void in
            make.centerX.equalTo(self.contentView)
            make.top.equalTo((self.windLabel?.snp_bottom)!).offset(50)
            make.left.greaterThanOrEqualTo(self.contentView).offset(15)
            make.right.greaterThanOrEqualTo(self.contentView).offset(-15)
        });
        
        warmBgView.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.warmPromptLabel!).offset(0)
            make.top.equalTo(self.warmPromptLabel!).offset(-5)
            make.right.equalTo(self.warmPromptLabel!).offset(-0)
            make.bottom.equalTo(self.warmPromptLabel!).offset(5)
        }
    }
    
    func bind(weathermodel:WeatherModel?)->Void{
        if weathermodel != nil{

            let modelDic = weathermodel!.weather[0]
            let infoDic =  (modelDic.objectForKey("info"))! as! NSMutableDictionary
            let dayArray =  (infoDic.objectForKey("day"))! as! NSMutableArray
            let nightArray =  (infoDic.objectForKey("night"))! as! NSMutableArray
            
            //当前时间戳
            let date = NSDate()
            let dateStamp:NSTimeInterval = date.timeIntervalSince1970
            let dateSt:Int = Int(dateStamp)
 
            let dfmatter = NSDateFormatter()
            dfmatter.dateFormat="yyyy-MM-dd HH:mm"
            //日出时间戳
            let dayStr = dfmatter.dateFromString(modelDic.objectForKey("date") as! String + " " + (dayArray[5] as! String))
            let dayStamp:NSTimeInterval = dayStr!.timeIntervalSince1970
            let daySt:Int = Int(dayStamp)
  
            //日落时间戳
            let nightStr = dfmatter.dateFromString(modelDic.objectForKey("date") as! String + " " + (nightArray[5] as! String))
            let nightStamp:NSTimeInterval = nightStr!.timeIntervalSince1970
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
            
            if ((weathermodel?.xxweihao) != nil) {
                self.bgView?.hidden = false
                let oneStr = weathermodel?.xxweihao![0] as! NSNumber
                self.oneNambelLabel?.text = oneStr.stringValue
                let twoStr = weathermodel?.xxweihao![1] as! NSNumber
                self.twoNambelLabel?.text = twoStr.stringValue
            }else{
               self.bgView?.hidden = true
            }
        }
    }
}

class Weather_LineTabeleViewCell: UITableViewCell ,UUChartDataSource{
    
    internal var weakWeatherArray =  []
    
    var chartView : UUChart?
    var maxWeatherArray : NSMutableArray?
    var minWeatherArray : NSMutableArray?
    var maxWeatherStr : String?
    var minWeatherStr : String?

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configUI()->Void{
        self.contentView.backgroundColor = XZSwiftColor.convenientBackgroundColor
        if (chartView  != nil){
            chartView?.removeFromSuperview()
            chartView = nil
        }
        chartView = UUChart.init(frame: CGRectMake(0,0,UIScreen.mainScreen().bounds.size.width, 120), dataSource: self, style: .Line)
        chartView?.showInView(self.contentView)
    }
    
    func getXTitles(num: Int?)->[AnyObject]{
        var xTitles = [String]()
        for var i = 0 ;i < num ; i++ {
            let str = "周\(i)"
            xTitles.append(str)
        }
        return xTitles
    }
    
   //pragma mark - @required
    func chartConfigAxisXLabel(chart: UUChart) -> [AnyObject] {
        return self.getXTitles(6)
    }
    
    func chartConfigAxisYValue(chart: UUChart) -> [AnyObject] {
        
        self.minWeatherArray = NSMutableArray()
        self.maxWeatherArray = NSMutableArray()
        for i in 0  ..< self.weakWeatherArray.count - 1 {
            let model = self.weakWeatherArray[i]
            let infoDic =  (model.objectForKey("info"))! as! NSMutableDictionary
            let dayArray =  (infoDic.objectForKey("day"))! as! NSMutableArray
            let nightArray =  (infoDic.objectForKey("night"))! as! NSMutableArray
            self.maxWeatherArray?.addObject(dayArray[2])
            self.minWeatherArray?.addObject(nightArray[2])
            
            if i == 0{
                self.maxWeatherStr = dayArray[2] as? String
                self.minWeatherStr = nightArray[2] as? String
            }else{

                let maxString = NSString(string: self.maxWeatherStr!)
                
                if maxString.intValue > dayArray[2].intValue {
                    self.maxWeatherStr = dayArray[2] as? String
                }

                let minString = NSString(string: self.minWeatherStr!)
                
                if minString.intValue > nightArray[2].intValue {
                    self.minWeatherStr = nightArray[2] as? String
                }
            }
        }
        return [self.minWeatherArray!,self.maxWeatherArray!]
    }
    //pragma mark - @optional
     func chartConfigColors(chart: UUChart) ->  [AnyObject] {

        return [XZSwiftColor.textColor,XZSwiftColor.yellow255_194_50,UUColor.green()];
    }
    
    func chartRange(chart: UUChart) -> CGRange {
    
        for i in 0  ..< self.weakWeatherArray.count - 1 {
            let model = self.weakWeatherArray[i]
            
            let infoDic =  (model.objectForKey("info"))! as! NSMutableDictionary
            let dayArray =  (infoDic.objectForKey("day"))! as! NSMutableArray
            let nightArray =  (infoDic.objectForKey("night"))! as! NSMutableArray
            
            if i == 0{
                self.maxWeatherStr = dayArray[2] as? String
                self.minWeatherStr = nightArray[2] as? String
            }else{
                
                let maxString = NSString(string: self.maxWeatherStr!)
                
                if maxString.integerValue < dayArray[2].integerValue {
                    self.maxWeatherStr = dayArray[2] as? String
                }
                
                let minString = NSString(string: self.minWeatherStr!)
                
                if minString.integerValue > nightArray[2].integerValue {
                    self.minWeatherStr = nightArray[2] as? String
                }
            }
            
        }
        if let maxStr = self.maxWeatherStr , let max = NSInteger(maxStr) ,let minStr = self.minWeatherStr , let min = NSInteger(minStr){
            
            return CGRangeMake(CGFloat( max + 6 ), CGFloat( min - 1 ))
        }
        return CGRangeMake(0, 0)
    }
    func showHorizonLineAtIndex(chart: UUChart!, showMaxMinAtIndex index: Int) -> Bool {
        return true
    }

    func chart(chart: UUChart!, showMaxMinAtIndex index: Int) -> Bool {
        return false
    }
    
    func chart(chart: UUChart!, showHorizonLineAtIndex index: Int) -> Bool {
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
        
        xLabelWidth = (UIScreen.mainScreen().bounds.size.width)/6.0;
        for i in 0 ..< 6 {
            self.tiltileLabel = UILabel.init(frame: CGRectMake(CGFloat(i) * xLabelWidth, self.frame.origin.y, xLabelWidth,15))
            self.tiltileLabel?.font = XZFont2(13)
            self.tiltileLabel?.textAlignment = .Center
            self.tiltileLabel?.textColor = XZSwiftColor.textColor
            self.contentView.addSubview(self.tiltileLabel!)
            self.tiltileLabelArray?.addObject(self.tiltileLabel!)
            
            self.weatherLabel = UILabel.init(frame: CGRectMake(CGFloat(i) * xLabelWidth, self.frame.origin.y + 18, xLabelWidth,15))
            self.weatherLabel?.font = XZFont2(13)
            self.weatherLabel?.textAlignment = .Center
            self.weatherLabel?.textColor = XZSwiftColor.textColor
            self.contentView.addSubview(self.weatherLabel!)
            self.weatherLabelArray?.addObject(self.weatherLabel!)

        }
    }
    func bind(weathermodel:WeatherModel?)->Void{
        if weathermodel != nil{
            for var i = 0; i < self.tiltileLabelArray?.count; i++ {
                var label =  UILabel()
                label = self.tiltileLabelArray![i] as! UILabel
                
                let model = weathermodel?.weather[i]

                let str = (model?.objectForKey("date") as! NSString).substringFromIndex(5)
                
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
                let infoDic =  (model?.objectForKey("info"))! as! NSMutableDictionary
                let dayArray =  (infoDic.objectForKey("day"))! as! NSMutableArray
                label.text = dayArray[1] as? String
            }
        }
    }
}

class Weather_WeekTabeleViewCell: Weather_TimeTabeleViewCell {
  func binde(weathermodel:WeatherModel?)->Void{
        if weathermodel != nil{
            for var i = 0; i < self.weatherLabelArray?.count; i++ {
                var label =  UILabel()
                label = self.weatherLabelArray![i] as! UILabel
                
                let model = weathermodel?.weather[i]
                let infoDic =  (model!.objectForKey("info"))! as! NSMutableDictionary
                let nightArray =  (infoDic.objectForKey("night"))! as! NSMutableArray
                
                label.text = "周" + (model!.objectForKey("week") as? String)!
                
                label = self.tiltileLabelArray![i] as! UILabel
                label.text = nightArray[1] as? String
            }
        }
    }
}















