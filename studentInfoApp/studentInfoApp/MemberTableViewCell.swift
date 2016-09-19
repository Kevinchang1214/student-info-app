//
//  MemberTableViewCell.swift
//  KevinChangHw3
//
//  Created by Kevin Chang on 9/18/16.
//  Copyright © 2016 Kevin Chang. All rights reserved.
//

import UIKit

class MemberTableViewCell: UITableViewCell {
    //MARK: Properties
    
    @IBOutlet weak var memberPhoto: UIImageView!
    @IBOutlet weak var memberHometown: UILabel!
    @IBOutlet weak var memberName: UILabel!

    @IBOutlet weak var memberMajor: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
