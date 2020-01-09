//
//  StudentTableViewCell.swift
//  amazoonia
//
//  Created by Daniel Martinez on 11/12/2019.
//  Copyright © 2019 Amazoonia. All rights reserved.
//

import UIKit

class StudentTableViewCell: UITableViewCell {

    @IBOutlet weak var imageViewCell: UIImageView!
    @IBOutlet weak var nameCell: UILabel!
    @IBOutlet weak var dateCell: UILabel!
    @IBOutlet weak var markImageCell: UIImageView!
    @IBOutlet weak var markImageViewCell: UIImageView!
    @IBOutlet weak var commentImageview: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
