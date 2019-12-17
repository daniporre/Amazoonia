//
//  Funcs.swift
//  amazoonia
//
//  Created by Daniel Martinez on 12/12/2019.
//  Copyright © 2019 Amazoonia. All rights reserved.
//

import Foundation
import UIKit

func setIconTextField(foto: UIImage, textfield: UITextField) {
    textfield.leftViewMode = UITextField.ViewMode.always
    let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
    let image = foto.withRenderingMode(.alwaysTemplate)
    imageView.image = image
    imageView.tintColor = #colorLiteral(red: 0.2779085934, green: 0.3907533586, blue: 0.2644636631, alpha: 1)
    textfield.leftView = imageView
}

func setEmptyViewTextField(textfield: UITextField) {
    textfield.leftViewMode = UITextField.ViewMode.always
    textfield.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
}
