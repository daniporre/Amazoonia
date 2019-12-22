//
//  SingInViewController.swift
//  amazoonia
//
//  Created by Daniel Martinez on 12/12/2019.
//  Copyright © 2019 Amazoonia. All rights reserved.
//

import UIKit
import CoreData

class SingInViewController: UIViewController {
    
    var container: NSPersistentContainer!
    var profesores = [Profesor]()

    @IBOutlet weak var singInButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var secondPasswordTextField: UITextField!
    @IBOutlet weak var showPasswordButton: UIButton!
    @IBOutlet weak var secondShowPasswordButton: UIButton!
    @IBOutlet weak var helpButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        createContainer()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadSavedData()
    }
    
    func createContainer() {
        container = NSPersistentContainer(name: "Students")
        
        
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                print("Unresolved error \(error)")
            }
        }

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
        let sort = NSSortDescriptor(key: "name", ascending: true)
        request.sortDescriptors = [sort]
        
        do {
            profesores = try container.viewContext.fetch(request)
            
            for profesor in profesores {
                print("Profesor numero: \(profesor.user)")
            }
            print("Got \(profesores.count) profesores")
        } catch {
            print("fetch failed")
        }
        
    }
    

    
    func setUpView(){
        self.singInButton.layer.cornerRadius = 10
        self.helpButton.layer.cornerRadius = 10
        self.passwordTextField.isSecureTextEntry = true
        self.secondPasswordTextField.isSecureTextEntry = true
        setIconTextField(foto: #imageLiteral(resourceName: "user"), textfield: nameTextField)
        setIconTextField(foto: #imageLiteral(resourceName: "mail"), textfield: mailTextField)
        self.nameTextField.delegate = self
        self.mailTextField.delegate = self
        self.passwordTextField.delegate = self
        self.secondPasswordTextField.delegate = self
        self.navigationItem.leftBarButtonItem?.image = #imageLiteral(resourceName: "cancel").withRenderingMode(.alwaysTemplate)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        showPasswordButton.setImage(#imageLiteral(resourceName: "hidePassword").withRenderingMode(.alwaysTemplate), for: .selected)
        showPasswordButton.setImage(#imageLiteral(resourceName: "showPassword").withRenderingMode(.alwaysTemplate), for: .normal)
        secondShowPasswordButton.setImage(#imageLiteral(resourceName: "hidePassword").withRenderingMode(.alwaysTemplate), for: .selected)
        secondShowPasswordButton.setImage(#imageLiteral(resourceName: "showPassword").withRenderingMode(.alwaysTemplate), for: .normal)
        showPasswordButton.tintColor = #colorLiteral(red: 0.2779085934, green: 0.3907533586, blue: 0.2644636631, alpha: 1)
        secondShowPasswordButton.tintColor = #colorLiteral(red: 0.2779085934, green: 0.3907533586, blue: 0.2644636631, alpha: 1)
//        singInButton.isEnabled = false
    }
    
    @IBAction func singInButton(_ sender: UIButton) {
        let request = Profesor.createFetchRequest()
        
        
        if (nameTextField.text?.isEmpty)! || (mailTextField.text?.isEmpty)! || (passwordTextField.text?.isEmpty)! || (secondPasswordTextField.text?.isEmpty)! {
            lanzarAlertaConUnBoton(viewController: self, title: "Campos incompletos", message: "Debes de rellenar todos los campos para poder registrarte en Amazoonia", buttonText: "Aceptar", buttonType: .default)
            return
        }
        
        do {
            profesores = try container.viewContext.fetch(request)
            
            if profesores.contains(where: {$0.user.lowercased() == (self.mailTextField.text!).lowercased()}) {
                
                lanzarAlertaConUnBoton(viewController: self, title: "Usuario no disponible", message: "El usuario introducido ya existe, escoge otro", buttonText: "Aceptar", buttonType: .cancel)
                return
                
            } else {
                
                
                if passwordTextField.text! != secondPasswordTextField.text! {
                    lanzarAlertaConUnBoton(viewController: self, title: "Las contraseñas no coinciden", message: "", buttonText: "Aceptar", buttonType: .cancel)
                    return
                }
                
                let profesor = Profesor(context: self.container.viewContext)
                profesor.name = nameTextField.text!
                profesor.user = mailTextField.text!
                profesor.password = passwordTextField.text!
                
                self.saveContext()
                
                lanzarAlertaConUnBoton(viewController: self, title: "Profesor registrado", message: "El profesor se ha registrado correctamente en Amazoonia", buttonText: "Aceptar", buttonType: .cancel)
            }
            
            print("Got \(profesores.count) profesores")
        } catch {
            print("fetch failed")
        }
    }
    
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Cancelar", message: "¿Está seguro/a de que no quiere registrar este profesor?", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "No registrar", style: .destructive) { (UIAlertAction) in
            self.dismiss(animated: true, completion: nil)
        }
        let cancel = UIAlertAction(title: "Cancelar", style: .cancel) { (UIAlertAction) in
            
        }
        
        alertController.addAction(cancel)
        alertController.addAction(ok)
        
        present(alertController, animated: true)
    }
    
    @IBAction func helpButton(_ sender: UIButton) {
        
        if let url = URL(string: "https://amaazoniaapp.blogspot.com/2019/12/ayuda-con-registro-para-profesores-en.html") {
            if #available(iOS 10, *){
                UIApplication.shared.open(url)
            }else{
                UIApplication.shared.openURL(url)
            }
            
        }
        
        
    }
    
    @IBAction func showPasswordButton(_ sender: UIButton) {
        self.passwordTextField.isSecureTextEntry = !self.passwordTextField.isSecureTextEntry
        
        if passwordTextField.isSecureTextEntry {
            showPasswordButton.isSelected = false
            showPasswordButton.tintColor = #colorLiteral(red: 0.2779085934, green: 0.3907533586, blue: 0.2644636631, alpha: 1)
        }
        if passwordTextField.isSecureTextEntry == false {
            showPasswordButton.isSelected = true
            showPasswordButton.tintColor = #colorLiteral(red: 0.2779085934, green: 0.3907533586, blue: 0.2644636631, alpha: 1)
        }
    }
    
    @IBAction func secondShowPasswordButton(_ sender: UIButton) {
        self.secondPasswordTextField.isSecureTextEntry = !self.secondPasswordTextField.isSecureTextEntry
        
        if secondPasswordTextField.isSecureTextEntry {
            secondShowPasswordButton.isSelected = false
            secondShowPasswordButton.tintColor = #colorLiteral(red: 0.2779085934, green: 0.3907533586, blue: 0.2644636631, alpha: 1)
        }
        if secondPasswordTextField.isSecureTextEntry == false {
            secondShowPasswordButton.isSelected = true
            secondShowPasswordButton.tintColor = #colorLiteral(red: 0.2779085934, green: 0.3907533586, blue: 0.2644636631, alpha: 1)
        }
    }
    
//    func addImage(image: UIImage) -> UIImage! {
//        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
//        let image = image.withRenderingMode(.alwaysTemplate)
//        imageView.image = image
//        imageView.tintColor = UIColor.darkGray
//        return imageView.image
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}

//MARK: - Textfields
extension SingInViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == nameTextField {
            setEmptyViewTextField(textfield: nameTextField)
        }
        if textField == mailTextField {
            setEmptyViewTextField(textfield: mailTextField)
        }
        
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        setIconTextField(foto: #imageLiteral(resourceName: "user"), textfield: nameTextField)
        setIconTextField(foto: #imageLiteral(resourceName: "mail"), textfield: mailTextField)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTextField {
            mailTextField.becomeFirstResponder()
        }
        if textField == mailTextField {
            passwordTextField.becomeFirstResponder()
        }
        if textField == passwordTextField {
            secondPasswordTextField.becomeFirstResponder()
        }
        if textField == secondPasswordTextField {
            return textField.resignFirstResponder()
        }
        return true
    }
    
}
