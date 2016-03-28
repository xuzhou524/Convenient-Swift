//
//  BaseTableViewCell.swift
//  Convenient-Swift
//
//  Created by gozap on 16/3/16.
//  Copyright © 2016年 xuzhou. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    var titleLabel: UILabel?
    var detaileLabel: UILabel?
    var rightImage: UIImageView?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.sebView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.sebView()
    }

    func sebView(){
        self.titleLabel = UILabel()
        self.titleLabel?.text = "当前版本"
        self.titleLabel?.textColor = XZSwiftColor.textColor
        self.titleLabel?.font = XZFont2(15)
        self.contentView.addSubview(self.titleLabel!)
        self.titleLabel!.snp_makeConstraints(closure: { (make) -> Void in
            make.left.equalTo(self.contentView).offset(15)
            make.centerY.equalTo(self.contentView)
        });
        
        self.rightImage = UIImageView()
        self.rightImage?.image = UIImage(named: "arrow_right")
        self.contentView.addSubview(self.rightImage!)
        self.rightImage?.snp_makeConstraints(closure: { (make) in
            make.centerY.equalTo(self.contentView)
            make.height.equalTo(15)
            make.width.equalTo(12)
            make.right.equalTo(self.contentView).offset(-10)
        });
        
        self.detaileLabel = UILabel()
        self.detaileLabel?.text = "v1.0.0"
        self.detaileLabel?.textColor = XZSwiftColor.textColor
        self.detaileLabel?.font = XZFont2(14)
        self.detaileLabel?.textAlignment = .Right;
        self.contentView.addSubview(self.detaileLabel!)
        self.detaileLabel!.snp_makeConstraints(closure: { (make) -> Void in
            make.right.equalTo((self.rightImage?.snp_left)!).offset(-5)
            make.centerY.equalTo(self.contentView)
        });
        
        let linView = UIView()
        linView.backgroundColor = XZSwiftColor.xzGlay230
        self.contentView.addSubview(linView)
        linView.snp_makeConstraints { (make) -> Void in
            make.height.equalTo(0.5);
            make.right.equalTo(self.contentView)
            make.left.equalTo(self.contentView).offset(15)
            make.bottom.equalTo(self.contentView)
        }
    }
}
