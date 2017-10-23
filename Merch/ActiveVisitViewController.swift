//
//  ActiveVisitViewController.swift
//  Merch
//
//  Created by Burak Erdem on 1.10.2017.
//  Copyright © 2017 Burak Erdem. All rights reserved.
//

import UIKit

class ActiveVisitViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView:UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //TableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return activeDsaData.count
        case 1:
            return deactiveDsaData.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Yapılmış Tehşirler"
        case 1:
            return "Yapılmamış Anlaşmalı Tehşirler"
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "activeDSACell", for: indexPath) as! ActiveDSATableViewCell
            
            cell.dsaData = activeDsaData[indexPath.row]
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "deactiveDSACell", for: indexPath) as! DeactiveDSATableViewCell
            
            cell.dsaData = deactiveDsaData[indexPath.row]
            
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DSA")
            
            return cell!
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
