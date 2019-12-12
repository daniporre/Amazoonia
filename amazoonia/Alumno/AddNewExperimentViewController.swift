//
//  AddNewExperimentViewController.swift
//  amazoonia
//
//  Created by Daniel Martinez on 11/12/2019.
//  Copyright © 2019 Amazoonia. All rights reserved.
//

import UIKit

class AddNewExperimentViewController: UIViewController {

    var nameExperiments = [String]()
    var imageExperiments = [UIImage]()
    var examples = [String]()
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    var pickerData = ["Anfibio","Ave","Insecto","Mamífero","Pez","Reptil"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTemporallyData()
        setUpViews()
        // Do any additional setup after loading the view.
    }
    
    func setUpViews() {
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        self.nameTextField.delegate = self
        self.navigationItem.leftBarButtonItem?.image = #imageLiteral(resourceName: "cancel").withRenderingMode(.alwaysTemplate)
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem?.image = #imageLiteral(resourceName: "done").withRenderingMode(.alwaysTemplate)
    }
    
    func setUpTemporallyData() {
        nameExperiments = ["¿Pone huevos?","¿Produce leche?","¿Es acuático?","¿Es vertebrado?", "¿Cuantas patas tiene?"]
        imageExperiments = [#imageLiteral(resourceName: "nidoLleno"),#imageLiteral(resourceName: "sinLeche"),#imageLiteral(resourceName: "tierra"),#imageLiteral(resourceName: "vertebrado"),#imageLiteral(resourceName: "arana4")]
    }
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        
        
        
        let alertController = UIAlertController(title: "Guardar nuevo experimento", message: "¿Está seguro/a de que quiere guardar el experimento con nombre \(nameTextField.text!) a la lista de experimentos?", preferredStyle: .actionSheet)
        
        let ok = UIAlertAction(title: "Guardar", style: .default) { (UIAlertAction) in
            self.dismiss(animated: true, completion: nil)
        }
        let cancel = UIAlertAction(title: "Cancelar", style: .cancel) { (UIAlertAction) in
            
        }
        
        alertController.addAction(cancel)
        alertController.addAction(ok)
        
        present(alertController, animated: true)
        
    }
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Cancelar", message: "¿Estás seguro/a de que no quieres realizar este experimento", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "No realizar", style: .destructive) { (UIAlertAction) in
            self.dismiss(animated: true, completion: nil)
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    
}

extension AddNewExperimentViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return self.view.endEditing(true)
    }
}
