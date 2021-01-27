//
//  AddCityTableViewController.swift
//  Convenient-Swift
//
//  Created by gozap on 16/3/10.
//  Copyright © 2016年 xuzhou. All rights reserved.
//

import UIKit
import Alamofire
import TMCache
import SVProgressHUD
import CoreLocation
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


typealias callbackfunc = (_ weatherModel:WeatherModel)->Void

class AddCityTableViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate {
    var citySearchBar: UISearchBar?
    var weatherArray = NSMutableArray()
    var cityMdoel: CityMdoel?
    fileprivate var _tableView: UITableView!
    fileprivate var tableView: UITableView{
        get{
            if _tableView == nil{
                
                _tableView = UITableView()
                _tableView?.backgroundColor = XZSwiftColor.convenientBackgroundColor
                _tableView?.separatorStyle = .none
                _tableView?.delegate = self
                _tableView?.dataSource = self

                self.tableView.register(citySearch_ResultsTabelView.self, forCellReuseIdentifier: "citySearch_ResultsTabelView")

            }
            return _tableView
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.backupgroupTap()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "选择城市"
        self.view.backgroundColor = XZSwiftColor.convenientBackgroundColor
        
        self.citySearchBar = UISearchBar()
        self.citySearchBar?.tintColor = UIColor.red
        self.citySearchBar?.autoresizingMask = .flexibleWidth
        self.citySearchBar?.delegate = self
        self.citySearchBar?.placeholder = "请输入城市名称"
        self.view.addSubview(self.citySearchBar!)
        self.citySearchBar?.snp.makeConstraints({ (make) -> Void in
            make.left.right.equalTo(self.view)
            make.top.equalTo(self.view)
            make.height.equalTo(40)
        });
        
        let location = UIView()
        location.backgroundColor = UIColor.white
        self.view.addSubview(location)
        location.snp.makeConstraints { (make) -> Void in
            make.left.right.equalTo(self.view)
            make.height.equalTo(40)
            make.top.equalTo((self.citySearchBar?.snp.bottom)!).offset(5)
        }
        
        let titleLabel = UILabel()
        titleLabel.font = XZFont2(14)
        titleLabel.textColor = XZSwiftColor.xzGlay142
        
        if CLLocationManager.authorizationStatus() == .denied || XZClient.sharedInstance.username == nil{
            if CLLocationManager.authorizationStatus() == .denied {
                titleLabel.text = "定位未开启，手机“设置” - “隐私”中打开定位服务"
            }else{
                titleLabel.text = "定位失败，请检查网络，重新打开程序"
            }
        }else{
            titleLabel.text = "定位成功,你当前位置   " + XZClient.sharedInstance.username!
        }
        location.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(location).offset(15)
            make.centerY.equalTo(location)
        }
    
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) -> Void in
            make.left.right.bottom.equalTo(self.view)
            make.top.equalTo(location.snp.bottom).offset(5)
        }
    
        let tapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(AddCityTableViewController.backupgroupTap))
        tapGestureRecognizer.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(tapGestureRecognizer)
        tapGestureRecognizer.cancelsTouchesInView = false
        
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
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if self.citySearchBar?.text?.Lenght > 0{
            let urlString = "http://zhwnlapi.etouch.cn/Ecalender/api/city"
            let prames = [
                "keyword" : (self.citySearchBar?.text)! as String,
                "timespan" : "1544060771000",
                "type" : "search"
            ]
            SVProgressHUD.show()
           //先注释一下下
//             Alamofire.request(urlString, method: .get, parameters: prames).responseJSON{ (response) -> Void in
//                if let model = response.result.value{
//                    let modelDic = model as! NSDictionary
//
//                    if modelDic.count > 0{
////                        CityMdoel.init(dictionary: <#T##[AnyHashable : Any]!#>)
////                        self.cityMdoel =
////                        let dataDic = modelDic["data"] as! NSMutableDictionary
////                        var dataStr = dataDic["cityid"]
//                        self.cityMdoel = CityMdoel.init(dictionary: model as? [AnyHashable : Any])
//                         SVProgressHUD.dismiss()
//                        self.tableView .reloadData()
//                    }else{
//                        SVProgressHUD.showError(withStatus: "请输入正确城市")
//                    }
//                }else{
//                    SVProgressHUD.showError(withStatus: "请检查网络")
//                }
//            }
        }
    }
    
    @objc func backupgroupTap(){
        UIApplication.shared .sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.cityMdoel?.data?.count > 0 {
             return Int((self.cityMdoel?.data?.count)!)
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = getCell(tableView, cell: citySearch_ResultsTabelView.self, indexPath: indexPath)
        cell.selectionStyle = .none
        if self.cityMdoel?.data?.count > 0{
            let cityDataMdoelArray = self.cityMdoel?.data! as! NSArray
            let cityDataMdoel = CityDataMdoel.init(dictionary: (cityDataMdoelArray[indexPath.row] as! [AnyHashable : Any]))
            cell.bind(cityDataMdoel!)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cityDataMdoelArray = self.cityMdoel?.data! as! NSArray
        let model = CityDataMdoel.init(dictionary: (cityDataMdoelArray[indexPath.row] as! [AnyHashable : Any]))
        WeatherModel.like((model?.name)!, success: { (model) -> Void in
            self.weatherArray = TMCache.shared().object(forKey: kTMCacheWeatherArray) as! NSMutableArray
            //去重
            var tempBool = true
            for  i in 0  ..< self.weatherArray.count {
                let models = self.weatherArray[i] as! WeatherModel
                if models.realtime?.city_code == model.realtime?.city_code || models.realtime?.city_name == model.realtime?.city_name{
                    self.weatherArray.removeObject(at: i)
                    self.weatherArray.insert(model, at: i)
                    tempBool = false
                }
            }
            if tempBool{
                self.weatherArray.add(model)
            }
            TMCache.shared().setObject(self.weatherArray, forKey: kTMCacheWeatherArray)
            self.navigationController?.popViewController(animated: true)
            
            }, failure: { (error) -> Void in
        })
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
