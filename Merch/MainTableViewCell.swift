//
//  MainTableViewCell.swift
//  Merch
//
//  Created by Burak Erdem on 1.10.2017.
//  Copyright © 2017 Burak Erdem. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    @IBOutlet var storeName: UILabel!
    @IBOutlet var workingTime: UILabel!
    
    var routeData:RoutePlan? {
        didSet
        {
            storeName.text = routeData!.store.store_name
            workingTime.text = routeData!.start_time + "-" + routeData!.end_time
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
