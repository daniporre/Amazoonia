//
//  TeacherTableViewCell.swift
//  amazoonia
//
//  Created by Daniel Martinez on 03/12/2019.
//  Copyright © 2019 Amazoonia. All rights reserved.
//

import UIKit

class TeacherTableViewCell: UITableViewCell {

    @IBOutlet weak var imageViewCell: UIImageView!
    @IBOutlet weak var nameCell: UILabel!
    @IBOutlet weak var numExpCell: UILabel!
    @IBOutlet weak var backGroundCell: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
