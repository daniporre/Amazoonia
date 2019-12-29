//
//  StudentViewController.swift
//  amazoonia
//
//  Created by Daniel Martinez on 11/12/2019.
//  Copyright © 2019 Amazoonia. All rights reserved.
//

import UIKit
import CoreData

class StudentViewController: UIViewController {
    
    var alumno: Alumno!
    var listaExperimentos = [Experimento]()
    var alumnos = [Alumno]()
    
    var container: NSPersistentContainer!
    var fetchResultsController: NSFetchedResultsController<Alumno>!
    
    @IBOutlet weak var studentImageView: UIImageView!
    @IBOutlet weak var nameStudentLabel: UILabel!
    @IBOutlet weak var numExpStudentLabel: UILabel!
    @IBOutlet weak var blurViewBackground: UIVisualEffectView!
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        setUpHeaderView()
        setUpData()
        setUpTableView()
        print(alumno)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(self.alumno)
        self.tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = String(alumno.user).capitalized
        print(self.listaExperimentos)
        listaExperimentos = alumno!.experimentos.allObjects as! [Experimento]
        listaExperimentos.sort(by: {$0.dateString.compare($1.dateString) == .orderedDescending})
        self.tableView.reloadData()
    }
    
    func sortDate() {
        
        

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addNewExperiment" {
            let viewDestiny = segue.destination as? AddNewExperimentViewController
            viewDestiny!.alumno = self.alumno!
            viewDestiny!.container = self.container!
        }
        if segue.identifier == "showExperimentSegue" {
            let viewDestiny = segue.destination as? ShowExperimentStudentViewController
            let filaSeleccionada = self.tableView.indexPathForSelectedRow
            viewDestiny?.experimento = listaExperimentos[(filaSeleccionada?.row)!]
            self.tableView.reloadRows(at: [filaSeleccionada!], with: .fade)
        }
    }
    
//    override func viewDidDisappear(_ animated: Bool) {
//        self.alumno.photo = studentImageView.image?.pngData() as! NSData
//        self.saveContext()
//    }
    
    @IBAction func newExperimentButton(_ sender: UIButton) {
        
        
        
    }
    
    @IBAction func changeImageTapped(_ sender: UITapGestureRecognizer) {
        alertForSourceType()
    }
    
    @IBAction func editUserButton(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Editar perfil", message: "¿Qué quieres editar?", preferredStyle: .actionSheet)
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
            
            self.alumno.password = (alertController.textFields?.first!.text)!
            self.saveContext()
            lanzarAlertaConTiempo(viewController: self, titulo: "Contraseña cambiada", mensaje: "Su contraseña ha sido cambiada correctamente", segundos: 3)
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
        
        let ok = UIAlertAction(title: "Cambiar", style: .default) { (UIAlertAction) in
            
            if self.alumnos.contains(where: {$0.user.lowercased() == (alertController.textFields?.first!.text)!.lowercased()}) {
                lanzarAlertaConUnBoton(viewController: self, title: "Usuario no disponible", message: "El usuario introducido para este alumno ya existe, por favor, escoge otro.", buttonText: "Aceptar", buttonType: .cancel)
                return
            } else {
                self.alumno.user = (alertController.textFields?.first!.text)!
                self.navigationItem.title = self.alumno.user.capitalized
                self.saveContext()
                lanzarAlertaConTiempo(viewController: self, titulo: "Nombre de usuario cambiado", mensaje: "Su nombre de usuario ha sido cambiada correctamente", segundos: 3)
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
        
        let ok = UIAlertAction(title: "Cambiar", style: .default) { (UIAlertAction) in
            
            self.alumno.name = (alertController.textFields?.first!.text)!
            self.nameStudentLabel.text = self.alumno.name
            self.saveContext()
            lanzarAlertaConTiempo(viewController: self, titulo: "Nombre completo de usuario cambiado", mensaje: "Su nombre completo de usuario ha sido cambiada correctamente", segundos: 3)
        }
        
        let cancel = UIAlertAction(title: "Cancelar", style: .cancel) { (UIAlertAction) in
            
        }
        
        alertController.addAction(ok)
        alertController.addAction(cancel)
        
        viewController.present(alertController, animated: true)
    }
    
    func setUpTableView(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func setUpData() {
        self.studentImageView.image = UIImage(data: self.alumno.photo as Data)
        self.nameStudentLabel.text = alumno.name
        self.numExpStudentLabel.text = "Profesor: \(String(alumno.profesor.name).capitalized)"
    }
    
    func setUpHeaderView() {
        self.studentImageView.layer.cornerRadius = studentImageView.frame.height / 2
        blurViewBackground.layer.cornerRadius = 15
        // Do any additional setup after loading the view.
        nameStudentLabel.text = "Jose Ortega Cano"
        numExpStudentLabel.text = "Numero de experimentos: 7"
        studentImageView.layer.borderWidth = 7
        studentImageView.layer.borderColor = #colorLiteral(red: 0.9029806256, green: 0.7490995526, blue: 0, alpha: 1)
    }
    
    func setUpNavigationBar() {
        
        //        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationItem.leftBarButtonItem?.image = #imageLiteral(resourceName: "logout").withRenderingMode(.alwaysTemplate)
        
        self.navigationItem.rightBarButtonItem?.image = #imageLiteral(resourceName: "editStudent").withRenderingMode(.alwaysTemplate)
        setNormalNavigationBar(viewController: self)
        self.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem?.image = #imageLiteral(resourceName: "noun_Power_1482886").withRenderingMode(.alwaysTemplate)
        
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
    
    
    @IBAction func logOutButton(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Cerrar sesión", message: "¿Está seguro/a de que quiere cerrar la sesión activa?", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "Cerrar sesión", style: .destructive) { (UIAlertAction) in
            self.navigationController?.popViewController(animated: true)
            
            self.dismiss(animated: true, completion: nil)
        }
        let cancel = UIAlertAction(title: "Cancelar", style: .cancel) { (UIAlertAction) in
            
        }
        
        alertController.addAction(cancel)
        alertController.addAction(ok)
        
        present(alertController, animated: true)
    }
    
    func dateToString(dateFormat format: String , date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }

}

extension StudentViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if listaExperimentos.count == 0 {
            return 1
        }
        return listaExperimentos.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Lista de experimentos                                \(self.listaExperimentos.count)"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentTableViewCell", for: indexPath) as! StudentTableViewCell
        
        if listaExperimentos.count == 0 {
            
            cell.imageViewCell.image = #imageLiteral(resourceName: "nullContent")
            cell.imageViewCell.backgroundColor = #colorLiteral(red: 1, green: 0.2800146937, blue: 0.3337086439, alpha: 1)
            cell.imageViewCell.clipsToBounds = true
            cell.imageViewCell.layer.cornerRadius = cell.imageViewCell.frame.height / 2
            cell.nameCell.text = "No hay ningun experimento"
            cell.dateCell.text = "Pulsa el botón Nuevo experimento para crear uno nuevo."
            cell.accessoryType = .none
            cell.markImageCell.isHidden = true
            self.tableView.tableFooterView = UIView(frame: CGRect.zero)
            
            return cell
        }
        cell.imageViewCell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        cell.markImageCell.isHidden = false
        cell.imageViewCell.image = UIImage(data: listaExperimentos[indexPath.row].photo as Data)
        cell.nameCell.text = listaExperimentos[indexPath.row].name
        cell.dateCell.text = self.listaExperimentos[indexPath.row].dateString
        
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
        
        cell.accessoryType = .disclosureIndicator
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        return cell
    }
    
    

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if listaExperimentos.count != 0 {
        //Creamos la accion Eliminar de tipo UIContextualAction para la celda...
//            let deleteAction = UIContextualAction(style: .destructive, title:  "Eliminar", handler: { (ac:UIContextualAction, view:UIView, success:@escaping (Bool) -> Void) in
//
//                //Alerta con tres tipos de acciones
//                let alertController = UIAlertController(title: "Eliminar", message: "¿Estás seguro de que quieres eliminar \(self.listaExperimentos[indexPath.row]) de tus experimentos?", preferredStyle: .alert)
//                //Creamos el generador de hapticFeedback
//                let generator = UINotificationFeedbackGenerator()
//                generator.prepare()
//                //Hacemos que mande una notificacion al usuario de tipo warning de forma haptica...
//                generator.notificationOccurred(.warning)
//
//                let alertAction = UIAlertAction(title: "Eliminar seleccionado", style: .destructive, handler: { (UIAlertAction) in
//                    self.listaExperimentos.remove(at: indexPath.row)
//                    self.tableView.deleteRows(at: [indexPath], with: .left)
//                    let generator = UINotificationFeedbackGenerator()
//                    generator.prepare()
//                    //Notifiacion de tipo error...
//                    generator.notificationOccurred(.error)
//                    success(true)
//                })
//                let deleteAll = UIAlertAction(title: "Eliminar todos", style: .destructive, handler: { (UIAlertAction) in
//                    self.listaExperimentos.removeAll()
//                    print(self.listaExperimentos.count)
//                    let generator = UINotificationFeedbackGenerator()
//                    generator.prepare()
//                    generator.notificationOccurred(.error)
//                    self.tableView.reloadData()
//                })
//                let cancelarAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: { (UIAlertAction) in
//                    self.tableView.isEditing = false
//                  self.tableView.reloadData()
//                })
//                alertController.addAction(cancelarAction)
//                alertController.addAction(alertAction)
//                alertController.addAction(deleteAll)
//
//                self.present(alertController, animated: true)
//
//                // Reset state
//
//            })
//            deleteAction.image = #imageLiteral(resourceName: "delete").withRenderingMode(.alwaysTemplate)
//            deleteAction.title = "Eliminar"
//
            //Creamos la accion Compartir de tipo UIContextualAction para la celda...
            let shareAction = UIContextualAction(style: .destructive, title:  "Compartir", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            
                //Aqui llamamos al UIActivityViewController y establcemos lo que queremos compartir, en mi caso un texto y una imagen del paisaje.
                let defaultText = "Mira mi experimento: \(self.listaExperimentos[indexPath.row].name)"
                let activityController = UIActivityViewController(activityItems: [defaultText, self.listaExperimentos[indexPath.row].photo], applicationActivities: nil)
                //respuesta haptica de tipo impacto...
                let impact: UIImpactFeedbackGenerator.FeedbackStyle = .heavy
                //            if #available(iOS 13, *) {
                //                impact = .rigid
                //            }
                let generator = UIImpactFeedbackGenerator(style: impact)
                generator.prepare()
                self.present(activityController, animated: true, completion: nil)
                generator.impactOccurred()
                
            })
            shareAction.image = #imageLiteral(resourceName: "share").withRenderingMode(.alwaysTemplate)
            shareAction.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        
//            deleteAction.backgroundColor = .red
            return UISwipeActionsConfiguration(actions: [shareAction])
        }
        
        let createAction = UIContextualAction(style: .destructive, title:  "Crear", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            
            self.performSegue(withIdentifier: "addNewExperiment", sender: nil)
            
            
            var impact: UIImpactFeedbackGenerator.FeedbackStyle = .heavy
//            if #available(iOS 13, *) {
//                impact = .rigid
//            }
            let generator = UIImpactFeedbackGenerator(style: impact)
            generator.prepare()
            generator.impactOccurred()
        })
        
        createAction.backgroundColor = #colorLiteral(red: 1, green: 0.8705882353, blue: 0.3490196078, alpha: 1)
        
        return UISwipeActionsConfiguration(actions: [createAction])
    }
    
    
}


extension StudentViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
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
