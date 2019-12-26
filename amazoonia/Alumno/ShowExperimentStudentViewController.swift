//
//  ShowExperimentStudentViewController.swift
//  amazoonia
//
//  Created by Daniel Martinez on 12/12/2019.
//  Copyright © 2019 Amazoonia. All rights reserved.
//

import UIKit
import CoreData

class ShowExperimentStudentViewController: UIViewController {
    
    @IBOutlet weak var typeLabel: UILabel!
    var nameExperiments = [String]()
    var imageExperiments = [UIImage]()
    var examples = [String]()
    var backgroundImages = [UIImage]()
    var colors = [UIColor]()
    
    var alumno: Alumno!
    var experimento: Experimento!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    func setUpUI() {
        nameExperiments = ["Pone huevos","No produce leche","No es acuático","Es vertebrado", "Tiene 4 patas"]
        imageExperiments = [#imageLiteral(resourceName: "nidoLleno"),#imageLiteral(resourceName: "sinLeche"),#imageLiteral(resourceName: "tierra"),#imageLiteral(resourceName: "vertebrado"),#imageLiteral(resourceName: "arana4")]
        examples = ["Gallina, serpiente, golondrina, rana, tiburon." ,"Vaca, perro, gato, elefante, león.","Ballena, pez espada, medusa, calamar, cangrejo, estrella de mar.", "Lince, conejo, pez, cerdo, cabra.", "Caballo, tigre, oso, búfalo, cebra."]
        backgroundImages = [#imageLiteral(resourceName: "nido"),#imageLiteral(resourceName: "leche"),#imageLiteral(resourceName: "mar"),#imageLiteral(resourceName: "huesos"),#imageLiteral(resourceName: "patas")]
        colors = [#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0),#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0),#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)]
        
        //MARK: - DATA
        self.navigationItem.title = "Test: \(self.experimento.name.capitalized)"
        self.typeLabel.text = self.experimento.type.capitalized
        
        
    }
    
}

extension ShowExperimentStudentViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameExperiments.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    //    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    //        return "Lista de alumnos/as"
    //    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShowExperimentStudentTableViewCell", for: indexPath) as! ShowExperimentStudentTableViewCell
        
        
        if indexPath.row == 0 {
            if self.experimento.eggs {
                cell.titleCell.text = "Pone huevos"
                cell.imageExperimentCell.image = #imageLiteral(resourceName: "nidoLleno")
            } else {
                cell.titleCell.text = "No pone huevos"
                cell.imageExperimentCell.image = #imageLiteral(resourceName: "nidoVacio")
            }
        }
        
        if indexPath.row == 1 {
            if self.experimento.milk {
                cell.titleCell.text = "Produce Leche"
                cell.imageExperimentCell.image = #imageLiteral(resourceName: "conLeche")
            } else {
                cell.titleCell.text = "No produce Leche"
                cell.imageExperimentCell.image = #imageLiteral(resourceName: "sinLeche")
            }
        }
        
        if indexPath.row == 2 {
            if self.experimento.aquatic {
                cell.titleCell.text = "Es acuático"
                cell.imageExperimentCell.image = #imageLiteral(resourceName: "maricono")
            } else {
                cell.titleCell.text = "No es acuático"
                cell.imageExperimentCell.image = #imageLiteral(resourceName: "tierra")
            }
        }
        
        if indexPath.row == 3 {
            if self.experimento.backbone {
                cell.titleCell.text = "Es vertebrado"
                cell.imageExperimentCell.image = #imageLiteral(resourceName: "vertebrado")
            } else {
                cell.titleCell.text = "No es vertebrado"
                cell.imageExperimentCell.image = #imageLiteral(resourceName: "invertebrado")
            }
        }
        
        if indexPath.row == 4 {
            if self.experimento.legs == 0 as Int16 {
                cell.titleCell.text = "Tiene 0 patas"
                cell.imageExperimentCell.image = #imageLiteral(resourceName: "arana0")
            } else if self.experimento.legs == 2 as Int16 {
                cell.titleCell.text = "Tiene 2 patas"
                cell.imageExperimentCell.image = #imageLiteral(resourceName: "arana2")
            } else if self.experimento.legs == 4 as Int16 {
                cell.titleCell.text = "Tiene 4 patas"
                cell.imageExperimentCell.image = #imageLiteral(resourceName: "arana4")
            } else if self.experimento.legs == 6 as Int16 {
                cell.titleCell.text = "Tiene 6 patas"
                cell.imageExperimentCell.image = #imageLiteral(resourceName: "arana6")
            } else if self.experimento.legs == 8 as Int16 {
                cell.titleCell.text = "Tiene 8 patas"
                cell.imageExperimentCell.image = #imageLiteral(resourceName: "arana8")
            }
        }
        
        cell.examplesLabelCell.text = "Ejemplos: \(examples[indexPath.row])"
        cell.backgroundViewCell.layer.cornerRadius = 10
        cell.backgroundViewCell.clipsToBounds = true
        cell.backgroundImageCell.image = backgroundImages[indexPath.row]
        cell.examplesLabelCell.textColor = colors[indexPath.row]
        
        cell.examplesLabelCell.layer.shadowRadius = 2
        cell.examplesLabelCell.layer.shadowColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        cell.examplesLabelCell.layer.shadowOpacity = 5
        cell.examplesLabelCell.layer.shadowOffset = CGSize(width: 0, height: 3)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
}

