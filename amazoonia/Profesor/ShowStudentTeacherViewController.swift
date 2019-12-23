//
//  ShowStudentTeacherViewController.swift
//  amazoonia
//
//  Created by Daniel Martinez on 07/12/2019.
//  Copyright © 2019 Amazoonia. All rights reserved.
//

import UIKit

class ShowStudentTeacherViewController: UIViewController {
    
    @IBOutlet weak var studentImageView: UIImageView!
    @IBOutlet weak var nameTextField: UILabel!
    @IBOutlet weak var numExpTextField: UILabel!
    @IBOutlet weak var tableViewExperiments: UITableView!
    @IBOutlet weak var blurView: UIVisualEffectView!
    
    var alumno: Alumno!
    var listaExperimentos = [Experimento]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableViewExperiments.reloadData()
        listaExperimentos = alumno!.experimentos.allObjects as! [Experimento]
    }
    
    
    func setUpUI() {
        studentImageView.layer.borderWidth = 7
        studentImageView.layer.borderColor = #colorLiteral(red: 0.9029806256, green: 0.7490995526, blue: 0, alpha: 1)
        self.studentImageView.layer.cornerRadius = studentImageView.frame.height / 2
        blurView.layer.cornerRadius = 15
        setNormalNavigationBar(viewController: self)
        
        nameTextField.text = alumno.name
        numExpTextField.text = "Número de experimentos: \(String(alumno!.numExp as Int16))"
        studentImageView.image = UIImage(data: alumno.photo as Data)
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

extension ShowStudentTeacherViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaExperimentos.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Lista de experimentos"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentTeacherTableViewCell", for: indexPath) as! StudentTeacherTableViewCell
        cell.imageViewCell.image = UIImage(data: alumno.photo as Data)
        cell.nameCell.text = listaExperimentos[indexPath.row].name
//        cell.dateCell.text = listaExperimentos[indexPath.row].date
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        //Creamos la accion Eliminar de tipo UIContextualAction para la celda...
        
        
        //Creamos la accion Compartir de tipo UIContextualAction para la celda...
        let shareAction = UIContextualAction(style: .destructive, title:  "Calificar", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            
            let vc = self.storyboard!.instantiateViewController(withIdentifier: "qualifyViewController")
            self.present(vc, animated: true, completion: nil)
            
            //respuesta haptica de tipo impacto...
            let impact: UIImpactFeedbackGenerator.FeedbackStyle = .heavy
            let generator = UIImpactFeedbackGenerator(style: impact)
            generator.prepare()
            
            generator.impactOccurred()
        })
        shareAction.image = #imageLiteral(resourceName: "calificar").withRenderingMode(.alwaysTemplate)
        shareAction.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        
        return UISwipeActionsConfiguration(actions: [shareAction])
    }
    
}
