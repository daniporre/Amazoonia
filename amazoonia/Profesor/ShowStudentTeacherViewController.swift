//
//  ShowStudentTeacherViewController.swift
//  amazoonia
//
//  Created by Daniel Martinez on 07/12/2019.
//  Copyright © 2019 Amazoonia. All rights reserved.
//

import UIKit
import CoreData

class ShowStudentTeacherViewController: UIViewController {
    
    @IBOutlet weak var studentImageView: UIImageView!
    @IBOutlet weak var nameTextField: UILabel!
    @IBOutlet weak var numExpTextField: UILabel!
    @IBOutlet weak var tableViewExperiments: UITableView!
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    var alumno: Alumno!
    var listaExperimentos = [Experimento]()
    var alumnos = [Alumno]()
    var container: NSPersistentContainer!
    
    var indice: IndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableViewExperiments.reloadData()
        listaExperimentos = alumno!.experimentos.allObjects as! [Experimento]
        sortByDate()
        backgroundImageView.image = UIImage(data: self.alumno.photo as Data)
        self.navigationItem.title = alumno.user
    }
    
    func sortByDate() {
        listaExperimentos.sort(by: {$0.dateString.compare($1.dateString) == .orderedDescending})
    }
    
    @IBAction func reloadTableview(segue: UIStoryboardSegue) {
        if segue.identifier == "commentUndwind" {
            self.tableViewExperiments.reloadData()
        }
    }
    
    func setUpUI() {
        studentImageView.layer.borderWidth = 7
        studentImageView.layer.borderColor = #colorLiteral(red: 0.9029806256, green: 0.7490995526, blue: 0, alpha: 1)
        self.studentImageView.layer.cornerRadius = studentImageView.frame.height / 2
        self.navigationItem.rightBarButtonItem?.image = #imageLiteral(resourceName: "editStudent").withRenderingMode(.alwaysTemplate)
        blurView.layer.cornerRadius = 10
        setNormalNavigationBar(viewController: self)
        nameTextField.text = alumno.name
        numExpTextField.text = "Número de experimentos: \(String(alumno.experimentos.count))"
        studentImageView.image = UIImage(data: alumno.photo as Data)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showExperimentTeacherSegue" {
            let viewDestiny = segue.destination as? ShowExperimentTeacherViewController
            viewDestiny?.alumno = self.alumno
            let filaSeleccionada = self.tableViewExperiments.indexPathForSelectedRow
            viewDestiny?.experimento = listaExperimentos[(filaSeleccionada?.row)!]
            viewDestiny!.container = self.container
            self.tableViewExperiments.reloadRows(at: [filaSeleccionada!], with: .fade)
        }
        if segue.identifier == "firstMarkSegue" {
            let viewDestiny = segue.destination as? ReviewViewController
            viewDestiny?.experimento = listaExperimentos[(self.indice?.row)!]
            viewDestiny?.container = self.container
        }
        if segue.identifier == "commentSegue" {
            let NavigationController = segue.destination as! UINavigationController
            let viewDestiny = NavigationController.topViewController as! CommentExperimentViewController
            viewDestiny.experimento = listaExperimentos[(self.indice?.row)!]
            viewDestiny.container = self.container
        }
    }
    
    @IBAction func editUserButton(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Editar perfil", message: "\n\n\n", preferredStyle: .actionSheet)
        
        
        
        crearVistaActionSheet(alertController: alertController, objeto: self.alumno, foto: UIImage(data: self.alumno.photo as Data)!)
        
        
        
        let userName = UIAlertAction(title: "Usuario", style: .default) { (UIAlertAction) in
            self.lanzarAlertaTextfieldUsername(viewController: self, title: "Cambiar nombre de usuario", message: "Introduce tu nuevo nombre de usuario")
        }
        let password = UIAlertAction(title: "Contraseña", style: .default) { (UIAlertAction) in
            self.lanzarAlertaTextfieldContraseña(viewController: self, title: "Cambiar contraseña de usuario", message: "Introduce tu nueva contraseña de usuario")
        }
        let imageUser = UIAlertAction(title: "Foto de perfil", style: .default) { (UIAlertAction) in
            self.alertForSourceType()
        }
        let nameUser = UIAlertAction(title: "Nombre completo", style: .default) { (UIAlertAction) in
            self.lanzarAlertaTextfieldName(viewController: self, title: "Cambiar nombre completo de usuario", message: "Introduce tu nuevo nombre completo de usuario")
        }
        let cancelar = UIAlertAction(title: "Cancelar", style: .cancel) { (UIAlertAction) in
            
        }
        
        //CAmbiamos el color del texto de las acciones a negro
        userName.setValue(#colorLiteral(red: 0.2784313725, green: 0.3921568627, blue: 0.262745098, alpha: 1), forKey: "titleTextColor")
        nameUser.setValue(#colorLiteral(red: 0.2779085934, green: 0.3907533586, blue: 0.2644636631, alpha: 1), forKey: "titleTextColor")
        password.setValue(#colorLiteral(red: 0.2779085934, green: 0.3907533586, blue: 0.2644636631, alpha: 1), forKey: "titleTextColor")
        imageUser.setValue(#colorLiteral(red: 0.2779085934, green: 0.3907533586, blue: 0.2644636631, alpha: 1), forKey: "titleTextColor")
        cancelar.setValue(#colorLiteral(red: 0, green: 0.4797514677, blue: 0.9984372258, alpha: 1), forKey: "titleTextColor")
        
        
        //Añadimos imagenes a las acciones del actionSheet
        nameUser.setValue(UIImage(named: "userData"), forKey: "image")
        userName.setValue(UIImage(named: "userImage"), forKey: "image")
        imageUser.setValue(UIImage(named: "userPhoto"), forKey: "image")
        password.setValue(UIImage(named: "userPassword"), forKey: "image")
        
        alertController.addAction(nameUser)
        alertController.addAction(userName)
        alertController.addAction(imageUser)
        alertController.addAction(password)
        alertController.addAction(cancelar)
        
        self.present(alertController, animated: true)
    }
    
    func lanzarAlertaTextfieldContraseña(viewController: UIViewController, title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertController.addTextField { (textFieldAlert) in
            textFieldAlert.placeholder = "Introduce la contraseña"
            textFieldAlert.isSecureTextEntry = false
            textFieldAlert.borderStyle = .none
        }
        
        let ok = UIAlertAction(title: "Cambiar", style: .default) { (UIAlertAction) in
            if alertController.textFields?.first?.text != "" {
                self.alumno.password = (alertController.textFields?.first!.text)!
                self.saveContext()
                lanzarAlertaConTiempo(viewController: self, titulo: "Contraseña cambiada", mensaje: "Su contraseña ha sido cambiada correctamente", segundos: 3)
            }
        }
        
        let cancel = UIAlertAction(title: "Cancelar", style: .cancel) { (UIAlertAction) in
            
        }
        
        alertController.addAction(ok)
        alertController.addAction(cancel)
        
        viewController.present(alertController, animated: true)
    }
    
    func lanzarAlertaTextfieldUsername(viewController: UIViewController, title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertController.addTextField { (textFieldAlert) in
            textFieldAlert.placeholder = "Introduce el nombre de usuario"
            textFieldAlert.isSecureTextEntry = false
            textFieldAlert.borderStyle = .none
        }
        alertController.textFields?.first?.text = self.alumno.user
        let ok = UIAlertAction(title: "Cambiar", style: .default) { (UIAlertAction) in
            
            if self.alumnos.contains(where: {$0.user.lowercased() == (alertController.textFields?.first!.text)!.lowercased()}) {
                lanzarAlertaConUnBoton(viewController: self, title: "Usuario no disponible", message: "El usuario introducido para este alumno ya existe, por favor, escoge otro.", buttonText: "Aceptar", buttonType: .cancel)
                return
            } else {
                if alertController.textFields?.first?.text != "" {
                    self.alumno.user = (alertController.textFields?.first!.text)!
                    self.navigationItem.title = self.alumno.user.capitalized
                    self.saveContext()
                    lanzarAlertaConTiempo(viewController: self, titulo: "Nombre de usuario cambiado", mensaje: "Su nombre de usuario ha sido cambiado correctamente", segundos: 3)
                }
            }
            
            
        }
        
        let cancel = UIAlertAction(title: "Cancelar", style: .cancel) { (UIAlertAction) in
            
        }
        
        alertController.addAction(ok)
        alertController.addAction(cancel)
        
        viewController.present(alertController, animated: true)
    }
    func lanzarAlertaTextfieldName(viewController: UIViewController, title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertController.addTextField { (textFieldAlert) in
            textFieldAlert.placeholder = "Introduce el nombre completo del usuario"
            textFieldAlert.isSecureTextEntry = false
            textFieldAlert.borderStyle = .none
        }
        alertController.textFields?.first?.text = self.alumno.name.capitalized
        let ok = UIAlertAction(title: "Cambiar", style: .default) { (UIAlertAction) in
            if alertController.textFields?.first?.text != "" {
                self.alumno.name = (alertController.textFields?.first!.text)!
                self.nameTextField.text = self.alumno.name
                self.saveContext()
                lanzarAlertaConTiempo(viewController: self, titulo: "Nombre completo de usuario cambiado", mensaje: "Su nombre completo de usuario ha sido cambiado correctamente", segundos: 3)
            }
        }
        
        let cancel = UIAlertAction(title: "Cancelar", style: .cancel) { (UIAlertAction) in
            
        }
        
        alertController.addAction(ok)
        alertController.addAction(cancel)
        
        viewController.present(alertController, animated: true)
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
    
    

}

extension ShowStudentTeacherViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //      Con .editedImage nos quedamos con la foto editada y esa es la que establecemos en imageViewUser.image
        if let theImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.studentImageView.image = theImage
            self.alumno.photo = theImage.pngData()! as NSData
            self.saveContext()
            //            if(imageView.image != UIImage(named: "addUserImage")){
            //                //Establecemos configuraciones, establecemos la imagen con forma redondeada
            //                imageView.layer.cornerRadius = imageView.frame.width / 2
            //                imageView.layer.borderWidth = 3
            //
            //            }
            let generator = UINotificationFeedbackGenerator()
            generator.prepare()
            generator.notificationOccurred(.success)
            studentImageView.layer.cornerRadius = studentImageView.frame.height / 2
            studentImageView.clipsToBounds = true
            studentImageView.layer.borderWidth = 4
            studentImageView.layer.borderColor = #colorLiteral(red: 0.2779085934, green: 0.3907533586, blue: 0.2644636631, alpha: 1)
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
    
    
}


extension ShowStudentTeacherViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaExperimentos.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Lista de experimentos                                \(self.listaExperimentos.count)"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentTeacherTableViewCell", for: indexPath) as! StudentTeacherTableViewCell
        cell.imageViewCell.image = UIImage(data: listaExperimentos[indexPath.row].photo as Data)
        cell.nameCell.text = listaExperimentos[indexPath.row].name
        
        if self.listaExperimentos[indexPath.row].mark == "bad" {
            cell.markImageViewCell.image = #imageLiteral(resourceName: "bad")
        }
        if self.listaExperimentos[indexPath.row].mark == "good" {
            cell.markImageViewCell.image = #imageLiteral(resourceName: "good")
        }
        if self.listaExperimentos[indexPath.row].mark == "great" {
            cell.markImageViewCell.image = #imageLiteral(resourceName: "great")
        }
        if self.listaExperimentos[indexPath.row].mark == "" {
            cell.markImageViewCell.image = #imageLiteral(resourceName: "mark")
        }
        
        if self.listaExperimentos[indexPath.row].comment != "" {
            cell.commentImageview.tintColor = #colorLiteral(red: 1, green: 0.8707417846, blue: 0.1957176328, alpha: 1)
            cell.commentImageview.image = #imageLiteral(resourceName: "comment").withRenderingMode(.alwaysTemplate)
        }
        if self.listaExperimentos[indexPath.row].comment == "" {
            cell.commentImageview.image = nil
        }
        
        cell.dateCell.text = listaExperimentos[indexPath.row].dateString
        cell.accessoryType = .disclosureIndicator
        
        self.tableViewExperiments.tableFooterView = UIView(frame: CGRect.zero)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 92
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        //Creamos la accion Eliminar de tipo UIContextualAction para la celda...
        
        self.indice = indexPath
        //Creamos la accion Compartir de tipo UIContextualAction para la celda...
        let shareAction = UIContextualAction(style: .destructive, title:  "Calificar", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            
            self.performSegue(withIdentifier: "firstMarkSegue", sender: nil)
            
            //respuesta haptica de tipo impacto...
            let impact: UIImpactFeedbackGenerator.FeedbackStyle = .heavy
            let generator = UIImpactFeedbackGenerator(style: impact)
            generator.prepare()
            
            generator.impactOccurred()
            success(true)
        })
        shareAction.image = #imageLiteral(resourceName: "calificar").withRenderingMode(.alwaysTemplate)
        shareAction.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        
        let commentAction = UIContextualAction(style: .destructive, title:  "Comentar", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            
            self.performSegue(withIdentifier: "commentSegue", sender: nil)
            
            //respuesta haptica de tipo impacto...
            let impact: UIImpactFeedbackGenerator.FeedbackStyle = .heavy
            let generator = UIImpactFeedbackGenerator(style: impact)
            generator.prepare()
            
            generator.impactOccurred()
            success(true)
        })
        commentAction.image = #imageLiteral(resourceName: "comment").withRenderingMode(.alwaysTemplate)
        commentAction.backgroundColor = #colorLiteral(red: 1, green: 0.8707417846, blue: 0.1957176328, alpha: 1)
        
        return UISwipeActionsConfiguration(actions: [shareAction,commentAction])
    }
    
}
