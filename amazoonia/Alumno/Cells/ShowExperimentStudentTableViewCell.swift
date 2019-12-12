//
//  ShowExperimentStudentTableViewCell.swift
//  amazoonia
//
//  Created by Daniel Martinez on 12/12/2019.
//  Copyright © 2019 Amazoonia. All rights reserved.
//

import UIKit

class ShowExperimentStudentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var backgroundViewCell: UIView!
    @IBOutlet weak var titleCell: UILabel!
    @IBOutlet weak var examplesLabelCell: UILabel!
    @IBOutlet weak var imageExperimentCell: UIImageView!
    @IBOutlet weak var backgroundImageCell: UIImageView!
    @IBOutlet weak var blurViewCell: UIVisualEffectView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
