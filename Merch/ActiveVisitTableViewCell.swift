//
//  ActiveVisitTableViewCell.swift
//  Merch
//
//  Created by Burak Erdem on 1.10.2017.
//  Copyright © 2017 Burak Erdem. All rights reserved.
//

import UIKit

class ActiveDSATableViewCell: UITableViewCell {
    
    @IBOutlet var urunAdi:UILabel!
    @IBOutlet var type:UILabel!
    @IBOutlet var anlasma:UILabel!
    
    var dsaData:[String:String] = [:] {
        didSet{
            urunAdi.text = dsaData["urunAdi"]
            type.text = dsaData["type"]
            anlasma.text = dsaData["anlasma"]
            
            print("setted")
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

class DeactiveDSATableViewCell: UITableViewCell {
    
    @IBOutlet var urunAdi:UILabel!
    @IBOutlet var type:UILabel!
    @IBOutlet var anlasmaTarihi:UILabel!
    
    var dsaData:[String:String] = [:] {
        didSet{
            urunAdi.text = dsaData["urunAdi"]
            type.text = dsaData["type"]
            anlasmaTarihi.text = dsaData["anlasmaTarih"]
            
            print("setted")
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
