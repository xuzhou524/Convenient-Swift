//
//  RootWeatherTableViewCell.swift
//  Convenient-Swift
//
//  Created by gozap on 16/7/5.
//  Copyright © 2016年 xuzhou. All rights reserved.
//

import UIKit

class RootWeatherTableViewCell: UITableViewCell {
    var iconImageView : UIImageView?
    var cityNameLabel : UILabel?
    var weatherLabel : UILabel?
    var pm25Label : UILabel?
    var weatherCurrentLabel : UILabel?
    var summaryLabel : UILabel?
    
    var bgView : UIView?
    var oneNambelLabel : UILabel?
    var twoNambelLabel : UILabel?
    
    override  init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.sebViewS()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.sebViewS()
    }

    
    
    func sebViewS(){
        self.contentView.backgroundColor = XZSwiftColor.whiteColor()
        
        iconImageView = UIImageView()
        iconImageView?.backgroundColor = UIColor.grayColor()
        self.contentView.addSubview(iconImageView!)
        iconImageView?.snp_makeConstraints(closure: { (make) in
            make.left.equalTo(self.contentView).offset(15)
            make.top.equalTo(self.contentView).offset(10)
            make.width.height.equalTo(45)
        })
        
        cityNameLabel = UILabel()
        cityNameLabel?.text = "北京"
        cityNameLabel?.font = XZFont2(16)
        self.contentView.addSubview(cityNameLabel!)
        cityNameLabel?.snp_makeConstraints(closure: { (make) in
            make.top.equalTo(self.contentView).offset(10)
            make.left.equalTo((self.iconImageView?.snp_right)!).offset(10)
        })
        
        pm25Label = UILabel()
        pm25Label?.text = "PM2.5 250"
        pm25Label?.font = XZFont2(14)
        self.contentView.addSubview(pm25Label!)
        pm25Label?.snp_makeConstraints(closure: { (make) in
            make.centerY.equalTo(cityNameLabel!)
            make.left.equalTo((self.cityNameLabel?.snp_right)!).offset(10)
        })
        
        weatherCurrentLabel = UILabel()
        weatherCurrentLabel?.text = "晴 12 ~ 18℃"
        weatherCurrentLabel?.font = XZFont2(15)
        self.contentView.addSubview(weatherCurrentLabel!)
        weatherCurrentLabel?.snp_makeConstraints(closure: { (make) in
            make.bottom.equalTo(self.iconImageView!)
            make.left.equalTo((self.iconImageView?.snp_right)!).offset(10)
        })
        
        weatherLabel = UILabel()
        weatherLabel?.text = "28°"
        weatherLabel?.font = XZFont3(40)
        self.contentView.addSubview(weatherLabel!)
        weatherLabel?.snp_makeConstraints(closure: { (make) in
            make.top.equalTo(self.contentView).offset(15)
            make.centerX.equalTo(self.contentView).offset(35)
        })
        
        summaryLabel = UILabel()
        summaryLabel?.text = "绵绵的云朵，形成千变万化绵绵的云朵"
        summaryLabel?.font = XZFont2(14)
        self.contentView.addSubview(summaryLabel!)
        summaryLabel?.snp_makeConstraints(closure: { (make) in
            make.top.equalTo((self.iconImageView?.snp_bottom)!).offset(15)
            make.left.equalTo(self.iconImageView!)
        })
        

        self.bgView = UIView()
        self.bgView!.backgroundColor = XZSwiftColor.clearColor()
        self.contentView.addSubview(self.bgView!)
        self.bgView!.snp_makeConstraints(closure: { (make) -> Void in
            make.right.equalTo(self.contentView).offset(-15)
            make.top.equalTo(self.contentView).offset(10)
            make.height.equalTo(50)
            make.width.equalTo(75)
        });
        
        let xianXingGrayView = UIView()
        xianXingGrayView.layer.cornerRadius = 5;
        xianXingGrayView.backgroundColor = XZSwiftColor.xzGlay230
        self.bgView!.addSubview(xianXingGrayView)
        xianXingGrayView.snp_makeConstraints(closure: { (make) -> Void in
            
            make.right.equalTo(self.contentView).offset(-15)
            make.top.equalTo(self.contentView).offset(10)
            make.height.equalTo(20)
            make.width.equalTo(75)
        });
        
        let xianXingWView = UIView()
        xianXingWView.backgroundColor = XZSwiftColor.whiteColor()
        self.bgView!.addSubview(xianXingWView)
        xianXingWView.snp_makeConstraints(closure: { (make) -> Void in
            make.left.right.equalTo(xianXingGrayView)
            make.top.equalTo(xianXingGrayView.snp_bottom).offset(-3)
            make.height.equalTo(34)
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
        xianXingLabel.font = XZFont2(12)
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
        self.oneNambelLabel!.text = "-"
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
        self.twoNambelLabel!.text = "-"
        self.twoNambelLabel!.textColor = XZSwiftColor.textColor
        twoView.addSubview(self.twoNambelLabel!)
        self.twoNambelLabel!.snp_makeConstraints(closure: { (make) -> Void in
            make.center.equalTo(twoView)
        });
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
