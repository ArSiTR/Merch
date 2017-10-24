//
//  ViewController.swift
//  Merch
//
//  Created by Burak Erdem on 30.09.2017.
//  Copyright © 2017 Burak Erdem. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftLocation
import CoreLocation
import Default

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var nowVisitingStore: UILabel!
    @IBOutlet var nowVisitingView: UIView!
    @IBOutlet var helloLabel: UILabel!
    
    //Test Func için?
    var routesArray = [RoutePlan]()
    
    var routeDictionary = [String: [RoutePlan]]()
    var routeSectionTitles = [String]()
    var routesArrayLast = [RoutePlan]()
    
    var authToken: String = "" {
        didSet {
            checkRoutes(token: authToken)
        }
    }
    
    var userProfileData: UserProfile? {
        didSet {
            self.helloLabel.text = "Merhaba, \(userProfileData!.firstname)"
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let tokenData = UserDefaults.standard.df.fetch(forKey: key_authToken, type: AuthToken.self) {
            
            self.authToken = tokenData.authToken
            
        }
        
        if let userProfile = UserDefaults.standard.df.fetch(forKey: key_userProfile, type: UserProfile.self) {
            
            self.userProfileData = userProfile
            
        }
        
        let magazaLocation = CLLocation(latitude: 50.0, longitude: 0.15)
        
        checkLocation(magazaLocation: magazaLocation)
        
        test()
    }
    
    func test() {
        
        let url = Bundle.main.url(forResource: "Data", withExtension: "json")
        let data = NSData.init(contentsOf: url!)
        
        
        //var routesArray = [RoutePlan]()
        
        let json = JSON(data)
        
        
        print(json["data"]["data"])
        
        let array: [JSON] = json["data"]["data"].arrayValue
        
        array.forEach { json in
            
            let storeData = StoreDataRoute(store_id: json["data"]["store_id"].intValue, store_name: json["data"]["store_name"].stringValue, store_lat: json["data"]["store_lat"].stringValue, store_long: json["data"]["store_lat"].stringValue)
            
            let dateAndTime = "\(json["date"].stringValue) \(json["start_time"].stringValue)-\(json["end_time"].stringValue)"
            
            let routes = RoutePlan(date: json["date"].stringValue, start_time: json["start_time"].stringValue, end_time: json["end_time"].stringValue, dateAndTime: dateAndTime, store: storeData)
            
            routesArray.append(routes)
            
        }
        
        for route in routesArray {
            let routeDate = String(route.date)
            if var routeDateValue = routeDictionary[routeDate] {
                routeDateValue.append(route)
                routeDictionary[routeDate] = routeDateValue
            } else {
                routeDictionary[routeDate] = [route]
            }
        }
        
        routeSectionTitles = [String](routeDictionary.keys)
        routeSectionTitles = routeSectionTitles.sorted(by: { $0 < $1 })
        
        
        //let a = routesArray.sort(by: { $0.start_time > $1.start_time })
        let b = routesArray.sorted(by:
        {
            ($0.date, $0.start_time) <
                ($1.date, $1.start_time)
            
        })
        b.forEach { a in
            print(a)
            
        }
        
        
    }
    
    func checkLocation(magazaLocation: CLLocation) {

        let locationManager = Location.getLocation(withAccuracy: .block, frequency: .oneShot, onSuccess: { (location) in
            // Your desidered CLLocation is here, at specified accuracy with auth request managed for you
            
            if location.distance(from: magazaLocation) < 170000 {
                self.nowVisitingView.isHidden = false
            } else {
                self.nowVisitingView.isHidden = true
            }

            
            print(location.distance(from: magazaLocation))
            
            
            
        }, onError: { (location, error)  in
            // Your desidered CLLocation is here, at specified accuracy with auth request managed for you
            
            print(error)
        })
        
        locationManager.start()
        
    }
    
    func checkRoutes(token : String)  {
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
            "Accept": "application/json"
        ]
        
        Alamofire.request(URL_API_routes, headers: headers).responseJSON { response in
            
            if response.error == nil {
                let json = JSON(response.result.value!)
                
                if json["status_code"].double == 0 {
                    
                    print(json)
                    
                    
                } else {
                    print(json)
                }
                
            } else {
                print(response.error!)
            }
        }
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func workingStoreDetail(_ sender: UIButton) {
        
    }
    
    func resetAuthToken() {
        
        let token = AuthToken(authToken: "-")
        
        UserDefaults.standard.df.store(token, forKey: key_authToken)
        
    }
    
    
    // MARK: Location Manager
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        
        // Call stopUpdatingLocation() to stop listening for location updates,
        // other wise this function will be called every time when user location changes.
        
        // manager.stopUpdatingLocation()
        
        print("user latitude = \(userLocation.coordinate.latitude)")
        print("user longitude = \(userLocation.coordinate.longitude)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }
    
    //MARK: TableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        //return 1
        return routeSectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return sampleStoreData.count
        let routeKey = routeSectionTitles[section]
        if let routeValue = routeDictionary[routeKey] {
            return routeValue.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        /*switch section {
        case 0:
            return "Bugünün Ziyaretleri"
        default:
            return nil
        }*/
        var dateTitle = ""
        let dateRawArray : [String] = routeSectionTitles[section].components(separatedBy: "-")
        
        if dateRawArray.count == 3 {
            dateTitle = dateRawArray[2] + "/" + dateRawArray[1] + "/" + dateRawArray[0]
        }
        
        
        
        return dateTitle
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell", for: indexPath) as! MainTableViewCell
        
        //cell.storeName.text = storeData[indexPath.row]["storeName"] as String!
        //cell.workingTime.text = storeData[indexPath.row]["staringTime"]! + "-" + storeData[indexPath.row]["endingTime"]!
        
        //cell.storeData = sampleStoreData[indexPath.row]
        
        let rotueDateKey = routeSectionTitles[indexPath.section]
        if let routeValues = routeDictionary[rotueDateKey] {
            cell.routeData = routeValues[indexPath.row]
        }
        
        return cell
    }
    

    @IBAction func signOutButtonPressed(_ sender: UIButton) {
        
        /////
        
        resetAuthToken()
        
        performSegue(withIdentifier: "returnLoginView", sender: self)
        
        
    }
    
}


