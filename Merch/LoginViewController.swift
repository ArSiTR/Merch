//
//  LoginViewController.swift
//  Merch
//
//  Created by Burak Erdem on 8.10.2017.
//  Copyright © 2017 Burak Erdem. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LoginViewController: UIViewController {

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        //print(UserDefaults.standard.dictionary(forKey: "userProfile"))
        
        /*if let userProfile = UserDefaults.standard.dictionary(forKey: "userProfile") {
            
            print(userProfile["firstname"])
            
            //userProfile["firstname"]
            
            
        } */
        
        // Do any additional setup after loading the view.
        
        checkAuthToken()
        
        
    }
    
    func checkAuthToken() {

        if let authToken = UserDefaults.standard.string(forKey: "authToken") {
            
            print(authToken)
            
            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(authToken)",
                "Accept": "application/json"
            ]
            
            Alamofire.request(URL_API_profile, headers: headers).responseJSON { response in
                
                if response.error == nil {
                    let json = JSON(response.result.value!)
                    
                    if json["status_code"].double == 0 {
                        let userProfile = json["data"].dictionaryObject
                        
                        UserDefaults.standard.set(userProfile, forKey: "userProfile")
                        
                        if json["data"]["user_type"] == "MERCH" {
                            self.performSegue(withIdentifier: "loginMerch", sender: self)
                        } else {
                            // TO-DO
                            UserDefaults.standard.set("", forKey: "authToken")
                        }
                        
                    } else {
                        print(json)
                    }
                    
                } else {
                    print(response.error!)
                }
                

            }
            
        }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        
        let parameters: Parameters = [
            "email": emailTextField.text!,
            "password": passwordTextField.text!
        ]
        
        // All three of these calls are equivalent
        Alamofire.request(URL_API_login, method: .post, parameters: parameters).responseJSON { response in
        
            if response.error == nil {
                let json = JSON(response.result.value!)
                
                if json["error_code"].double == 0 {
                    
                    let token = json["data"]["token"].string
                    UserDefaults.standard.set(token, forKey: "authToken")
                    
                    DispatchQueue.main.async {
                        self.checkAuthToken()
                    }
                    
                    
                    
                } else {
                    print(json)
                }
                

            } else {
                //print(response.error!)
            }
        }

    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
