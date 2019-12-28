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
    
    var alumno: Alumno!
    var listaExperimentos = [Experimento]()
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
        listaExperimentos.sort(by: {$0.dateString.compare($1.dateString) == .orderedDescending})
        self.navigationItem.title = alumno.user
    }
    
    func setUpUI() {
        studentImageView.layer.borderWidth = 7
        studentImageView.layer.borderColor = #colorLiteral(red: 0.9029806256, green: 0.7490995526, blue: 0, alpha: 1)
        self.studentImageView.layer.cornerRadius = studentImageView.frame.height / 2
        blurView.layer.cornerRadius = 15
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
            let filaSeleccionada = self.tableViewExperiments.indexPathForSelectedRow
            viewDestiny?.experimento = listaExperimentos[(self.indice?.row)!]
            viewDestiny?.container = self.container
        }
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
        cell.dateCell.text = listaExperimentos[indexPath.row].dateString
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
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
        
        
        return UISwipeActionsConfiguration(actions: [shareAction])
    }
    
}
