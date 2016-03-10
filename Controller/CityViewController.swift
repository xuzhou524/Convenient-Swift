//
//  CityViewController.swift
//  Convenient-Swift
//
//  Created by gozap on 16/3/10.
//  Copyright © 2016年 xuzhou. All rights reserved.
//

import UIKit


class CityViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    private var _tableView: UITableView!
    private var tableView: UITableView{
        get{
            if _tableView == nil{
                _tableView = UITableView()
                _tableView.delegate = self
                _tableView.dataSource = self
                _tableView.separatorStyle = .None
                _tableView.backgroundColor = XZSwiftColor.convenientBackgroundColor
                
                regClass(_tableView, cell: CityTableViewCell.self)
                regClass(_tableView, cell: addCityNullTabelView.self)
                
                return _tableView
            }
            return _tableView
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "城市管理"
        self.view.addSubview(self.tableView);
        self.tableView.snp_makeConstraints{ (make) -> Void in
            make.top.right.bottom.left.equalTo(self.view);
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.row == 3{
            let addCell = getCell(tableView, cell: addCityNullTabelView.self, indexPath: indexPath)
            addCell.selectionStyle = .None
            return addCell
        }
        
        let cityCell = getCell(tableView, cell: CityTableViewCell.self, indexPath: indexPath)
        cityCell.selectionStyle = .None
        return cityCell

    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 3{
            self.navigationController?.pushViewController(AddCityTableViewController(), animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}
