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
        self.bgScrollView?.layer.borderColor = XZSwiftColor.whiteColor().CGColor
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
        bgView.addSubview(self.weatherImageView!)
        self.weatherImageView?.snp_makeConstraints(closure: { (make) -> Void in
            make.centerX.equalTo(bgView)
            make.top.equalTo(bgView).offset(10)
            make.height.equalTo(30)
            make.width.equalTo(30)
        });
        
        self.weatherLabel = UILabel()
        self.weatherLabel?.text = "10°"
        self.weatherLabel?.textColor = XZSwiftColor.textColor
        self.weatherLabel?.font = XZFont3(16)
        bgView.addSubview(self.weatherLabel!)
        self.weatherLabel?.snp_makeConstraints(closure: { (make) -> Void in
            make.bottom.equalTo(bgView).offset(-10)
            make.centerX.equalTo(bgView).offset(3)
        });
        
        let linView = UIView()
        linView.backgroundColor = XZSwiftColor.textColor
        bagBGview.addSubview(linView)
        linView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(bgView).offset(15)
            make.bottom.equalTo(bgView).offset(-15)
            make.left.equalTo(bgView.snp_right)
            make.width.equalTo(0.4)
        }
        
        self.cityNameLabel = UILabel()
        self.cityNameLabel?.text = "北京"
        self.cityNameLabel?.textColor = XZSwiftColor.textColor
        self.cityNameLabel?.font = XZFont2(17)
        bagBGview.addSubview(self.cityNameLabel!)
        self.cityNameLabel?.snp_makeConstraints(closure: { (make) -> Void in
            make.centerY.equalTo(bagBGview).offset(-15)
            make.left.equalTo(bgView.snp_right).offset(30)
        });
        self.weatherSLabel = UILabel()
        self.weatherSLabel?.text = "5° ~ 15°"
        self.weatherSLabel?.textColor = XZSwiftColor.textColor
        self.weatherSLabel?.font = XZFont3(17)
        bagBGview.addSubview(self.weatherSLabel!)
        self.weatherSLabel?.snp_makeConstraints(closure: { (make) -> Void in
            make.centerY.equalTo(bagBGview).offset(18)
            make.left.equalTo(self.cityNameLabel!)
        });
        
        self.shanChuView = UIView()
        self.shanChuView?.backgroundColor = XZSwiftColor.navignationColor
        self.shanChuView?.userInteractionEnabled = true
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
        let modelDic = weathermodel.weather[0]
        if (modelDic.objectForKey("info") != nil) {
            let infoDic =  (modelDic.objectForKey("info"))! as! NSMutableDictionary
            let dayArray =  (infoDic.objectForKey("day"))! as! NSMutableArray
            let nightArray =  (infoDic.objectForKey("night"))! as! NSMutableArray
            
            self.weatherImageView?.image = UIImage(named:"cm_weathericon_" + (dayArray[0] as! String))
            self.weatherLabel?.text = (weathermodel.realtime?.weather?.temperature)!  + "°"
            self.cityNameLabel?.text = weathermodel.realtime!.city_name
            self.weatherSLabel?.text =  (nightArray[2] as? String)! + "° ~ " + (dayArray[2] as? String)! + "°"
        }
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
        self.contentView.backgroundColor = XZSwiftColor.convenientBackgroundColor
        
        let bgView = UIView()
        bgView.layer.borderWidth = 0.5
        bgView.layer.cornerRadius = 3.0;
        bgView.layer.borderColor = XZSwiftColor.textColor.CGColor
        bgView.backgroundColor = XZSwiftColor.whiteColor()
        self.contentView.addSubview(bgView)
        bgView.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.contentView).offset(10)
            make.right.equalTo(self.contentView).offset(-10)
            make.top.equalTo(self.contentView).offset(10)
            make.bottom.equalTo(self.contentView).offset(-10)
        }
        
        let linView = UIView()
        linView.backgroundColor = XZSwiftColor.textColor
        bgView.addSubview(linView)
        linView.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(bgView)
            make.width.equalTo(40)
            make.height.equalTo(0.5)
        }
        
        let linsView = UIView()
        linsView.backgroundColor = XZSwiftColor.textColor
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
        self.searchNameLabel?.textColor = XZSwiftColor.textColor
        self.contentView.addSubview(self.searchNameLabel!)
        self.searchNameLabel?.snp_makeConstraints(closure: { (make) -> Void in
            make.left.equalTo(self.contentView).offset(15)
            make.centerY.equalTo(self.contentView)
        });
        
        let linsView = UIView()
        linsView.backgroundColor = XZSwiftColor.textColor
        self.contentView.addSubview(linsView)
        linsView.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.contentView).offset(15)
            make.bottom.right.equalTo(self.contentView)
            make.height.equalTo(0.5)
        }
    }
    
    func bind(model: CityDataMdoel) ->Void{
        if (model.name != nil  && model.prov != nil ) {
            self.searchNameLabel?.text = model.name! + " - " + model.prov!
        }
    }
}


