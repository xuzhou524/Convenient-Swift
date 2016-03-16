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
        self.titleLabel?.textColor = XZSwiftColor.navignationColor
        self.titleLabel?.font = XZFont2(16)
        self.contentView.addSubview(self.titleLabel!)
        self.titleLabel!.snp_makeConstraints(closure: { (make) -> Void in
            make.left.equalTo(self.contentView).offset(15)
            make.centerY.equalTo(self.contentView)
        });
        
        self.detaileLabel = UILabel()
        self.detaileLabel?.text = "v1.0.0"
        self.detaileLabel?.textColor = XZSwiftColor.navignationColor
        self.detaileLabel?.font = XZFont2(16)
        self.contentView.addSubview(self.detaileLabel!)
        self.detaileLabel!.snp_makeConstraints(closure: { (make) -> Void in
            make.right.equalTo(self.contentView).offset(-15)
            make.centerY.equalTo(self.contentView)
        });
    }
}
