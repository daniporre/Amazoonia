//
//  ShowExperimentTeacherViewController.swift
//  amazoonia
//
//  Created by Daniel Martinez on 10/12/2019.
//  Copyright © 2019 Amazoonia. All rights reserved.
//

import UIKit
import CoreData

class ShowExperimentTeacherViewController: UIViewController {
    
    var nameExperiments = [String]()
    var imageExperiments = [UIImage]()
    var examples = [String]()
    var backgroundImages = [UIImage]()
    var colors = [UIColor]()
    
    @IBOutlet weak var typeLabel: UILabel!
    
    var alumno: Alumno!
    var experimento: Experimento!
    var container: NSPersistentContainer!
    
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
    
    @IBAction func qualifyButton(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Experimento", message: "\n\n\n", preferredStyle: .actionSheet)
        //MARK: -  CUSTOMVIEW IN ACTIONSHEET
        let view = UIView(frame: CGRect(x: 10, y: 40, width: alertController.view.bounds.size.width - 10 * 4.0, height: 72))
        view.backgroundColor = .clear
        
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.layer.cornerRadius = 10
        blurEffectView.clipsToBounds = true
        
        let image = UIImageView(frame: CGRect(x: 8, y: 8, width: 56, height: 56))
        image.image = UIImage(data: self.experimento.photo as Data)
        
        let labelTitle = UILabel(frame: CGRect(x: 76, y: 14, width: 160, height: 24))
        labelTitle.text = self.experimento.name
        labelTitle.textColor = #colorLiteral(red: 0.5019607843, green: 0.6509803922, blue: 0.4862745098, alpha: 1)
        labelTitle.font = UIFont(name: "AvenirNext-Bold", size: 17)
        
        let labelDate = UILabel(frame: CGRect(x: 76, y: 36, width: 160, height: 24))
        labelDate.text = self.experimento.dateString
        labelDate.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        labelDate.font = UIFont(name: "AvenirNext-UltraLightItalic", size: 17)
        
        let imageViewMark = UIImageView(frame: CGRect(x: 303, y: 25, width: 22, height: 22))
        
        if self.experimento.mark == "bad" {
            imageViewMark.image = #imageLiteral(resourceName: "bad")
        }
        if self.experimento.mark == "good" {
            imageViewMark.image = #imageLiteral(resourceName: "good")
        }
        if self.experimento.mark == "great" {
            imageViewMark.image = #imageLiteral(resourceName: "great")
        }
        if self.experimento.mark == "" {
            imageViewMark.image = #imageLiteral(resourceName: "mark")
        }
        
        view.addSubview(blurEffectView)
        view.addSubview(image)
        view.addSubview(imageViewMark)
        view.addSubview(labelDate)
        view.addSubview(labelTitle)
        
        
        
        alertController.view.addSubview(view)
        
        
        let qualify = UIAlertAction(title: "Calificar", style: .default) { (UIAlertAction) in
            self.performSegue(withIdentifier: "secondMarkSegue", sender: nil)
        }
        let comment = UIAlertAction(title: "Comentar", style: .destructive) { (UIAlertAction) in
            self.performSegue(withIdentifier: "commentSegue", sender: nil)
        }
        let cancel = UIAlertAction(title: "Cancelar", style: .cancel) { (UIAlertAction) in
            
        }
        cancel.setValue(#colorLiteral(red: 0, green: 0.4797514677, blue: 0.9984372258, alpha: 1), forKey: "titleTextColor")
        qualify.setValue(#colorLiteral(red: 0.3133951426, green: 0.4417499304, blue: 0.2995533347, alpha: 1), forKey: "titleTextColor")
        comment.setValue(#colorLiteral(red: 0.3133951426, green: 0.4417499304, blue: 0.2995533347, alpha: 1), forKey: "titleTextColor")
        
        
        qualify.setValue(UIImage(named: "calificar"), forKey: "image")
        comment.setValue(UIImage(named: "comment"), forKey: "image")
        
        alertController.addAction(cancel)
        alertController.addAction(qualify)
        alertController.addAction(comment)
        
        present(alertController, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "secondMarkSegue" {
            let viewDestiny = segue.destination as? ReviewViewController
            viewDestiny?.experimento = self.experimento
            viewDestiny?.container = self.container
        }
        if segue.identifier == "commentSegue" {
            let NavigationController = segue.destination as! UINavigationController
            let viewDestiny = NavigationController.topViewController as! CommentExperimentViewController
            viewDestiny.experimento = self.experimento
            viewDestiny.container = self.container
        }
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
