//
//  AddNewExperimentViewController.swift
//  amazoonia
//
//  Created by Daniel Martinez on 11/12/2019.
//  Copyright © 2019 Amazoonia. All rights reserved.
//

import UIKit
import CoreData

class AddNewExperimentViewController: UIViewController {

    @IBOutlet weak var viewTextfield: UIView!
    @IBOutlet weak var labelTexfield: UILabel!
    @IBOutlet weak var experimentTableview: UITableView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    var nameExperiments = [String]()
    var imageExperiments = [UIImage]()
    var examples = [String]()
    var pickerData = ["Anfibio","Ave","Insecto","Mamífero","Pez","Reptil","Invertebrado"]
    
    let imageMamiferos = [#imageLiteral(resourceName: "hipopotamo"),#imageLiteral(resourceName: "cerdo"),#imageLiteral(resourceName: "koala"),#imageLiteral(resourceName: "erizo"),#imageLiteral(resourceName: "tigre1")]
    let imageInvertebrados = [#imageLiteral(resourceName: "cangrejo"),#imageLiteral(resourceName: "caracol"),#imageLiteral(resourceName: "almeja"),#imageLiteral(resourceName: "camaron"),#imageLiteral(resourceName: "calamar")]
    let imageInsectos = [#imageLiteral(resourceName: "libelula"),#imageLiteral(resourceName: "mariposa"),#imageLiteral(resourceName: "abeja"),#imageLiteral(resourceName: "volar"),#imageLiteral(resourceName: "escarabajo")]
    let imageAves = [#imageLiteral(resourceName: "flamenco"),#imageLiteral(resourceName: "pajaro (1)"),#imageLiteral(resourceName: "pajaro"),#imageLiteral(resourceName: "pajaro (2)"),#imageLiteral(resourceName: "pelicano")]
    let imageAnfibios = [#imageLiteral(resourceName: "rana"),#imageLiteral(resourceName: "sapo")]
    let imagePeces = [#imageLiteral(resourceName: "pescado (2)"),#imageLiteral(resourceName: "pez-volador"),#imageLiteral(resourceName: "pescado (1)"),#imageLiteral(resourceName: "pescado"),#imageLiteral(resourceName: "raya")]
    let imageReptiles = [#imageLiteral(resourceName: "cocodrilo"),#imageLiteral(resourceName: "camaleon"),#imageLiteral(resourceName: "tortuga"),#imageLiteral(resourceName: "serpiente"),#imageLiteral(resourceName: "lagarto")]
    
    var alumno = Alumno()
    var container: NSPersistentContainer!
    var experimento: Experimento!
    
    var aquatic: Bool = false
    var backBone: Bool = false
    var eggs: Bool = false
    var milk: Bool = false
    var legs: Int16 = 0
    var name: String = ""
    var type: String = ""
    
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTemporallyData()
        setUpViews()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(self.alumno)
    }
    
    func setUpViews() {
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        self.nameTextField.delegate = self
        self.navigationItem.leftBarButtonItem?.image = #imageLiteral(resourceName: "cancel").withRenderingMode(.alwaysTemplate)
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem?.image = #imageLiteral(resourceName: "done").withRenderingMode(.alwaysTemplate)
        self.saveButton.isEnabled = false
        addToolBarForCalcules(viewController: self, titulo: "Introduce el nombre del animal", textField: nameTextField, selectorCalc: #selector(self.dismissKeyboard))
    }

    @objc func dismissKeyboard(){
        self.view.endEditing(true)
    }
    
    func setUpTemporallyData() {
        nameExperiments = ["¿Pone huevos?","¿Produce leche?","¿Es acuático?","¿Es vertebrado?", "¿Cuantas patas tiene?"]
        imageExperiments = [#imageLiteral(resourceName: "nidoVacio"),#imageLiteral(resourceName: "sinLeche"),#imageLiteral(resourceName: "tierra"),#imageLiteral(resourceName: "invertebrado"),#imageLiteral(resourceName: "arana0")]
    }
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        
        
        
        let alertController = UIAlertController(title: "Guardar nuevo experimento", message: "¿Está seguro/a de que quiere guardar el experimento con nombre \(nameTextField.text!) a la lista de experimentos?", preferredStyle: .actionSheet)
        
        let ok = UIAlertAction(title: "Guardar", style: .default) { (UIAlertAction) in
            
            self.experimento = Experimento(context: self.container.viewContext)
            
            self.experimento.eggs = self.eggs
            self.experimento.aquatic = self.aquatic
            self.experimento.backbone = self.backBone
            self.experimento.milk = self.milk
            self.experimento.legs = self.legs
            self.experimento.name = String(self.nameTextField.text!).capitalized
            self.experimento.type = self.type.capitalized
            
            if self.experimento.type == "Mamífero" {
                let randomIndex = Int.random(in: 0...self.imageMamiferos.count-1)
                let randomImage = self.imageMamiferos[randomIndex]
                self.experimento.photo = randomImage.pngData() as! NSData
            }
            if self.experimento.type == "Anfibio" {
                let randomIndex = Int.random(in: 0...self.imageAnfibios.count-1)
                let randomImage = self.imageAnfibios[randomIndex]
                self.experimento.photo = randomImage.pngData() as! NSData
            }
            if self.experimento.type == "Ave" {
                let randomIndex = Int.random(in: 0...self.imageAves.count-1)
                let randomImage = self.imageAves[randomIndex]
                self.experimento.photo = randomImage.pngData() as! NSData
            }
            if self.experimento.type == "Pez" {
                let randomIndex = Int.random(in: 0...self.imagePeces.count-1)
                let randomImage = self.imagePeces[randomIndex]
                self.experimento.photo = randomImage.pngData() as! NSData
            }
            if self.experimento.type == "Invertebrado" {
                let randomIndex = Int.random(in: 0...self.imageInvertebrados.count-1)
                let randomImage = self.imageInvertebrados[randomIndex]
                self.experimento.photo = randomImage.pngData() as! NSData
            }
            if self.experimento.type == "Insecto" {
                let randomIndex = Int.random(in: 0...self.imageInsectos.count-1)
                let randomImage = self.imageInsectos[randomIndex]
                self.experimento.photo = randomImage.pngData() as! NSData
            }
            if self.experimento.type == "Reptil" {
                let randomIndex = Int.random(in: 0...self.imageReptiles.count-1)
                let randomImage = self.imageReptiles[randomIndex]
                self.experimento.photo = randomImage.pngData() as! NSData
            }
            
            self.alumno.addToExperimentos(self.experimento)
            self.saveContext()
            
            if self.presentingViewController is UINavigationController{
                self.dismiss(animated: true, completion: nil)
            }else{
                self.navigationController!.popViewController(animated: true)
            }
        }
        let cancel = UIAlertAction(title: "Cancelar", style: .cancel) { (UIAlertAction) in
            
        }
        
        alertController.addAction(cancel)
        alertController.addAction(ok)
        
        present(alertController, animated: true)
        
    }
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        
        if (nameTextField.text?.isEmpty)! {
            if self.presentingViewController is UINavigationController{
                self.dismiss(animated: true, completion: nil)
            }else{
                self.navigationController!.popViewController(animated: true)
            }
            return
        }
        
        let alertController = UIAlertController(title: "Cancelar", message: "¿Estás seguro/a de que no quieres realizar el experimento \(nameTextField.text!)", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "No realizar", style: .destructive) { (UIAlertAction) in
            if self.presentingViewController is UINavigationController{
                self.dismiss(animated: true, completion: nil)
            }else{
                self.navigationController!.popViewController(animated: true)
            }
        }
        let cancel = UIAlertAction(title: "Realizar", style: .cancel) { (UIAlertAction) in
            
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
    func saveContext() {
        if container.viewContext.hasChanges {
            do {
                try container.viewContext.save()
            } catch {
                print("An error ocurred shile saving: \(error)")
            }
        }
    }
}

extension AddNewExperimentViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label = UILabel()
        if let v = view {
            label = v as! UILabel
        }
        
        label.font = UIFont(name: "AvenirNext-Heavy", size: 20.0)
        label.text = pickerData[row]
        label.textColor = UIColor.white
        label.textAlignment = .center
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.type = pickerData[row]
    }
    
}

extension AddNewExperimentViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameExperiments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddNewExperimentTableViewCell") as? AddNewExperimentTableViewCell
        cell?.askLabelCell.text = nameExperiments[indexPath.row]
        cell?.imageViewCell.image = imageExperiments[indexPath.row]
        
        
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = self.experimentTableview.cellForRow(at: indexPath) as! AddNewExperimentTableViewCell
        
        if indexPath.row == 0 {
            print("Fila 0")
            self.eggs = !self.eggs
            if self.eggs {
                cell.imageViewCell.image = #imageLiteral(resourceName: "nidoLleno")
            } else {
                cell.imageViewCell.image = #imageLiteral(resourceName: "nidoVacio")
            }
            print(self.eggs)
            
        }
        if indexPath.row == 1 {
            print("Fila 1")
            self.milk = !self.milk
            if self.milk {
                cell.imageViewCell.image = #imageLiteral(resourceName: "conLeche")
            } else {
                cell.imageViewCell.image = #imageLiteral(resourceName: "sinLeche")
            }
            print(self.milk)
        }
        if indexPath.row == 2 {
            print("Fila 2")
            self.aquatic = !self.aquatic
            if self.aquatic {
                cell.imageViewCell.image = #imageLiteral(resourceName: "maricono")
            } else {
                cell.imageViewCell.image = #imageLiteral(resourceName: "tierra")
            }
            print(self.aquatic)
        }
        if indexPath.row == 3 {
            print("Fila 3")
            self.backBone = !self.backBone
            if self.backBone {
                cell.imageViewCell.image = #imageLiteral(resourceName: "vertebrado")
            } else {
                cell.imageViewCell.image = #imageLiteral(resourceName: "invertebrado")
            }
            print(self.backBone)
        }
        if indexPath.row == 4 {
            print("Fila 4")
            
            if self.legs == 8 as Int16 {
                self.legs = 0 as Int16
                cell.imageViewCell.image = #imageLiteral(resourceName: "arana0")
                print(self.legs)
                return
            }
            self.legs = self.legs + 2 as Int16
            
            if self.legs == 0 as Int16 {
                cell.imageViewCell.image = #imageLiteral(resourceName: "arana0")
            }
            if self.legs == 2 as Int16 {
                cell.imageViewCell.image = #imageLiteral(resourceName: "arana2")
            }
            if self.legs == 4 as Int16 {
                cell.imageViewCell.image = #imageLiteral(resourceName: "arana4")
            }
            if self.legs == 6 as Int16 {
                cell.imageViewCell.image = #imageLiteral(resourceName: "arana6")
            }
            if self.legs == 8 as Int16 {
                cell.imageViewCell.image = #imageLiteral(resourceName: "arana8")
            }
            
            print(self.legs)
        }
        return
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    
}

extension AddNewExperimentViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return self.view.endEditing(true)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if (nameTextField.text?.isEmpty)! {
            UIView.animate(withDuration: 0.5, delay: 0.2, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: [], animations: {
                
                
                let scaleLabel = CGAffineTransform(scaleX: 1, y: 1)
                let transformLabel = CGAffineTransform(translationX: 0.0, y: 0.0)
                
            
                
                self.labelTexfield.transform = scaleLabel.concatenating(transformLabel)
                self.viewTextfield.transform = CGAffineTransform(translationX: 0.0, y: 0.0)
                self.viewTextfield.backgroundColor = UIColor.lightGray
                self.labelTexfield.textColor = UIColor.lightGray
                
            }, completion: nil)
        }
        
        if !(nameTextField.text?.isEmpty)! {
            saveButton.isEnabled = true
        }
        if (nameTextField.text?.isEmpty)! {
            saveButton.isEnabled = false
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.5, delay: 0.1, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: [], animations: {
            
            
            let scaleLabel = CGAffineTransform(scaleX: 0.85, y: 0.85)
            let transformLabel = CGAffineTransform(translationX: -3.5, y: -20.0)
            
            self.labelTexfield.transform = scaleLabel.concatenating(transformLabel)
            self.viewTextfield.transform = CGAffineTransform(translationX: 0, y: 5.0)
            self.labelTexfield.textColor = #colorLiteral(red: 0.2779085934, green: 0.3907533586, blue: 0.2644636631, alpha: 1)
            self.viewTextfield.backgroundColor = #colorLiteral(red: 0.2779085934, green: 0.3907533586, blue: 0.2644636631, alpha: 1)
            
        }, completion: nil)
    }
}
