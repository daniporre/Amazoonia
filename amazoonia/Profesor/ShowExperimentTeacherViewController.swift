//
//  ShowExperimentTeacherViewController.swift
//  amazoonia
//
//  Created by Daniel Martinez on 10/12/2019.
//  Copyright © 2019 Amazoonia. All rights reserved.
//

import UIKit

class ShowExperimentTeacherViewController: UIViewController {
    
    var nameExperiments = [String]()
    var imageExperiments = [UIImage]()
    var examples = [String]()
    var backgroundImages = [UIImage]()
    var colors = [UIColor]()
    
    @IBOutlet weak var typeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameExperiments = ["Pone huevos","No produce leche","No es acuático","Es vertebrado"]
        imageExperiments = [#imageLiteral(resourceName: "nidoLleno"),#imageLiteral(resourceName: "sinLeche"),#imageLiteral(resourceName: "tierra"),#imageLiteral(resourceName: "vertebrado"),]
        examples = ["Gallina, serpiente, golondrina, rana, tiburon." ,"Vaca, perro, gato, elefante, leon, tigre.","Ballena, pez espada, medusa, calamar, cangrejo, estrella de mar.", "Lince, conejo, pez, cerdo, cabra."]
        typeLabel.text = "Mamífero"
        backgroundImages = [#imageLiteral(resourceName: "nido"),#imageLiteral(resourceName: "leche"),#imageLiteral(resourceName: "mar"),#imageLiteral(resourceName: "huesos")]
        colors = [#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0),#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)]
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

extension ShowExperimentTeacherViewController: UITableViewDelegate, UITableViewDataSource {

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
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShowExperimentTeacherTableViewCell", for: indexPath) as! ShowExperimentTeacherTableViewCell

        cell.titleCell.text = nameExperiments[indexPath.row]
        cell.imageExperimentCell.image = imageExperiments[indexPath.row]
        cell.examplesLabelCell.text = "Ejemplos: \(examples[indexPath.row])"
        cell.backgroundViewCell.layer.cornerRadius = 10
        cell.backgroundViewCell.clipsToBounds = true
        cell.backgroundImageCell.image = backgroundImages[indexPath.row]
        cell.examplesLabelCell.textColor = colors[indexPath.row]


        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }

}
