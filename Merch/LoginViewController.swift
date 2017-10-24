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
import Default

class LoginViewController: UIViewController {

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        checkAuthToken()
        
    }
    
    func checkAuthToken() {
        
        if let authTokenData = UserDefaults.standard.df.fetch(forKey: key_authToken, type: AuthToken.self) {
            
            let authToken = authTokenData.authToken
            
            if authToken != "-" {
                
                let headers: HTTPHeaders = [
                    "Authorization": "Bearer \(authToken)",
                    "Accept": "application/json"
                ]
                
                Alamofire.request(URL_API_profile, headers: headers).responseJSON { response in
                    
                    if response.error == nil {
                        let json = JSON(response.result.value!)
                        
                        if json["status_code"].double == 0 {
                            
                            
                            //Buralar hep değişecek!!!
                            let userProfile = UserProfile(id: json["data"]["id"].intValue,
                                                          firstname: json["data"]["firstname"].stringValue,
                                                          lastname: json["data"]["lastname"].stringValue,
                                                          email: json["data"]["email"].stringValue,
                                                          company_id: json["data"]["company_id"].intValue,
                                                          user_type: json["data"]["user_type"].stringValue,
                                                          status: json["data"]["status"].stringValue)
                            
                            UserDefaults.standard.df.store(userProfile, forKey: key_userProfile)
                            
                            if userProfile.status == "ACTIVE" && userProfile.user_type == "MERCH" {
                            
                                self.performSegue(withIdentifier: "loginMerch", sender: self)
                                
                            } else {
                                // TO-DO
                                self.resetAuthToken()
                            }
                            
                        } else {
                            print(json)
                            self.resetAuthToken()
                        }
                        
                    } else {
                        print(response.error!)
                        self.resetAuthToken()
                    }
                    
                    
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
                    
                    
                    let tokenStored = AuthToken(authToken: token ?? "")
                    
                    UserDefaults.standard.df.store(tokenStored, forKey: key_authToken)
                    
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
    
    func resetAuthToken() {
        
        let token = AuthToken(authToken: "-")
        
        UserDefaults.standard.df.store(token, forKey: key_authToken)
        
    }
    
    @IBAction func unwindLoginView(segue:UIStoryboardSegue) { }

}
