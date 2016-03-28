//
//  MoreTableViewController.swift
//  Convenient-Swift
//
//  Created by gozap on 16/3/16.
//  Copyright © 2016年 xuzhou. All rights reserved.
//

import UIKit

class MoreTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "关于我们"
        self.tableView.backgroundColor = XZSwiftColor.convenientBackgroundColor
        self.tableView.separatorStyle = .None

        regClass(self.tableView, cell: MoreTableViewCell.self)
        regClass(self.tableView, cell: More_InterTableViewCell.self)
        regClass(self.tableView, cell: BaseTableViewCell.self)
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 7
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 220
        }
        if indexPath.row == 1{
            return 100
        }
        if indexPath.row == 2{
            return 15
        }
        return 50
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let moreCell = getCell(tableView, cell: MoreTableViewCell.self, indexPath: indexPath)
            moreCell.selectionStyle = .None
            return moreCell
        }
        if indexPath.row == 1{
            let interCell = getCell(tableView, cell: More_InterTableViewCell.self, indexPath: indexPath)
            interCell.selectionStyle = .None
            return interCell
        }
        
        if indexPath.row == 2{
            let cell = UITableViewCell()
            cell.backgroundColor = XZSwiftColor.convenientBackgroundColor
            cell.selectionStyle = .None
            return cell
        }
        let baseCell = getCell(tableView, cell: BaseTableViewCell.self, indexPath: indexPath)
        baseCell.selectionStyle = .None
        
        if indexPath.row == 3 {
            baseCell.titleLabel?.text = "服务热线"
            baseCell.detaileLabel?.text = "185 1423 5240"
        }
        if indexPath.row == 4 {
            baseCell.titleLabel?.text = "新浪微博"
            baseCell.detaileLabel?.text = "Aaron_徐"
        }
        if indexPath.row == 5 {
            baseCell.titleLabel?.text = "服务QQ"
            baseCell.detaileLabel?.text = "1043037904"
        }
        if indexPath.row == 6 {
            let infoDict = NSBundle.mainBundle().infoDictionary
            if let info = infoDict {
                // app版本
                let appVersion = info["CFBundleShortVersionString"] as! String!
                baseCell.detaileLabel?.text = "v" + appVersion
            }
        }
        return baseCell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
