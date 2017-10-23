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

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var nowVisitingStore: UILabel!
    @IBOutlet var nowVisitingView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkRoutes()
        
        let magazaLocation = CLLocation(latitude: 50.0, longitude: 0.15)
        
        checkLocation(magazaLocation: magazaLocation)
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
    
    func checkRoutes()  {
        
        if let authToken = UserDefaults.standard.string(forKey: "authToken") {
            
            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(authToken)",
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
        
    }
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func workingStoreDetail(_ sender: UIButton) {
        
    }
    
    //TableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sampleStoreData.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        switch section {
        case 0:
            return "Bugünün Ziyaretleri"
        default:
            return nil
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell", for: indexPath) as! MainTableViewCell
        
        //cell.storeName.text = storeData[indexPath.row]["storeName"] as String!
        //cell.workingTime.text = storeData[indexPath.row]["staringTime"]! + "-" + storeData[indexPath.row]["endingTime"]!
        
        cell.storeData = sampleStoreData[indexPath.row]
        
        return cell
    }


}


