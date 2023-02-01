//
//  GroupsCell.swift
//  SplitBills
//
//  Created by RajaRajeshwari Gundu on 10/23/22.
//

import UIKit

class GroupsCell: UITableViewCell {
    @IBOutlet weak var groupName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

//    var splitmodel : Splitmodel?
//    {
//        didSet
//        {
//            groupName.text = splitmodel?.groupname
//        }
//    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
