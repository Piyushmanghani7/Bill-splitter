//
//  ActivityCell.swift
//  SplitBills
//
//  Created by RajaRajeshwari Gundu on 11/22/22.
//

import UIKit

class ActivityCell: UITableViewCell {

    
    @IBOutlet weak var status: UILabel!
    
    @IBOutlet weak var amount: UILabel!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var Activitytype: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
