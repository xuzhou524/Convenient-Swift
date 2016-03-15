//
//  CityTableViewCell.swift
//  Convenient-Swift
//
//  Created by gozap on 16/3/10.
//  Copyright © 2016年 xuzhou. All rights reserved.
//

import UIKit


class CityTableViewCell: UITableViewCell {

   
    var weatherImageView: UIImageView?
    var weatherLabel: UILabel?
    var cityNameLabel: UILabel?
    var weatherSLabel: UILabel?
    var bgScrollView: UIScrollView?
    var shanChuView: UIView?

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.sebView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.sebView()
    }
    func sebView() ->Void{
        
        self.contentView.backgroundColor = XZSwiftColor.convenientBackgroundColor
        
        
        let hight: CGFloat = 80
        
        self.bgScrollView = UIScrollView.init(frame:CGRectMake(10, 10, UIScreen.mainScreen().bounds.size.width - 20,  hight))
        self.bgScrollView?.backgroundColor = XZSwiftColor.whiteColor()
        self.bgScrollView!.contentSize = CGSizeMake(UIScreen.mainScreen().bounds.size.width + 60, hight)
        self.bgScrollView?.pagingEnabled = true
        self.bgScrollView?.scrollsToTop = false
        self.bgScrollView?.userInteractionEnabled = true
        self.bgScrollView?.showsHorizontalScrollIndicator = false
        self.bgScrollView?.layer.borderWidth = 0.5
        self.bgScrollView!.layer.cornerRadius = 3.0;
//        self.bgScrollView?.layer.shadowColor = XZSwiftColor.navignationColor.CGColor
//        self.bgScrollView?.layer.shadowOffset = CGSizeMake(0, 0);
//        self.bgScrollView?.layer.shadowOpacity = 1;
//        self.bgScrollView?.layer.shadowRadius = 2;
        self.bgScrollView?.layer.borderColor = XZSwiftColor.navignationColor.CGColor
        self.contentView.addSubview(self.bgScrollView!)
        
        let bagBGview = UIView.init(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width - 20,  hight))
        bagBGview.backgroundColor = XZSwiftColor.whiteColor()
        self.bgScrollView?.addSubview(bagBGview)
        self.bgScrollView?.sendSubviewToBack(bagBGview)
        
        let bgView = UIView()
        bgView.backgroundColor = XZSwiftColor.whiteColor()
        bagBGview.addSubview(bgView)
        bgView.snp_makeConstraints { (make) -> Void in
            make.left.top.equalTo(bagBGview)
            make.width.height.equalTo(hight)
        }
        
        self.weatherImageView = UIImageView()
        self.weatherImageView?.image = UIImage(named: "cm_weathericon_0")
        bgView.addSubview(self.weatherImageView!)
        self.weatherImageView?.snp_makeConstraints(closure: { (make) -> Void in
            make.centerX.equalTo(bgView)
            make.top.equalTo(bgView).offset(10)
            make.width.height.equalTo(35)
        });
        
        self.weatherLabel = UILabel()
        self.weatherLabel?.text = "10°"
        self.weatherLabel?.textColor = XZSwiftColor.navignationColor
        self.weatherLabel?.font = XZFont3(16)
        bgView.addSubview(self.weatherLabel!)
        self.weatherLabel?.snp_makeConstraints(closure: { (make) -> Void in
            make.bottom.equalTo(bgView).offset(-10)
            make.centerX.equalTo(bgView).offset(3)
        });
        
        let linView = UIView()
        linView.backgroundColor = XZSwiftColor.navignationColor
        bagBGview.addSubview(linView)
        linView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(bgView).offset(15)
            make.bottom.equalTo(bgView).offset(-15)
            make.left.equalTo(bgView.snp_right)
            make.width.equalTo(0.4)
        }
        
        self.cityNameLabel = UILabel()
        self.cityNameLabel?.text = "北京"
        self.cityNameLabel?.textColor = XZSwiftColor.navignationColor
        self.cityNameLabel?.font = XZFont2(17)
        bagBGview.addSubview(self.cityNameLabel!)
        self.cityNameLabel?.snp_makeConstraints(closure: { (make) -> Void in
            make.centerY.equalTo(bagBGview).offset(-15)
            make.left.equalTo(bgView.snp_right).offset(30)
        });
        self.weatherSLabel = UILabel()
        self.weatherSLabel?.text = "5° ~ 15°"
        self.weatherSLabel?.textColor = XZSwiftColor.navignationColor
        self.weatherSLabel?.font = XZFont3(17)
        bagBGview.addSubview(self.weatherSLabel!)
        self.weatherSLabel?.snp_makeConstraints(closure: { (make) -> Void in
            make.centerY.equalTo(bagBGview).offset(18)
            make.left.equalTo(self.cityNameLabel!)
        });
        
        self.shanChuView = UIView()
        self.shanChuView?.backgroundColor = XZSwiftColor.navignationColor
        self.bgScrollView?.addSubview(self.shanChuView!)
        self.shanChuView?.snp_makeConstraints(closure: { (make) -> Void in
            make.width.equalTo(hight)
            make.height.equalTo(hight)
            make.right.equalTo(self.contentView).offset(-10)
            make.top.equalTo(self.contentView).offset(10)
        });
        self.bgScrollView?.sendSubviewToBack(self.shanChuView!)
        let shanChuLabel = UILabel()
        shanChuLabel.text = "删除"
        shanChuLabel.font = XZFont2(17)
        shanChuLabel.textColor = XZSwiftColor.whiteColor()
        self.shanChuView?.addSubview(shanChuLabel)
        shanChuLabel.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(self.shanChuView!)
        }
        
    }
    
    func bind(weathermodel:WeatherModel) ->Void{
        self.weatherImageView?.image = UIImage(named:"cm_weathericon_" + (weathermodel.realtime!.weather!.img)!)
        self.weatherLabel?.text = (weathermodel.realtime?.weather?.temperature)!  + "°"
        self.cityNameLabel?.text = weathermodel.realtime!.city_name
        let modelDic = weathermodel.weather[0]
        self.weatherSLabel?.text =  (modelDic["info"]!!["night"]!![2] as? String)! + "° ~ " + (modelDic["info"]!!["day"]!![2] as? String)! + "°"
    }
  
}
class addCityNullTabelView: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.sebView()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.sebView()
    }
    
    func sebView(){
        let hight: CGFloat = 80
        let bgView = UIView.init(frame:CGRectMake(10, 10, UIScreen.mainScreen().bounds.size.width - 20,  hight))
        bgView.layer.borderWidth = 0.5
        bgView.layer.cornerRadius = 3.0;
        bgView.layer.borderColor = XZSwiftColor.navignationColor.CGColor
        self.contentView.addSubview(bgView)
        
        let linView = UIView()
        linView.backgroundColor = XZSwiftColor.navignationColor
        bgView.addSubview(linView)
        linView.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(bgView)
            make.width.equalTo(40)
            make.height.equalTo(0.5)
        }
        
        let linsView = UIView()
        linsView.backgroundColor = XZSwiftColor.navignationColor
        bgView.addSubview(linsView)
        linsView.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(bgView)
            make.width.equalTo(0.5)
            make.height.equalTo(40)
        }
    }
}

class addCitySearchTabelView: UITableViewCell {
    var searchBar: UISearchBar?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.sebView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.sebView()
    }
    
    func sebView(){
        self.contentView.backgroundColor = XZSwiftColor.convenientBackgroundColor
        self.searchBar = UISearchBar()
        self.searchBar?.autoresizingMask = .FlexibleWidth
        self.searchBar?.placeholder = "请输入城市名称"
        self.contentView.addSubview(self.searchBar!)
        self.searchBar?.snp_makeConstraints(closure: { (make) -> Void in
            make.left.right.equalTo(self.contentView)
            make.top.equalTo(self.contentView)
            make.height.equalTo(40)
        });
        
    }
    
}

class citySearch_ResultsTabelView: UITableViewCell {
    var searchNameLabel: UILabel?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.sebView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.sebView()
    }
    
    func sebView(){
        self.contentView.backgroundColor = XZSwiftColor.convenientBackgroundColor
        
        self.searchNameLabel = UILabel()
        self.searchNameLabel?.font = XZFont2(15)
        self.searchNameLabel?.textColor = XZSwiftColor.navignationColor
        self.contentView.addSubview(self.searchNameLabel!)
        self.searchNameLabel?.snp_makeConstraints(closure: { (make) -> Void in
            make.left.equalTo(self.contentView).offset(15)
            make.centerY.equalTo(self.contentView)
        });
        
        let linsView = UIView()
        linsView.backgroundColor = XZSwiftColor.navignationColor
        self.contentView.addSubview(linsView)
        linsView.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.contentView).offset(15)
            make.bottom.right.equalTo(self.contentView)
            make.height.equalTo(0.5)
        }
    }
    
    func bind(model: CityDataMdoel) ->Void{
        self.searchNameLabel?.text = model.name! + " - " + model.prov!
    }
}


