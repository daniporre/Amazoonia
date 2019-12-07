//
//  ViewController.swift
//  amazoonia
//
//  Created by Daniel Martinez on 26/11/2019.
//  Copyright © 2019 Amazoonia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textFieldUser: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var showPasswordButton: UIButton!
    
    @IBOutlet weak var topConstraintView: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraintView: NSLayoutConstraint!
    
    
    
    var topConstantContraint: CGFloat = 0
    var bottomConstantConstraint: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textFieldUser.delegate = self
        self.textFieldPassword.delegate = self
        
        
        topConstantContraint = self.topConstraintView.constant
        bottomConstantConstraint = self.bottomConstraintView.constant
        configTextFieldsButton()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func configTextFieldsButton() {
        
        self.loginButton.layer.cornerRadius = 10
        self.textFieldPassword.isSecureTextEntry = true
        
        showPasswordButton.setImage(#imageLiteral(resourceName: "hidePassword").withRenderingMode(.alwaysTemplate), for: .selected)
        showPasswordButton.setImage(#imageLiteral(resourceName: "showPassword").withRenderingMode(.alwaysTemplate), for: .normal)
        showPasswordButton.tintColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
    }
    
    func setBackButton(viewController: UIViewController, nombreImagen: String){
        let backImage = UIImage(named: nombreImagen)
        viewController.navigationController?.navigationBar.backIndicatorImage = backImage
        viewController.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        viewController.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil,                                                             action:nil)
    }
    
    
    
    @IBAction func loginButton(_ sender: UIButton) {
    }
    
    @IBAction func showPasswordButton(_ sender: UIButton) {
        self.textFieldPassword.isSecureTextEntry = !self.textFieldPassword.isSecureTextEntry
        
        if textFieldPassword.isSecureTextEntry {
            showPasswordButton.isSelected = false
            showPasswordButton.tintColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        }
        if textFieldPassword.isSecureTextEntry == false {
            showPasswordButton.isSelected = true
            showPasswordButton.tintColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        self.topConstraintView.constant = self.topConstraintView.constant - 100
        self.bottomConstraintView.constant = self.bottomConstraintView.constant - 100
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
//        self.textFieldsTopConstraint.constant = constantContraint
        
        if textFieldUser.isEditing {
            return
        }
        if textFieldPassword.isEditing {
            return
        }
        if textFieldUser.isEditing == false && textFieldPassword.isEditing == false {
//            self.topConstraintView.constant = topConstantContraint
//            self.bottomConstraintView.constant = bottomConstantConstraint
        }
        
        if textField == textFieldPassword && !textFieldPassword.isEditing {
            self.topConstraintView.constant = topConstantContraint
            self.bottomConstraintView.constant = bottomConstantConstraint

        }
        if textField == textFieldUser && !textFieldUser.isEditing {
            self.topConstraintView.constant = topConstantContraint
            self.bottomConstraintView.constant = bottomConstantConstraint
        }
        
    }
    
}

