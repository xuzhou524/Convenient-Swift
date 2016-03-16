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

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 220
        }
        if indexPath.row == 1{
            return 100
        }
        if indexPath.row == 2{
            return 10
        }
        return 60
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let moreCell = getCell(tableView, cell: MoreTableViewCell.self, indexPath: indexPath)
            return moreCell
        }
        if indexPath.row == 1{
            let interCell = getCell(tableView, cell: More_InterTableViewCell.self, indexPath: indexPath)
            return interCell

        }
        
        if indexPath.row == 2{
            let cell = UITableViewCell()
            cell.backgroundColor = XZSwiftColor.convenientBackgroundColor
            return cell
        }
        let baseCell = getCell(tableView, cell: BaseTableViewCell.self, indexPath: indexPath)
        return baseCell
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
