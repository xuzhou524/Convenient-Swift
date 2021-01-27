//
//  CityViewController.swift
//  Convenient-Swift
//
//  Created by gozap on 16/3/10.
//  Copyright © 2016年 xuzhou. All rights reserved.
//

import UIKit
import TMCache

typealias cityViewbackfunc = (_ str: String) -> Void

class CityViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var weatherArray = NSMutableArray()
    
    fileprivate var _tableView: UITableView!
    fileprivate var tableView: UITableView{
        get{
            if _tableView == nil{
                _tableView = UITableView()
                _tableView.delegate = self
                _tableView.dataSource = self
                _tableView.separatorStyle = .none
                _tableView.backgroundColor = XZSwiftColor.convenientBackgroundColor
                
                self.tableView.register(CityTableViewCell.self, forCellReuseIdentifier: "CityTableViewCell")
                self.tableView.register(addCityNullTabelView.self, forCellReuseIdentifier: "addCityNullTabelView")
            }
            return _tableView
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "城市管理"
        self.view.addSubview(self.tableView);
        self.tableView.snp.makeConstraints{ (make) -> Void in
            make.top.right.bottom.left.equalTo(self.view);
        }
        if  TMCache.shared().object(forKey: kTMCacheWeatherArray) != nil{
            self.weatherArray = TMCache.shared().object(forKey: kTMCacheWeatherArray) as! NSMutableArray
        }
        let leftButton = UIButton()
        leftButton.frame = CGRect(x: 0, y: 0, width: 35, height: 30)
        leftButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
        leftButton.setImage(UIImage(named: "bank"), for: UIControl.State())
        leftButton.adjustsImageWhenHighlighted = false
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
        leftButton.addTarget(self, action: #selector(HomeViewController.leftClick), for: .touchUpInside)
    }
    func leftClick(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.weatherArray.count + 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath as NSIndexPath).row == self.weatherArray.count{
            let addCell = getCell(tableView, cell: addCityNullTabelView.self, indexPath: indexPath)
            addCell.selectionStyle = .none
            return addCell
        }
        
        let cityCell = getCell(tableView, cell: CityTableViewCell.self, indexPath: indexPath)
        cityCell.selectionStyle = .none
        cityCell.bind(self.weatherArray[(indexPath as NSIndexPath).row] as! WeatherModel)
        cityCell.shanChuView?.tag = (indexPath as NSIndexPath).row + 100
        cityCell.bgScrollView?.tag = (indexPath as NSIndexPath).row + 1000
        
        let tapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(CityViewController.deleteLocalCity(_:)))
        cityCell.shanChuView!.addGestureRecognizer(tapGestureRecognizer)
   
        let scrollViewRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(CityViewController.selectModel(_:)))
        cityCell.bgScrollView!.addGestureRecognizer(scrollViewRecognizer)
        
        return cityCell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath as NSIndexPath).row == self.weatherArray.count{
            let addCityVC = AddCityTableViewController()
            self.navigationController?.pushViewController(addCityVC, animated: true)
        }
    }
    
    @objc func deleteLocalCity(_ tap:UITapGestureRecognizer){
        self.weatherArray.removeObject(at: ((tap.view?.tag)! - 100))
        TMCache.shared().setObject(self.weatherArray, forKey: kTMCacheWeatherArray)
        self.tableView.reloadData()
        
    }
    
    @objc func selectModel(_ tap:UITapGestureRecognizer){
        let weatherModel = self.weatherArray[((tap.view?.tag)! - 1000)]  as! WeatherModel
        self.navigationController?.popViewController(animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}
