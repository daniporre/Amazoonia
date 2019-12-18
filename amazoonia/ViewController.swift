//
//  ViewController.swift
//  amazoonia
//
//  Created by Daniel Martinez on 26/11/2019.
//  Copyright © 2019 Amazoonia. All rights reserved.
//

import UIKit
import CoreData
import Photos


class ViewController: UIViewController {
    
    var container: NSPersistentContainer!
    var profesores = [Profesor]()
    var profesor: Profesor?
    var alumno: Alumno?
    var alumnos = [Alumno]()
    

    @IBOutlet weak var textFieldUser: UITextField!
    @IBOutlet weak var textFieldUserView: UIView!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var textFieldPasswordView: UIView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var showPasswordButton: UIButton!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var singInButton: UIButton!
    @IBOutlet weak var backgroundView: UIView!
    
    @IBOutlet weak var topConstraintView: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraintView: NSLayoutConstraint!
    
    
    var topConstantContraint: CGFloat = 0
    var bottomConstantConstraint: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        createContainer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        self.checkForGrantedPermissions()
        loadSavedData()
        self.textFieldUser.text! = ""
        self.textFieldPassword.text! = ""
    }
    
    func createContainer() {
        container = NSPersistentContainer(name: "Students")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                print("Unresolved error \(error)")
            }
        }
    }
    
    func setUpView() {
        configTextFieldsButton()
        self.textFieldUser.delegate = self
        self.textFieldPassword.delegate = self
        setIconTextField(foto: #imageLiteral(resourceName: "user"), textfield: textFieldUser)
        
    }
    
    func saveContext() {
        if container.viewContext.hasChanges {
            do {
                try container.viewContext.save()
            } catch {
                print("An error ocurred shile saving: \(error)")
            }
        }
    }
    
    
    func loadSavedData() {
        
        let request = Profesor.createFetchRequest()
        let sort = NSSortDescriptor(key: "name", ascending: false)
        request.sortDescriptors = [sort]
        
        do {
            profesores = try container.viewContext.fetch(request)
            print("Got \(profesores.count) profesores")
        } catch {
            print("fetch failed")
        }
        
    }
    
    
    
    func checkForGrantedPermissions() {
        let photosAuth : Bool = PHPhotoLibrary.authorizationStatus() == .authorized
        let authorized = photosAuth
        if !authorized {
            if let vc = storyboard?.instantiateViewController(withIdentifier: "ShowTerms") {
                navigationController?.present(vc, animated: true)
            }
        }
    }
    
    func configTextFieldsButton() {
        
        self.loginButton.layer.cornerRadius = 10
        self.singInButton.layer.cornerRadius = 10
        self.textFieldPassword.isSecureTextEntry = true
        
        showPasswordButton.setImage(#imageLiteral(resourceName: "hidePassword").withRenderingMode(.alwaysTemplate), for: .selected)
        showPasswordButton.setImage(#imageLiteral(resourceName: "showPassword").withRenderingMode(.alwaysTemplate), for: .normal)
        showPasswordButton.tintColor = #colorLiteral(red: 0.2779085934, green: 0.3907533586, blue: 0.2644636631, alpha: 1)
    }
    
    func setBackButton(viewController: UIViewController, nombreImagen: String){
        let backImage = UIImage(named: nombreImagen)
        viewController.navigationController?.navigationBar.backIndicatorImage = backImage
        viewController.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        viewController.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil,                                                             action:nil)
    }
    
    
    
    @IBAction func loginButton(_ sender: UIButton) {
        
        auntenticacion()
        
    }
    
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if(segue.identifier == "inicioProfesor"){
//            let viewDestiny = segue.destination as? TeacherViewController
//            viewDestiny?.profesor = self.profesor
//            self.navigationItem.title = self.profesor?.name
//
//        }
////        if(segue.identifier == "inicioAlumno"){
////            let viewDestiny = segue.destination as? StudentViewController
////            viewDestiny?.alumno = self.profesor
////            self.navigationItem.title = self.profesor?.name
////
////        }
//    }
    
    func auntenticacion () {

        if (textFieldUser.text?.isEmpty)! || (textFieldPassword.text?.isEmpty)! {
            return
        }
        
        if segmentedControl.selectedSegmentIndex == 0 {
            if let profesor = profesores.first(where: {$0.user.lowercased() == textFieldUser.text?.lowercased()}) {
                if profesor.password == textFieldPassword.text! {
                    self.profesor = profesor
                    print(profesor.name)
                    print(profesor.password)
                    performSegue(withIdentifier: "inicioProfesor", sender: nil)
                    
                }
                return
            }
        }
        
        if segmentedControl.selectedSegmentIndex == 1 {
            if let alumno = alumnos.first(where: {$0.user.lowercased() == textFieldUser.text?.lowercased()}) {
                if alumno.password == textFieldPassword.text! {
                    self.alumno = alumno
                    print(alumno.name)
                    print(alumno.password)
                    performSegue(withIdentifier: "inicioAlumno", sender: nil)
                    
                }
                return
            }
        }
        
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



//MARK: - TEXTFIELD
extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == textFieldUser {
            textFieldPassword.becomeFirstResponder()
        }
        if textField == textFieldPassword {
            textFieldPassword.resignFirstResponder()
            if segmentedControl.selectedSegmentIndex == 0 {
                auntenticacion()
            }
            if segmentedControl.selectedSegmentIndex == 1 {
                auntenticacion()
            }
        }
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: [], animations: {
            
//            self.topConstraintView.constant = -4
//            self.bottomConstraintView.constant = 47
            
            self.backgroundView.transform = CGAffineTransform(translationX: 0, y: -110.0)
            if textField == self.textFieldUser {
                self.textFieldUserView.backgroundColor = #colorLiteral(red: 1, green: 0.8705882353, blue: 0.3490196078, alpha: 1)
            }
            if textField == self.textFieldPassword {
                self.textFieldPasswordView.backgroundColor = #colorLiteral(red: 1, green: 0.8705882353, blue: 0.3490196078, alpha: 1)
            }
            
            
        }, completion: nil)
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == textFieldUser {
            setEmptyViewTextField(textfield: textFieldUser)
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == textFieldPassword {
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: [], animations: {
                
                self.backgroundView.transform = CGAffineTransform(translationX: 0, y: 0)
                
            }, completion: nil)
        }
        if textField == self.textFieldUser {
            self.textFieldUserView.backgroundColor = #colorLiteral(red: 0.2779085934, green: 0.3907533586, blue: 0.2644636631, alpha: 1)
        }
        if textField == self.textFieldPassword {
            self.textFieldPasswordView.backgroundColor = #colorLiteral(red: 0.2779085934, green: 0.3907533586, blue: 0.2644636631, alpha: 1)
        }
        
        setIconTextField(foto: #imageLiteral(resourceName: "user"), textfield: textFieldUser)
        
    }
    
}

