//
//  TeacherViewController.swift
//  amazoonia
//
//  Created by Daniel Martinez on 03/12/2019.
//  Copyright © 2019 Amazoonia. All rights reserved.
//

import UIKit
import CoreData

class TeacherViewController: UIViewController, UINavigationControllerDelegate {

    var profesor: Profesor!
    var listaAlumnos2 = [Alumno]()
    var alumnos = [Alumno]()
    
    var container: NSPersistentContainer!
    var fetchResultsController: NSFetchedResultsController<Profesor>!
    
    
    @IBOutlet weak var studentsTableView: UITableView!
    @IBOutlet weak var childrenTableView: UITableView!
    @IBOutlet weak var addNewStudentButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavigationBar()
        setUpTableView()
        setUpNewStudentButton()
//
//        alumnos = ["José Ortega Cano","Alejandro Rodriguez Felices","Elena Nito Fernandez","Francisco Hernández Del Pino","David Martínez Fernandez","Juan Escaño García", "Penélope Luda Soler"]
//        fotos = [#imageLiteral(resourceName: "niño5"),#imageLiteral(resourceName: "niño4"),#imageLiteral(resourceName: "niño1"),#imageLiteral(resourceName: "niño3"),#imageLiteral(resourceName: "niño2"),#imageLiteral(resourceName: "niño6"),#imageLiteral(resourceName: "niño7")]
//        numExp = [7,5,7,4,5,7,3]
        
        
        
        
        
        //saveContext()
        
        
//        for alumno in profesor.listaAlumnos {
//            listaAlumnos.append(alumno as! Alumno)
//        }
        
//
//        let newAlumno = Alumno(context: self.container.viewContext)
//        newAlumno.name = "daniel martinez111"
//
////        listaAlumnos.removeAll()
////        listaAlumnos.append(newAlumno)
//
////        self.saveContext()
//
////        self.listaAlumnos.removeAll()
//
//
//        profesor.removeFromListaAlumnos(newAlumno)
//        self.saveContext()
        
        print("La lista de alumnos es: \n \(listaAlumnos2)")
        
        

    }
    
    @IBAction func newStudent(sender: UIStoryboardSegue) {
        if sender.identifier != "addUnwind"{return}
        let source = sender.source as! AddNewStudentViewController
        let newStudent = source.alumno
        listaAlumnos2.append(newStudent!)
        let newIndexPath: IndexPath = IndexPath(row: listaAlumnos2.count-1, section: 0)
        self.studentsTableView.insertRows(at: [newIndexPath], with: .fade)
        self.saveContext()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "addNewStudentSegue"){
            let viewDestiny = segue.destination as? AddNewStudentViewController
            viewDestiny?.profesor = self.profesor
            viewDestiny?.container = self.container
            self.navigationItem.title = self.profesor?.name
        }
        if segue.identifier == "showStudentSegue" {
            let viewDestiny = segue.destination as? ShowStudentTeacherViewController
            let filaSeleccionada = studentsTableView.indexPathForSelectedRow
            viewDestiny?.alumno = listaAlumnos2[(filaSeleccionada?.row)!]
            viewDestiny?.container = self.container
            viewDestiny?.alumnos = self.alumnos
            studentsTableView.reloadRows(at: [filaSeleccionada!], with: .fade)
        }
    }
    
    
    @IBAction func loadTeacher(sender: UIStoryboardSegue) {
        if sender.identifier == "inicioProfesor" {
            print("Segue")
        }
        
        
        
    }

    
    override func viewDidAppear(_ animated: Bool) {
        setUpNavigationBar()
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.studentsTableView.reloadData()
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = self.profesor.user.capitalized
        listaAlumnos2 = profesor!.listaAlumnos.allObjects as! [Alumno]
        listaAlumnos2.sort(by: {$0.name.compare($1.name) == .orderedAscending})
//        loadSavedData()
        print(profesor.listaAlumnos)
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
    }
    
    @IBAction func editUserButton(_ sender: UIBarButtonItem) {
        
        let alertController = UIAlertController(title: "Editar perfil", message: "¿Qué quieres editar?", preferredStyle: .actionSheet)
        let userName = UIAlertAction(title: "Usuario", style: .default) { (UIAlertAction) in
            self.lanzarAlertaTextfieldUsername(viewController: self, title: "Cambiar nombre de usuario", message: "Introduce tu nuevo nombre de usuario")
        }
        let password = UIAlertAction(title: "Contraseña", style: .default) { (UIAlertAction) in
            self.lanzarAlertaTextfieldContraseña(viewController: self, title: "Cambiar contraseña de usuario", message: "Introduce tu nueva contraseña de usuario")
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
        cancelar.setValue(#colorLiteral(red: 0, green: 0.4797514677, blue: 0.9984372258, alpha: 1), forKey: "titleTextColor")
        
        
        //Añadimos imagenes a las acciones del actionSheet
        nameUser.setValue(UIImage(named: "userData"), forKey: "image")
        userName.setValue(UIImage(named: "userImage"), forKey: "image")
        password.setValue(UIImage(named: "userPassword"), forKey: "image")
        
        alertController.addAction(nameUser)
        alertController.addAction(userName)
        alertController.addAction(password)
        alertController.addAction(cancelar)
        
        self.present(alertController, animated: true)
        
    }
    
    
    
    @IBAction func logOutButton(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Cerrar sesión", message: "¿Está seguro/a de que quiere salir de \(self.profesor.name)?", preferredStyle: .alert)

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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension TeacherViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaAlumnos2.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Lista de alumnos/as"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TeacherTableViewCell", for: indexPath) as! TeacherTableViewCell
        
        
        cell.nameCell.text = listaAlumnos2[indexPath.row].name
        cell.imageViewCell.image = UIImage(data: listaAlumnos2[indexPath.row].photo as Data)
        cell.numExpCell.text = "Número de experimentos: \(listaAlumnos2[indexPath.row].experimentos.count)"
        cell.imageViewCell.layer.cornerRadius = cell.imageViewCell.frame.height / 2
        cell.imageViewCell.clipsToBounds = true
//        cell.accessoryType = .disclosureIndicator
        
        cell.backGroundCell.layer.cornerRadius = 15
        cell.backGroundCell.backgroundColor = UIColor.white
        cell.backGroundCell.layer.borderColor = #colorLiteral(red: 0.5616337657, green: 0.7937321067, blue: 0.5317659974, alpha: 1)
        cell.backGroundCell.layer.borderWidth = 3
        
        cell.backGroundCell.layer.shadowRadius = 2
        cell.backGroundCell.layer.shadowColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        cell.backGroundCell.layer.shadowOpacity = 5
        cell.backGroundCell.layer.shadowOffset = CGSize(width: 0, height: 3)
        
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    
    
    
    
    
    
    
    
    
    
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        //Creamos la accion Eliminar de tipo UIContextualAction para la celda...
//        let deleteAction = UIContextualAction(style: .destructive, title:  "Eliminar", handler: { (ac:UIContextualAction, view:UIView, success:@escaping (Bool) -> Void) in
//
//            //Alerta con tres tipos de acciones
//            let alertController = UIAlertController(title: "Eliminar", message: "¿Estás seguro de que quiere eliminar \(self.listaAlumnos2[indexPath.row].name) de sus alumnos?", preferredStyle: .alert)
//            //Creamos el generador de hapticFeedback
//            let generator = UINotificationFeedbackGenerator()
//            generator.prepare()
//            //Hacemos que mande una notificacion al usuario de tipo warning de forma haptica...
//            generator.notificationOccurred(.warning)
//
//            let alertAction = UIAlertAction(title: "Eliminar seleccionada", style: .destructive, handler: { (UIAlertAction) in
//                self.deleteStudent(user: self.listaAlumnos2[indexPath.row].user)
//                self.studentsTableView.deleteRows(at: [indexPath], with: .left)
//                let generator = UINotificationFeedbackGenerator()
//                generator.prepare()
//                //Notifiacion de tipo error...
//                generator.notificationOccurred(.error)
//                success(true)
//            })
//            let cancelarAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: { (UIAlertAction) in
//                self.studentsTableView.isEditing = false
//                self.studentsTableView.reloadData()
//            })
//            alertController.addAction(cancelarAction)
//            alertController.addAction(alertAction)
//
//            self.present(alertController, animated: true)
//            // Reset state
//
//        })
//
//        deleteAction.backgroundColor = .red
//        return UISwipeActionsConfiguration(actions: [deleteAction])
//    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}


//MARK: - CORE DATA CONFIGURATIONS
extension TeacherViewController {
    
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
    
    func deleteStudent(user: String) {
        let context = container.viewContext
        let requestAlumno: NSFetchRequest<Alumno> = Alumno.fetchRequest()
        
        do {
            listaAlumnos2 = try container.viewContext.fetch(requestAlumno)
            
            for alumno in listaAlumnos2 {
                if alumno.user == user {
                    context.delete(alumno)
                    saveContext()
                }
            }
        } catch {
            print("fetch failed \(error.localizedDescription)")
        }
        
    }
    
//    func loadSavedData() {
//
//        let request: NSFetchRequest<Alumno> = NSFetchRequest(entityName: "Alumno")
//        let sort = NSSortDescriptor(key: "name", ascending: true)
//        request.sortDescriptors = [sort]
//
//        do {
////            listaAlumnos = try container.viewContext.fetch(request)
//
//        } catch {
//            print("fetch failed")
//        }
//
//    }
//    func deleteTeacher(user: String) {
//        let context = container.viewContext
//        let request = Profesor.createFetchRequest()
//
//        do {
//            listaAlumnos = try container.viewContext.fetch(request)
//
//            for profesor in listaAlumnos {
//                if profesor.user == user {
//                    context.delete(profesor)
//                    saveContext()
//                }
//            }
//        } catch {
//            print("fetch failed")
//        }
//
//    }
//
//    func loadTeacher(user: String) -> Profesor? {
//        let request = Profesor.createFetchRequest()
//
//        do {
//            profesores = try container.viewContext.fetch(request)
//
//            for profesor in profesores {
//                if profesor.user == user {
//                    return profesor
//                }
//            }
//        } catch {
//            print("fetch failed")
//        }
//        return profesor
//    }
    
}

//MARK: - SETUPS
extension TeacherViewController {
    
    func setUpTableView(){
        self.childrenTableView.delegate = self
        self.childrenTableView.dataSource = self
    }
    
    func setUpNewStudentButton() {
        addNewStudentButton.setImage(#imageLiteral(resourceName: "addNewStudentLong").withRenderingMode(.alwaysOriginal), for: .normal)
        addNewStudentButton.layer.shadowRadius = 2
        addNewStudentButton.layer.shadowColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        addNewStudentButton.layer.shadowOpacity = 5
        addNewStudentButton.adjustsImageWhenHighlighted = false
        addNewStudentButton.layer.shadowOffset = CGSize(width: 0, height: 3)
    }
    
    func setUpNavigationBar() {
        
        //        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.isHidden = false
        
        self.navigationItem.rightBarButtonItem?.image = #imageLiteral(resourceName: "editUser").withRenderingMode(.alwaysTemplate)
//        setNavigationBarStyle11(viewController: self)
        self.navigationItem.hidesBackButton = true
        
        
       
        
        self.navigationItem.leftBarButtonItem?.image = #imageLiteral(resourceName: "noun_Power_1482886").withRenderingMode(.alwaysTemplate)
        
        //TITLEVIEW
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        let image = UIImageView(frame: view.frame)
        image.image = UIImage(named: "amazoonialogoletras.png")
        image.contentMode = .scaleAspectFill
        view.addSubview(image)
        
        self.navigationItem.titleView = view
        
    }
    
    func setNavigationBarStyle11(viewController: UIViewController){
        if #available(iOS 11.0, *) {
            viewController.navigationController?.navigationBar.prefersLargeTitles = true
        }
    }
    
}

extension TeacherViewController {
    func lanzarAlertaTextfieldContraseña(viewController: UIViewController, title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertController.addTextField { (textFieldAlert) in
            textFieldAlert.placeholder = "Introduce la contraseña"
            textFieldAlert.isSecureTextEntry = false
            textFieldAlert.borderStyle = .none
        }
        
        let ok = UIAlertAction(title: "Cambiar", style: .default) { (UIAlertAction) in
            if alertController.textFields?.first?.text != "" {
                self.profesor.password = (alertController.textFields?.first!.text)!
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
        alertController.textFields?.first?.text = self.profesor.user
        let ok = UIAlertAction(title: "Cambiar", style: .default) { (UIAlertAction) in
            
            if self.alumnos.contains(where: {$0.user.lowercased() == (alertController.textFields?.first!.text)!.lowercased()}) {
                lanzarAlertaConUnBoton(viewController: self, title: "Usuario no disponible", message: "El usuario introducido para este profesor ya existe, por favor, escoge otro.", buttonText: "Aceptar", buttonType: .cancel)
                return
            } else {
                if alertController.textFields?.first?.text != "" {
                    self.profesor.user = (alertController.textFields?.first!.text)!
                    self.navigationItem.title = self.profesor.user.capitalized
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
        alertController.textFields?.first?.text = self.profesor.name.capitalized
        let ok = UIAlertAction(title: "Cambiar", style: .default) { (UIAlertAction) in
            if alertController.textFields?.first?.text != "" {
                self.profesor.name = (alertController.textFields?.first!.text)!
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
    
}

