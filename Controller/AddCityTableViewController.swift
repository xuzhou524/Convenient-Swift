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

typealias callbackfunc=(weatherModel:WeatherModel)->Void

class AddCityTableViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate {

    var myFunc = callbackfunc?()
     var alamofireManager : Manager?
    
    func initBack(mathFunction:(weatherModel:WeatherModel)->Void ){
        myFunc = mathFunction
    }
    
    var citySearchBar: addCitySearchTabelView?
    var weatherArray = NSMutableArray()
    var cityMdoel: CityMdoel?
    private var _tableView: UITableView!
    private var tableView: UITableView{
        get{
            if _tableView == nil{
                _tableView = UITableView()
                _tableView?.backgroundColor = XZSwiftColor.convenientBackgroundColor
                _tableView?.separatorStyle = .None
                _tableView?.delegate = self
                _tableView?.dataSource = self
                
                regClass(_tableView, cell:citySearch_ResultsTabelView.self)
            }
            return _tableView
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.backupgroupTap()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "选择城市"
        self.view.backgroundColor = XZSwiftColor.convenientBackgroundColor
        self.citySearchBar = addCitySearchTabelView()
        self.citySearchBar?.searchBar?.delegate = self
        self.view.addSubview(self.citySearchBar!)
        self.citySearchBar?.snp_makeConstraints(closure: { (make) -> Void in
            make.left.right.equalTo(self.view)
            make.top.equalTo(self.view)
            make.height.equalTo(40)
        });
        
        self.view.addSubview(self.tableView)
        self.tableView.snp_makeConstraints { (make) -> Void in
            make.left.right.bottom.equalTo(self.view)
            make.top.equalTo((self.citySearchBar?.snp_bottom)!).offset(5)
        }
    
        let tapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(AddCityTableViewController.backupgroupTap))
        tapGestureRecognizer.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(tapGestureRecognizer)
        tapGestureRecognizer.cancelsTouchesInView = false
    }

    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        if self.citySearchBar?.searchBar?.text?.Lenght > 0{
            let urlString = "http://zhwnlapi.etouch.cn/Ecalender/api/city"
            let prames = [
                "keyword" : (self.citySearchBar?.searchBar?.text)! as String,
                "timespan" : "1457518656000",
                "type" : "search"
            ]
            
            let config = NSURLSessionConfiguration.defaultSessionConfiguration()
            config.timeoutIntervalForRequest = 30    // 秒
            self.alamofireManager = Manager(configuration: config)
            SVProgressHUD.show()
            self.alamofireManager!.request(.GET, urlString, parameters:prames, encoding: .URL, headers: nil).responseObject("") {
                (response : Response<CityMdoel,NSError>) in
                if let model = response.result.value{
                    if model.data?.count > 0{
                        self.cityMdoel = model
                         SVProgressHUD.dismiss()
                        self.tableView .reloadData()
                    }else{
                        SVProgressHUD.showErrorWithStatus("请输入正确城市")
                    }
                }
            }
        }
    }
    
    func backupgroupTap(){
        UIApplication.sharedApplication() .sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, forEvent: nil)
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.cityMdoel?.data?.count > 0 {
             return Int((self.cityMdoel?.data?.count)!)
        }
        return 0
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = getCell(tableView, cell: citySearch_ResultsTabelView.self, indexPath: indexPath)
        cell.selectionStyle = .None
        if self.cityMdoel?.data?.count > 0{
            cell.bind((self.cityMdoel?.data![indexPath.row])!)
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let model = self.cityMdoel?.data![indexPath.row]
        WeatherModel.like((model?.name)!, success: { (model) -> Void in
            self.weatherArray = TMCache.sharedCache().objectForKey(kTMCacheWeatherArray) as! NSMutableArray
            //去重
            var tempBool = true
            for  i in 0  ..< self.weatherArray.count - 1 {
                let models = self.weatherArray[i] as! WeatherModel
                if models.realtime?.city_code == model.realtime?.city_code{
                    self.weatherArray.removeObjectAtIndex(i)
                    self.weatherArray.insertObject(model, atIndex: i)
                    tempBool = false
                }
            }
            if tempBool{
                self.weatherArray.addObject(model)
            }
            TMCache.sharedCache().setObject(self.weatherArray, forKey: kTMCacheWeatherArray)
            
            self.myFunc!(weatherModel:model);
            self.navigationController?.popViewControllerAnimated(true)
            
            }, failure: { (error) -> Void in
        })
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
