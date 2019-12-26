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
    
    var container: NSPersistentContainer!
    var fetchResultsController: NSFetchedResultsController<Profesor>!
    
    
    var alumnos = [String]()
    var fotos = [UIImage]()
    var numExp = [Int]()
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
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.studentsTableView.reloadData()
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = self.profesor.user.capitalized
        listaAlumnos2 = profesor!.listaAlumnos.allObjects as! [Alumno]
//        loadSavedData()
        print(profesor.listaAlumnos)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
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
        self.navigationController?.navigationItem.leftBarButtonItem?.image = #imageLiteral(resourceName: "logout").withRenderingMode(.alwaysTemplate)
        
        self.navigationItem.rightBarButtonItem?.image = #imageLiteral(resourceName: "addNewStudent").withRenderingMode(.alwaysTemplate)
        setNavigationBarStyle11(viewController: self)
        self.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem?.image = #imageLiteral(resourceName: "noun_Power_1482886").withRenderingMode(.alwaysTemplate)
        
    }
    
    func setNavigationBarStyle11(viewController: UIViewController){
        if #available(iOS 11.0, *) {
            viewController.navigationController?.navigationBar.prefersLargeTitles = true
        }
    }
    
}
