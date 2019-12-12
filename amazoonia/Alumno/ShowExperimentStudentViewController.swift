//
//  ShowExperimentStudentViewController.swift
//  amazoonia
//
//  Created by Daniel Martinez on 12/12/2019.
//  Copyright © 2019 Amazoonia. All rights reserved.
//

import UIKit

class ShowExperimentStudentViewController: UIViewController {
    
    @IBOutlet weak var typeLabel: UILabel!
    var nameExperiments = [String]()
    var imageExperiments = [UIImage]()
    var examples = [String]()
    var backgroundImages = [UIImage]()
    var colors = [UIColor]()

    override func viewDidLoad() {
        super.viewDidLoad()
        nameExperiments = ["Pone huevos","No produce leche","No es acuático","Es vertebrado", "Tiene 4 patas"]
        imageExperiments = [#imageLiteral(resourceName: "nidoLleno"),#imageLiteral(resourceName: "sinLeche"),#imageLiteral(resourceName: "tierra"),#imageLiteral(resourceName: "vertebrado"),#imageLiteral(resourceName: "arana4")]
        examples = ["Gallina, serpiente, golondrina, rana, tiburon." ,"Vaca, perro, gato, elefante, león.","Ballena, pez espada, medusa, calamar, cangrejo, estrella de mar.", "Lince, conejo, pez, cerdo, cabra.", "Caballo, tigre, oso, búfalo, cebra."]
        typeLabel.text = "Mamífero"
        backgroundImages = [#imageLiteral(resourceName: "nido"),#imageLiteral(resourceName: "leche"),#imageLiteral(resourceName: "mar"),#imageLiteral(resourceName: "huesos"),#imageLiteral(resourceName: "patas")]
        colors = [#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0),#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0),#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)]
        // Do any additional setup after loading the view.
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
        
        cell.titleCell.text = nameExperiments[indexPath.row]
        cell.imageExperimentCell.image = imageExperiments[indexPath.row]
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

