//
//  MemberTableViewCell.swift
//  SplitBills
//
//  Created by RajaRajeshwari Gundu on 10/28/22.
//

import UIKit

class MemberTableViewCell: UITableViewCell {
    @IBOutlet weak var memberName: UILabel!
    
    @IBOutlet weak var memberEmail: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
