//
//  AddNewStudentViewController.swift
//  amazoonia
//
//  Created by Daniel Martinez on 03/12/2019.
//  Copyright © 2019 Amazoonia. All rights reserved.
//

import UIKit

class AddNewStudentViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var nameTextField: UITextField! {
        didSet {
            nameTextField.autocapitalizationType = .words
        }
    }
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var addNewStudentButton: UIButton!
    @IBOutlet weak var showPasswordButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var topConstraintView: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraintView: NSLayoutConstraint!
    
    
    
    var topConstantContraint: CGFloat = 0
    var bottomConstantConstraint: CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        passwordTextField.delegate = self
        configTextFieldsButton()
        
        
        self.navigationItem.leftBarButtonItem?.image = #imageLiteral(resourceName: "cancel").withRenderingMode(.alwaysTemplate)
        topConstantContraint = self.topConstraintView.constant
        bottomConstantConstraint = self.bottomConstraintView.constant

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        
        let alertController = UIAlertController(title: "Cancelar", message: "¿Está seguro/a de que no quiere añadir este alumno/a?", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "No añadir", style: .destructive) { (UIAlertAction) in
            self.dismiss(animated: true, completion: nil)
        }
        let cancel = UIAlertAction(title: "Añadir", style: .cancel) { (UIAlertAction) in
            
        }
        
        alertController.addAction(cancel)
        alertController.addAction(ok)
        
        present(alertController, animated: true)
        
    }
    
    func configTextFieldsButton() {
        
        self.addNewStudentButton.layer.cornerRadius = 10
        self.passwordTextField.isSecureTextEntry = true
        
        showPasswordButton.setImage(#imageLiteral(resourceName: "hidePassword").withRenderingMode(.alwaysTemplate), for: .selected)
        showPasswordButton.setImage(#imageLiteral(resourceName: "showPassword").withRenderingMode(.alwaysTemplate), for: .normal)
        showPasswordButton.tintColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
    }
    
    @IBAction func showPasswordButton(_ sender: UIButton) {
        self.passwordTextField.isSecureTextEntry = !self.passwordTextField.isSecureTextEntry
        
        if passwordTextField.isSecureTextEntry {
            showPasswordButton.isSelected = false
            showPasswordButton.tintColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        }
        if passwordTextField.isSecureTextEntry == false {
            showPasswordButton.isSelected = true
            showPasswordButton.tintColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        }
    }
    
    @IBAction func addNewStudentButton(_ sender: UIButton) {
        
        if (nameTextField.text?.isEmpty)! || (passwordTextField.text?.isEmpty)! {
            return
        }
        
        let alertController = UIAlertController(title: "Añadir nuevo alumno", message: "¿Está seguro/a de que quiere añadir el alumno/a con nombre \(nameTextField.text!) a la lista de clase?", preferredStyle: .actionSheet)
        
        let ok = UIAlertAction(title: "Añadir", style: .default) { (UIAlertAction) in
            self.dismiss(animated: true, completion: nil)
        }
        let cancel = UIAlertAction(title: "No añadir", style: .cancel) { (UIAlertAction) in
            
        }
        
        alertController.addAction(cancel)
        alertController.addAction(ok)
        
        present(alertController, animated: true)
    }
    
    
    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
        alertForSourceType()
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //      Con .editedImage nos quedamos con la foto editada y esa es la que establecemos en imageViewUser.image
        if let theImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.imageView.image = theImage
            //            if(imageView.image != UIImage(named: "addUserImage")){
            //                //Establecemos configuraciones, establecemos la imagen con forma redondeada
            //                imageView.layer.cornerRadius = imageView.frame.width / 2
            //                imageView.layer.borderWidth = 3
            //
            //            }
            let generator = UINotificationFeedbackGenerator()
            generator.prepare()
            generator.notificationOccurred(.success)
            imageView.layer.cornerRadius = imageView.frame.height / 2
            imageView.clipsToBounds = true
            imageView.layer.borderWidth = 4
            imageView.layer.borderColor = #colorLiteral(red: 0.2779085934, green: 0.3907533586, blue: 0.2644636631, alpha: 1)
            dismiss(animated: true, completion: nil)
        }
    }
    
    func alertForSourceType(){
        //Creamos el picker y asignamos su delegado a self
        let picker = UIImagePickerController()
        picker.delegate = self
        //Permite que podamos editar la imagen que escojemos
        picker.allowsEditing = true
        //Creamos el alertControlller con el mensaje el titulo y el tipo de alerta, en este caso de tipo actionSheet
        let alertController:UIAlertController = UIAlertController(title: "Añade una imagen",
                                                                  message: "¿De dónde quieres escoger la imagen?",
                                                                  preferredStyle: .actionSheet)
        
        
        //Creamos una accion que posteriormente sera un boton en la alerta,
        //pulsar este boton ocasionara que se abra la libreeria de fotos porque .sourceType == .photoLibrary
        let photoLibraryaction:UIAlertAction = UIAlertAction(title: "Librería de fotos", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            //Codigo que se ejecuta cuando pulsamos el boton de la alerta
            picker.sourceType = .photoLibrary
            self.present(picker, animated: true, completion: nil)
        })
        //Esta accion abrira la camara de fotos permitiendonos hacer una foto y editarla
        let cameraAction:UIAlertAction = UIAlertAction(title: "Cámara", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            picker.sourceType = .camera
            self.present(picker, animated: true, completion: nil)
        })
        //Esta accion abre directamente las fotos guardadas
        let savedPhotosAlbumAction:UIAlertAction = UIAlertAction(title: "Álbum de fotos", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            picker.sourceType = .savedPhotosAlbum
            self.present(picker, animated: true, completion: nil)
        })
        //Esta accion es la de candelar, de tipo .cancel para que aparezca abajo, oculta la alerta
        let cancelAction:UIAlertAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        
        
        //CAmbiamos el color del texto de las acciones a negro
        photoLibraryaction.setValue(#colorLiteral(red: 0.2779085934, green: 0.3907533586, blue: 0.2644636631, alpha: 1), forKey: "titleTextColor")
        savedPhotosAlbumAction.setValue(#colorLiteral(red: 0.2779085934, green: 0.3907533586, blue: 0.2644636631, alpha: 1), forKey: "titleTextColor")
        cameraAction.setValue(#colorLiteral(red: 0.2779085934, green: 0.3907533586, blue: 0.2644636631, alpha: 1), forKey: "titleTextColor")
        cancelAction.setValue(#colorLiteral(red: 0, green: 0.4797514677, blue: 0.9984372258, alpha: 1), forKey: "titleTextColor")
        
        
        //Añadimos imagenes a las acciones del actionSheet
        photoLibraryaction.setValue(UIImage(named: "imagen"), forKey: "image")
        savedPhotosAlbumAction.setValue(UIImage(named: "album"), forKey: "image")
        cameraAction.setValue(UIImage(named: "camera"), forKey: "image")
        
        //Añadimos todas las acciones al alertcontroller
        alertController.addAction(photoLibraryaction)
        alertController.addAction(savedPhotosAlbumAction)
        alertController.addAction(cameraAction)
        alertController.addAction(cancelAction)
        //Mostramos la alerta al usuario
        present(alertController, animated: true, completion: nil)
    }
    
    
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

extension AddNewStudentViewController: UITextFieldDelegate {
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
        self.topConstraintView.constant = topConstantContraint
        self.bottomConstraintView.constant = bottomConstantConstraint
    }
}
