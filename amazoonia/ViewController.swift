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
    
    //MARK: - ATTRIBUTES
    var container: NSPersistentContainer!
    var fetchResultsController: NSFetchedResultsController<Profesor>!
    var fetchResultsController2: NSFetchedResultsController<Alumno>!

    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        createContainer()
        
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "dd-MM-yyyy"
        let formattedDate = format.string(from: date)
        
        
        print(Calendar.current.component(.day, from: date))

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        self.checkForGrantedPermissions()
        loadTeacherSavedData()
        loadStudentSavedData()
        self.textFieldUser.text! = ""
        self.textFieldPassword.text! = ""
        self.view.endEditing(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.view.endEditing(true)
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        auntenticacion()
    }
    
    //MARK: - SINGINBUTTON
    @IBAction func singInButton(_ sender: UIButton) {
        
        let alertController = UIAlertController(title: "Auntenticación profesores", message: "Introduzca la contraseña del profesorado para poder registrarte", preferredStyle: .alert)
        
        alertController.addTextField { (textFieldAlert) in
            textFieldAlert.placeholder = "Introduce la contraseña"
            textFieldAlert.isSecureTextEntry = true
            textFieldAlert.borderStyle = .none
            textFieldAlert.delegate = self
        }
        
        let ok = UIAlertAction(title: "Entrar", style: .default) { (UIAlertAction) in
            
            
            if alertController.textFields?.first?.text == "contraseñaProfesores" {
                self.performSegue(withIdentifier: "backToLogIn", sender: nil)
            } else {
                lanzarAlertaConTiempo(viewController: self, titulo: "Contraseña incorrecta", mensaje: "La contraseña introducida no es correcta, inténtelo de nuevo", segundos: 2)
            }
            
        }
        
        let cancel = UIAlertAction(title: "Cancelar", style: .cancel) { (UIAlertAction) in
            
        }
        
        alertController.addAction(ok)
        alertController.addAction(cancel)
        
        self.present(alertController, animated: true)
        
    }
    
//
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "inicioProfesor"){
            let viewDestiny = segue.destination as? TeacherViewController
            viewDestiny?.profesor = self.profesor
            viewDestiny?.container = self.container
            self.navigationItem.title = self.profesor?.user.capitalized

        }
        
        if(segue.identifier == "inicioAlumno"){
            let viewDestiny = segue.destination as? StudentViewController
            viewDestiny?.alumno = self.alumno
            viewDestiny?.container = self.container
        }
    }
    
    
    //MARK: - AUNTENTICACION
    func auntenticacion () {

        if (textFieldUser.text?.isEmpty)! || (textFieldPassword.text?.isEmpty)! {
            lanzarAlertaConUnBoton(viewController: self, title: "Campos incompletos", message: "Rellena todos los campos para iniciar sesión", buttonText: "Aceptar", buttonType: .default)
            return
        }
        
        if segmentedControl.selectedSegmentIndex == 0 {
            if let profesor = profesores.first(where: {$0.user.lowercased() == textFieldUser.text?.lowercased()}) {
                if profesor.password == textFieldPassword.text! {
                    self.profesor = profesor
                    print(profesor.name)
                    print(profesor.password)
                    print("------------ Inicio de sesión correcto (Profesor) ------------")
                    performSegue(withIdentifier: "inicioProfesor", sender: nil)
                    
                } else {
                    lanzarAlertaConUnBoton(viewController: self, title: "Usuario o contraseña incorrectos", message: "El usuario o la contraseña introducidos son incorrectos", buttonText: "Aceptar", buttonType: .cancel)
                    return
                }
                return
            } else {
                lanzarAlertaConUnBoton(viewController: self, title: "Usuario o contraseña incorrectos", message: "El usuario o la contraseña introducidos son incorrectos", buttonText: "Aceptar", buttonType: .cancel)
                return
            }
        }
        
        if segmentedControl.selectedSegmentIndex == 1 {
            if let alumno = alumnos.first(where: {$0.user.lowercased() == textFieldUser.text?.lowercased()}) {
                if alumno.password == textFieldPassword.text! {
                    self.alumno = alumno
                    print(alumno.name)
                    print(alumno.password)
                    print("------------ Inicio de sesión correcto (Alumno) ------------")
                    performSegue(withIdentifier: "inicioAlumno", sender: nil)
                    
                } else {
                    lanzarAlertaConUnBoton(viewController: self, title: "Usuario o contraseña incorrectos", message: "El usuario o la contraseña introducidos son incorrectos", buttonText: "Aceptar", buttonType: .cancel)
                    return
                }
                return
            } else {
                lanzarAlertaConUnBoton(viewController: self, title: "Usuario o contraseña incorrectos", message: "El usuario o la contraseña introducidos son incorrectos", buttonText: "Aceptar", buttonType: .cancel)
                return
            }
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
//
//        let request = Profesor.createFetchRequest()
//
//
//
//
//        do {
//            profesores = try container.viewContext.fetch(request)
//
//            if profesores.contains(where: {$0.user.lowercased() == (self.textFieldUser.text!).lowercased()}) {
//
//                let alertController = UIAlertController(title: "Error", message: "El usuario ya existe", preferredStyle: .alert)
//
//                let ok = UIAlertAction(title: "Aceptar", style: .cancel) { (UIAlertAction) in
//
//                }
//
//                alertController.addAction(ok)
//                present(alertController, animated: true)
//                return
//
//            } else {
//
//                let alertController = UIAlertController(title: "Profesor registrado", message: "El profesor se ha registrado correctamente en Amazoonia", preferredStyle: .alert)
//
//                let ok = UIAlertAction(title: "Aceptar", style: .cancel) { (UIAlertAction) in
//                    self.dismiss(animated: true, completion: nil)
//                }
//
//                alertController.addAction(ok)
//                present(alertController, animated: true)
//            }
//
//            print("Got \(profesores.count) profesores")
//        } catch {
//            print("fetch failed")
//        }
        
        
        
        
        
    }
    
    
    @IBAction func showPasswordButton(_ sender: UIButton) {
        self.textFieldPassword.isSecureTextEntry = !self.textFieldPassword.isSecureTextEntry
        
        if textFieldPassword.isSecureTextEntry {
            showPasswordButton.isSelected = false
        }
        if textFieldPassword.isSecureTextEntry == false {
            showPasswordButton.isSelected = true
        }
    }
    
    
    

}

//MARK: - CORE DATA CONFIGURATIONS
extension ViewController {
    
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
    
    func loadTeacherSavedData() {
        
        let request = Profesor.createFetchRequest()
        let sort = NSSortDescriptor(key: "name", ascending: true)
        request.sortDescriptors = [sort]
        
        do {
            profesores = try container.viewContext.fetch(request)
            
            for profesor in profesores {
                print("Profesor numero: \(profesor.user)")
            }
            
            print(profesores)
            print("Got \(profesores.count) profesores")
        } catch {
            print("fetch failed")
        }
        
    }
    
    func loadStudentSavedData() {
        
        let requestAlumno: NSFetchRequest<Alumno> = Alumno.fetchRequest()
        let sort = NSSortDescriptor(key: "name", ascending: true)
        requestAlumno.sortDescriptors = [sort]
        
        do {
            alumnos = try container.viewContext.fetch(requestAlumno)
            
            for profesor in profesores {
                print("Profesor numero: \(profesor.user)")
            }
            
            print(profesores)
            print("Got \(profesores.count) profesores")
        } catch {
            print("fetch failed")
        }
        
    }
    
    func deleteStudent(user: String) {
        let context = container.viewContext
        let requestAlumno: NSFetchRequest<Alumno> = Alumno.fetchRequest()
        
        do {
            alumnos = try container.viewContext.fetch(requestAlumno)
            
            for alumno in alumnos {
                if alumno.user == user {
                    context.delete(alumno)
                    saveContext()
                }
            }
        } catch {
            print("fetch failed")
        }
        
    }
    
    func deleteTeacher(user: String) {
        let context = container.viewContext
        let request = Profesor.createFetchRequest()
        
        do {
            profesores = try container.viewContext.fetch(request)
            
            for profesor in profesores {
                if profesor.user == user {
                    context.delete(profesor)
                    saveContext()
                }
            }
        } catch {
            print("fetch failed")
        }
        
    }
    
    func loadTeacher(user: String) -> Profesor? {
        let request = Profesor.createFetchRequest()
        
        do {
            profesores = try container.viewContext.fetch(request)
            
            for profesor in profesores {
                if profesor.user == user {
                    return profesor
                }
            }
        } catch {
            print("fetch failed")
        }
        return profesor
    }
    
}

//MARK: - PERMISIONS AND SETUPS
extension ViewController {
    
    func setUpView() {
        configTextFieldsButton()
        self.textFieldUser.delegate = self
        self.textFieldPassword.delegate = self
        setIconTextField(foto: #imageLiteral(resourceName: "user"), textfield: textFieldUser, tintColor: #colorLiteral(red: 0.2779085934, green: 0.3907533586, blue: 0.2644636631, alpha: 1))
        showPasswordButton.tintColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
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
        
        if textField == textFieldUser || textField == textFieldPassword {
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: [], animations: {
                
                self.backgroundView.transform = CGAffineTransform(translationX: 0, y: -110.0)
                if textField == self.textFieldUser {
                    self.textFieldUserView.backgroundColor = #colorLiteral(red: 1, green: 0.8705882353, blue: 0.3490196078, alpha: 1)
                    setIconTextField(foto: #imageLiteral(resourceName: "user"), textfield: self.textFieldUser, tintColor: #colorLiteral(red: 1, green: 0.9058823529, blue: 0.3411764706, alpha: 1))
                }
                if textField == self.textFieldPassword {
                    self.textFieldPasswordView.backgroundColor = #colorLiteral(red: 1, green: 0.8705882353, blue: 0.3490196078, alpha: 1)
                    self.showPasswordButton.tintColor = #colorLiteral(red: 1, green: 0.9058823529, blue: 0.3411764706, alpha: 1)
                }
                
            }, completion: nil)
        }
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == textFieldPassword {
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: [], animations: {
                
                self.backgroundView.transform = CGAffineTransform(translationX: 0, y: 0)
                self.showPasswordButton.tintColor = #colorLiteral(red: 0.2779085934, green: 0.3907533586, blue: 0.2644636631, alpha: 1)
            }, completion: nil)
        }
        if textField == self.textFieldUser {
            self.textFieldUserView.backgroundColor = #colorLiteral(red: 0.2779085934, green: 0.3907533586, blue: 0.2644636631, alpha: 1)
        }
        if textField == self.textFieldPassword {
            self.textFieldPasswordView.backgroundColor = #colorLiteral(red: 0.2779085934, green: 0.3907533586, blue: 0.2644636631, alpha: 1)
        }
        
        setIconTextField(foto: #imageLiteral(resourceName: "user"), textfield: textFieldUser, tintColor: #colorLiteral(red: 0.2779085934, green: 0.3907533586, blue: 0.2644636631, alpha: 1))
        
        
    }
    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//
//        if ((range.location == 4 && range.length == 0) || (range.location == 5 && range.length == 1)) {
//            alertController.actions[1].isEnabled = true
//        }else{
//            self.alertController.actions[1].isEnabled = false
//        }
//
//        return true;
//    }
    
}

