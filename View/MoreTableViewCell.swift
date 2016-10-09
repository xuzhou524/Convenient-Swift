//
//  MoreTableViewCell.swift
//  Convenient-Swift
//
//  Created by gozap on 16/3/16.
//  Copyright © 2016年 xuzhou. All rights reserved.
//

import UIKit

class MoreTableViewCell: UITableViewCell {
    var iconImageView: UIImageView?
    var titleLabel: UILabel?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier:reuseIdentifier)
        self.sebView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.sebView()
    }
    
    func sebView(){
        self.contentView.backgroundColor = XZSwiftColor.convenientBackgroundColor
        self.iconImageView = UIImageView()
        self.iconImageView!.layer.cornerRadius = 15.0;
        self.iconImageView?.layer.masksToBounds = true
        self.iconImageView?.image = UIImage(named: "Icon-60")
        self.contentView.addSubview(self.iconImageView!)
        self.iconImageView?.snp.makeConstraints({ (make) -> Void in
            make.centerX.equalTo(self.contentView)
            make.top.equalTo(self.contentView).offset(50);
            make.width.height.equalTo(80)
        });
        
        self.titleLabel = UILabel()
        self.titleLabel?.text = "想容易,就用易"
        self.titleLabel?.font = XZFont2(14)
        self.titleLabel?.textColor = XZSwiftColor.textColor
        self.contentView.addSubview(self.titleLabel!)
        self.titleLabel?.snp.makeConstraints({ (make) -> Void in
            make.centerX.equalTo(self.contentView)
            make.top.equalTo((self.iconImageView?.snp.bottom)!).offset(10)
        });
    }
}

class More_InterTableViewCell: UITableViewCell {
    var zanImageView: UIImageView?
    var zanLabel: UILabel?
    
    var tuImageView: UIImageView?
    var tuLabel: UILabel?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier:reuseIdentifier)
        self.sebView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.sebView()
    }
    
    func sebView(){
        self.contentView.backgroundColor = XZSwiftColor.white
        
        let oneView = UIView()
        oneView.backgroundColor = XZSwiftColor.white
        self.contentView.addSubview(oneView)
        oneView.snp.makeConstraints { (make) -> Void in
            make.left.top.bottom.equalTo(self.contentView)
            make.right.equalTo(self.contentView.snp.centerX).offset(-0.5)
        }
        
        self.zanImageView = UIImageView()
        self.zanImageView!.layer.cornerRadius = 15.0;
        self.zanImageView?.isUserInteractionEnabled = true
        self.zanImageView?.image = UIImage(named: "about_praise")
        oneView.addSubview(self.zanImageView!)
        self.zanImageView?.snp.makeConstraints({ (make) -> Void in
            make.centerX.equalTo(oneView)
            make.top.equalTo(oneView).offset(10);
            make.width.height.equalTo(50)
        });
        
        self.zanLabel = UILabel()
        self.zanLabel?.text = "点个赞"
        self.zanLabel?.font = XZFont2(15)
        oneView.addSubview(self.zanLabel!)
        self.zanLabel?.snp.makeConstraints({ (make) -> Void in
            make.centerX.equalTo(oneView)
            make.top.equalTo((self.zanImageView?.snp.bottom)!).offset(10)
        });
    
        let linView = UIView()
        linView.backgroundColor = XZSwiftColor.xzGlay230
        self.contentView.addSubview(linView)
        linView.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(self.contentView)
            make.width.equalTo(0.5)
            make.top.equalTo(self.contentView).offset(10)
            make.bottom.equalTo(self.contentView).offset(-10)
        }
        
        
        let twoView = UIView()
        twoView.backgroundColor = XZSwiftColor.white
        self.contentView.addSubview(twoView)
        twoView.snp.makeConstraints { (make) -> Void in
            make.right.top.bottom.equalTo(self.contentView)
            make.left.equalTo(self.contentView.snp.centerX).offset(0.5)
        }
        
        self.tuImageView = UIImageView()
        self.tuImageView!.layer.cornerRadius = 15.0;
        self.tuImageView?.isUserInteractionEnabled = true
        self.tuImageView?.image = UIImage(named: "about_criticism")
        twoView.addSubview(self.tuImageView!)
        self.tuImageView?.snp.makeConstraints({ (make) -> Void in
            make.centerX.equalTo(twoView)
            make.top.equalTo(twoView).offset(10);
            make.width.height.equalTo(50)
        });
        
        self.tuLabel = UILabel()
        self.tuLabel?.text = "吐个槽"
        self.tuLabel?.font = XZFont2(15)
        twoView.addSubview(self.tuLabel!)
        self.tuLabel?.snp.makeConstraints({ (make) -> Void in
            make.centerX.equalTo(twoView)
            make.top.equalTo((self.tuImageView?.snp.bottom)!).offset(10)
        });
    }
}
