//
//  GuestsTableViewCell.swift
//  Hostess
//
//  Created by Archita Bansal on 17/04/16.
//  Copyright © 2016 Archita Bansal. All rights reserved.
//

import UIKit

class GuestsTableViewCell: UITableViewCell {

   
    @IBOutlet weak var guestsSwitch: UISwitch!
    
    @IBOutlet weak var txtToDoName: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    


}
