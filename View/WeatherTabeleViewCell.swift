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
        
        let pm25BgView = UIView()
        
        self.contentView.addSubview(pm25BgView)
        pm25BgView.backgroundColor = XZSwiftColor.convenientBackgroundColor
        pm25BgView.layer.cornerRadius = 15
        pm25BgView.snp_makeConstraints (closure: { (make) -> Void in
            make.left.equalTo(self.contentView).offset(15)
            make.centerY.equalTo(self.contentView).offset(5)
            make.width.equalTo(90)
            make.height.equalTo(30)
         });
        
        self.pm25IconImageView = UIImageView()
        self.pm25IconImageView!.backgroundColor = UIColor.redColor()
        self.pm25IconImageView!.layer.cornerRadius = 10
        pm25BgView.addSubview(self.pm25IconImageView!)
        self.pm25IconImageView!.snp_makeConstraints(closure: { (make) -> Void in
            make.left.equalTo(pm25BgView).offset(3)
            make.centerY.equalTo(pm25BgView)
            make.width.height.equalTo(20)
        });
        
        self.pm25TiltileLabel = UILabel()
        self.pm25TiltileLabel!.text = "330  严重"
        self.pm25TiltileLabel?.font = XZFont2(12)
        pm25BgView.addSubview(self.pm25TiltileLabel!)
        self.pm25TiltileLabel!.snp_makeConstraints(closure: { (make) -> Void in
            make.right.equalTo(pm25BgView).offset(-3)
            make.centerY.equalTo(pm25BgView)
         });
        
        self.weatherRefreshLabel = UILabel()
        self.weatherRefreshLabel!.text = "03-03 09:00 发布"
        self.weatherRefreshLabel?.font = XZFont2(12)
        self.contentView.addSubview(self.weatherRefreshLabel!)
        self.weatherRefreshLabel!.snp_makeConstraints(closure: { (make) -> Void in
            make.right.equalTo(self.contentView).offset(-15)
            make.centerY.equalTo(self.contentView).offset(5)
         });
    }
}

class WeatherTabeleViewCell: UITableViewCell {
    
    var weatherIconIamgeView : UIImageView?
    var weatherLabel : UILabel?
    var weatherCurrentLabel : UILabel?
    
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
        
        self.weatherIconIamgeView = UIImageView()
        self.weatherIconIamgeView?.backgroundColor = XZSwiftColor.convenientBackgroundColor
        self.contentView.addSubview(self.weatherIconIamgeView!)
        self.weatherIconIamgeView?.snp_makeConstraints(closure: { (make) -> Void in
            make.centerX.equalTo(self.contentView)
            make.top.equalTo(self.contentView).offset(25)
            make.width.height.equalTo(100)
        });
        
        self.weatherLabel = UILabel()
        self.weatherLabel?.text = "多云"
        self.weatherLabel?.font = XZFont2(15)
        self.contentView.addSubview(self.weatherLabel!)
        self.weatherLabel?.snp_makeConstraints(closure: { (make) -> Void in
            make.left.equalTo((self.weatherIconIamgeView?.snp_right)!).offset(10)
            make.bottom.equalTo(self.weatherIconIamgeView!)
        });
        
        
        self.weatherCurrentLabel = UILabel()
        self.weatherCurrentLabel?.text = "18°"
        self.weatherCurrentLabel?.font = XZFont3(50)
      
        self.contentView.addSubview(self.weatherCurrentLabel!)
        self.weatherCurrentLabel?.snp_makeConstraints(closure: { (make) -> Void in
            make.right.equalTo((self.weatherIconIamgeView?.snp_centerX)!).offset(-15)
            make.top.equalTo((self.weatherIconIamgeView?.snp_bottom)!).offset(15)
        });
        
        self.windLabel = UILabel()
        self.windLabel?.text = "东被风 4级"
        self.windLabel?.font = XZFont2(13)
        self.contentView.addSubview(self.windLabel!)
        self.windLabel?.snp_makeConstraints(closure: { (make) -> Void in
            make.left.equalTo((self.weatherIconIamgeView?.snp_centerX)!).offset(15)
            make.top.equalTo(self.weatherCurrentLabel!).offset(10)
        });
        
        
        self.humidityLabel = UILabel()
        self.humidityLabel?.text = "湿度 8%"
        self.humidityLabel?.font = XZFont2(13)
        self.contentView.addSubview(self.humidityLabel!)
        self.humidityLabel?.snp_makeConstraints(closure: { (make) -> Void in
            make.left.equalTo(self.windLabel!)
            make.bottom.equalTo(self.weatherCurrentLabel!).offset(-10)
        });
        
        self.warmPromptLabel = UILabel()
        self.warmPromptLabel?.text = "空气不太好，在室内休息休息吧！"
        self.warmPromptLabel?.font = XZFont2(13)
        self.warmPromptLabel?.numberOfLines=0
        self.warmPromptLabel?.textAlignment = .Center
        self.contentView.addSubview(self.warmPromptLabel!)
        self.warmPromptLabel?.snp_makeConstraints(closure: { (make) -> Void in
            make.centerX.equalTo(self.contentView)
            make.top.equalTo((self.humidityLabel?.snp_bottom)!).offset(30)
            make.left.equalTo(self.contentView).offset(15)
            make.right.equalTo(self.contentView).offset(-15)
        });
   
    }
}



class Weather_LineTabeleViewCell: UITableViewCell ,UUChartDataSource{
    
    var chartView : UUChart?
    var _maxWeatherArray : NSMutableArray?
    var _minWeatherArray : NSMutableArray?
    var _maxWeatherStr : NSString?
    var _minWeatherStr : NSString?
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configUI()->Void{
        
        if (chartView  != nil){
            chartView?.removeFromSuperview()
            chartView = nil
        }
        chartView = UUChart.init(frame: CGRectMake(0,0,UIScreen.mainScreen().bounds.size.width, 200), dataSource: self, style: .Line)
    
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
    
//    //pragma mark - @required
    func chartConfigAxisXLabel(chart: UUChart) -> [AnyObject] {
        return self.getXTitles(7)
    }
//
    func chartConfigAxisYValue(chart: UUChart) -> [AnyObject] {
        return [[-10,1,51,41,20,1,50],[10,11,1,21,30,22,18]]
    }


    //pragma mark - @optional
     func chartConfigColors(chart: UUChart) ->  [AnyObject] {
        return [UUColor.green(),UUColor.orangeColor(),UUColor.brown()];
    }
    
    func chartRange(chart: UUChart) -> CGRange {
        return CGRangeMake(51 + 10, -10 - 10);
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
