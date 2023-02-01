//
//  DetailedGroupCell.swift
//  SplitBills
//
//  Created by RajaRajeshwari Gundu on 10/23/22.
//

import UIKit

class DetailedGroupCell: UITableViewCell {

    @IBOutlet weak var expensesName: UILabel!
    
    @IBOutlet weak var statuslbl: UILabel!
    
    @IBOutlet weak var Amount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
