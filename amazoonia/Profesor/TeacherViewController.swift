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
    var listaAlumnos = [Alumno]()
    
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
        
        alumnos = ["José Ortega Cano","Alejandro Rodriguez Felices","Elena Nito Fernandez","Francisco Hernández Del Pino","David Martínez Fernandez","Juan Escaño García", "Penélope Luda Soler"]
        fotos = [#imageLiteral(resourceName: "niño5"),#imageLiteral(resourceName: "niño4"),#imageLiteral(resourceName: "niño1"),#imageLiteral(resourceName: "niño3"),#imageLiteral(resourceName: "niño2"),#imageLiteral(resourceName: "niño6"),#imageLiteral(resourceName: "niño7")]
        numExp = [7,5,7,4,5,7,3]
        

    }
    
    
    @IBAction func loadTeacher(sender: UIStoryboardSegue) {
        let sourceViewController = sender.destination as! ViewController
        
        profesor = sourceViewController.profesor
        
        listaAlumnos = profesor!.listaAlumnos.allObjects as! [Alumno]
        
        print(listaAlumnos)
    }

    
    override func viewDidAppear(_ animated: Bool) {
        setUpNavigationBar()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.studentsTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
    }
    
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
    
    func setUpBackGroundTableCell() {
        
    }
    func setNavigationBarStyle11(viewController: UIViewController){
        if #available(iOS 11.0, *) {
            viewController.navigationController?.navigationBar.prefersLargeTitles = true
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
        return alumnos.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Lista de alumnos/as"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TeacherTableViewCell", for: indexPath) as! TeacherTableViewCell
        
        
        cell.nameCell.text = alumnos[indexPath.row]
        cell.imageViewCell.image = fotos[indexPath.row]
        cell.numExpCell.text = "Número de experimentos: \(String(numExp[indexPath.row]))"
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
    
    
    
}
