//
//  RootWeekTableViewCell.swift
//  Convenient-Swift
//
//  Created by gozap on 16/7/18.
//  Copyright © 2016年 xuzhou. All rights reserved.
//

import UIKit

class RootWeekTableViewCell: UITableViewCell {
    override  init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.sebViewS()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.sebViewS()
    }
    func sebViewS(){
        //星期
        let itemW  = UIScreen.mainScreen().bounds.size.width / 7.00
        let array = ["周一", "周二", "周三", "周四", "周五", "周六","周日"]
        let weekBg = UIView.init()
        weekBg.backgroundColor = XZSwiftColor.weekBgColor
        weekBg.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, 44)
        self.contentView.addSubview(weekBg)
        for  i in 0  ..< 7{
            let week = UILabel.init()
            week.text = array[i]
            week.font = UIFont.systemFontOfSize(14)
            week.frame = CGRectMake(itemW * CGFloat(i), 6, itemW, 32)
            week.textAlignment = .Center
            week.textColor = XZSwiftColor.blackColor()
            week.backgroundColor = XZSwiftColor.clearColor()
            weekBg.addSubview(week)
        }
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}

