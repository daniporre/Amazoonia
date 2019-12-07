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
    
    var experiments = [String]()
    var date = [String]()
    var fotos = [UIImage]()

    override func viewDidLoad() {
        super.viewDidLoad()
        experiments = ["Experimento1","Experimento2","Experimento3","Experimento4","Experimento5","Experimento6","Experimento7"]
        date = ["20/02/2019","30/04/2019","18/09/2019","28/11/2019","28/11/2019","28/11/2019","28/11/2019"]
        fotos = [#imageLiteral(resourceName: "pajaro"),#imageLiteral(resourceName: "libelula"),#imageLiteral(resourceName: "cocodrilo"),#imageLiteral(resourceName: "pez-volador"),#imageLiteral(resourceName: "sapo"),#imageLiteral(resourceName: "tigre"),#imageLiteral(resourceName: "koala"),]
        self.studentImageView.layer.cornerRadius = studentImageView.frame.height / 2
        blurView.layer.cornerRadius = 15
        // Do any additional setup after loading the view.
        nameTextField.text = "Jose Ortega Cano"
        numExpTextField.text = "Numero de experimentos: 7"
        studentImageView.layer.borderWidth = 7
        studentImageView.layer.borderColor = #colorLiteral(red: 0.9029806256, green: 0.7490995526, blue: 0, alpha: 1)
        
        setNormalNavigationBar(viewController: self)
    }
    
    func setNormalNavigationBar(viewController: UIViewController){
        if #available(iOS 11.0, *) {
            viewController.navigationItem.largeTitleDisplayMode = .never
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

extension ShowStudentTeacherViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return experiments.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Lista de experimentos"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentTeacherTableViewCell", for: indexPath) as! StudentTeacherTableViewCell
        cell.imageViewCell.image = fotos[indexPath.row]
        cell.nameCell.text = experiments[indexPath.row]
        cell.dateCell.text = date[indexPath.row]
        cell.accessoryType = .detailDisclosureButton
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    
}
