//
//  StudentTableViewCell.swift
//  KevinChangHw3
//
//  Created by Kevin Chang on 9/15/16.
//  Copyright © 2016 Kevin Chang. All rights reserved.
//

import UIKit

class StudentTableViewCell:UITableViewCell {
    
    //Mark: Properties
@IBOutlet weak var myNameField: UILabel!
    @IBOutlet weak var myProfilePhoto: UIImageView!

    @IBOutlet weak var myMajor: UITextView!

    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
