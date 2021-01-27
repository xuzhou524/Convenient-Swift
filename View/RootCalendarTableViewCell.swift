//
//  RootCalendarTableViewCell.swift
//  Convenient-Swift
//
//  Created by gozap on 16/7/18.
//  Copyright © 2016年 xuzhou. All rights reserved.
//

import UIKit

class RootCalendarTableViewCell: UITableViewCell {
    var calendar : LBCalendar!
    var calendarContentView : LBCalendarContentView?
    
    override  init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.sebViewS()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.sebViewS()
    }
    func sebViewS(){
        
        calendarContentView = LBCalendarContentView()
        calendarContentView?.backgroundColor = XZSwiftColor.white
        self.contentView.addSubview(calendarContentView!)
        calendarContentView?.snp.makeConstraints({ (make) in
            make.left.top.right.bottom.equalTo(self.contentView)
        });
        
        self.calendar = LBCalendar.init()
        //self.calendar?.calendarAppearance().calendar().firstWeekday = 1  //Sunday ==1,Saturday == 7
        self.calendar?.calendarAppearance().dayRectangularRatio = 9.00 / 10.00
        self.calendar?.contentView = calendarContentView
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
