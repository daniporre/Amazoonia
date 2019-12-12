//
//  StudentViewController.swift
//  amazoonia
//
//  Created by Daniel Martinez on 11/12/2019.
//  Copyright © 2019 Amazoonia. All rights reserved.
//

import UIKit

class StudentViewController: UIViewController {
    
    @IBOutlet weak var studentImageView: UIImageView!
    @IBOutlet weak var nameStudentLabel: UILabel!
    @IBOutlet weak var numExpStudentLabel: UILabel!
    @IBOutlet weak var blurViewBackground: UIVisualEffectView!
    @IBOutlet weak var tableView: UITableView!
    
    var experiments = [String]()
    var date = [String]()
    var fotos = [UIImage]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        setUpHeaderView()
        setUpTemporallyData()
        setUpTableView()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.tableView.reloadData()
    }
    
    @IBAction func newExperimentButton(_ sender: UIButton) {
        
        
        
    }
    
    func setUpTableView(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func setUpTemporallyData() {
        experiments = ["Experimento1","Experimento2","Experimento3","Experimento4","Experimento5","Experimento6","Experimento7"]
        date = ["20/02/2019","30/04/2019","18/09/2019","28/11/2019","28/11/2019","28/11/2019","28/11/2019"]
        fotos = [#imageLiteral(resourceName: "pajaro"),#imageLiteral(resourceName: "libelula"),#imageLiteral(resourceName: "cocodrilo"),#imageLiteral(resourceName: "pez-volador"),#imageLiteral(resourceName: "sapo"),#imageLiteral(resourceName: "tigre"),#imageLiteral(resourceName: "koala"),]
    }
    
    func setUpHeaderView() {
        self.studentImageView.layer.cornerRadius = studentImageView.frame.height / 2
        blurViewBackground.layer.cornerRadius = 15
        // Do any additional setup after loading the view.
        nameStudentLabel.text = "Jose Ortega Cano"
        numExpStudentLabel.text = "Numero de experimentos: 7"
        studentImageView.layer.borderWidth = 7
        studentImageView.layer.borderColor = #colorLiteral(red: 0.9029806256, green: 0.7490995526, blue: 0, alpha: 1)
    }
    
    func setUpNavigationBar() {
        
        //        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationItem.leftBarButtonItem?.image = #imageLiteral(resourceName: "logout").withRenderingMode(.alwaysTemplate)
        
        self.navigationItem.rightBarButtonItem?.image = #imageLiteral(resourceName: "addNewStudent").withRenderingMode(.alwaysTemplate)
        setNormalNavigationBar(viewController: self)
        self.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem?.image = #imageLiteral(resourceName: "noun_Power_1482886").withRenderingMode(.alwaysTemplate)
        
    }
    
    func setNormalNavigationBar(viewController: UIViewController){
        if #available(iOS 11.0, *) {
            viewController.navigationItem.largeTitleDisplayMode = .never
        }
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

extension StudentViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if experiments.count == 0 {
            return 1
        }
        return experiments.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Lista de experimentos"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentTableViewCell", for: indexPath) as! StudentTableViewCell
        
        if experiments.count == 0 {
            
            cell.imageViewCell.image = #imageLiteral(resourceName: "nullContent")
            cell.imageViewCell.backgroundColor = #colorLiteral(red: 1, green: 0.2800146937, blue: 0.3337086439, alpha: 1)
            cell.imageViewCell.clipsToBounds = true
            cell.imageViewCell.layer.cornerRadius = cell.imageViewCell.frame.height / 2
            cell.nameCell.text = "No hay ningun experimento"
            cell.dateCell.text = "Pulsa el botón Añadir experimento para crear uno nuevo."
            cell.accessoryType = .none
            self.tableView.tableFooterView = UIView(frame: CGRect.zero)
            
            return cell
        }
        
        
        cell.imageViewCell.image = fotos[indexPath.row]
        cell.nameCell.text = experiments[indexPath.row]
        cell.dateCell.text = date[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if experiments.count != 0 {
        //Creamos la accion Eliminar de tipo UIContextualAction para la celda...
            let deleteAction = UIContextualAction(style: .destructive, title:  "Eliminar", handler: { (ac:UIContextualAction, view:UIView, success:@escaping (Bool) -> Void) in
            
                //Alerta con tres tipos de acciones
                let alertController = UIAlertController(title: "Eliminar", message: "¿Estás seguro de que quieres eliminar \(self.experiments[indexPath.row]) de tus experimentos?", preferredStyle: .alert)
                //Creamos el generador de hapticFeedback
                let generator = UINotificationFeedbackGenerator()
                generator.prepare()
                //Hacemos que mande una notificacion al usuario de tipo warning de forma haptica...
                generator.notificationOccurred(.warning)
                
                let alertAction = UIAlertAction(title: "Eliminar seleccionado", style: .destructive, handler: { (UIAlertAction) in
                    self.experiments.remove(at: indexPath.row)
                    self.tableView.deleteRows(at: [indexPath], with: .left)
                    let generator = UINotificationFeedbackGenerator()
                    generator.prepare()
                    //Notifiacion de tipo error...
                    generator.notificationOccurred(.error)
                    success(true)
                })
                let deleteAll = UIAlertAction(title: "Eliminar todos", style: .destructive, handler: { (UIAlertAction) in
                    self.experiments.removeAll()
                    print(self.experiments.count)
                    let generator = UINotificationFeedbackGenerator()
                    generator.prepare()
                    generator.notificationOccurred(.error)
                    self.tableView.reloadData()
                })
                let cancelarAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: { (UIAlertAction) in
                    self.tableView.isEditing = false
                  self.tableView.reloadData()
                })
                alertController.addAction(cancelarAction)
                alertController.addAction(alertAction)
                alertController.addAction(deleteAll)
            
                self.present(alertController, animated: true)
            
                // Reset state
            
            })
            deleteAction.image = #imageLiteral(resourceName: "delete").withRenderingMode(.alwaysTemplate)
            deleteAction.title = "Eliminar"
        
            //Creamos la accion Compartir de tipo UIContextualAction para la celda...
            let shareAction = UIContextualAction(style: .destructive, title:  "Compartir", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            
                //Aqui llamamos al UIActivityViewController y establcemos lo que queremos compartir, en mi caso un texto y una imagen del paisaje.
                let defaultText = "Mira mi experimento: \(self.experiments[indexPath.row])"
                let activityController = UIActivityViewController(activityItems: [defaultText, self.fotos[indexPath.row]], applicationActivities: nil)
                //respuesta haptica de tipo impacto...
                let impact: UIImpactFeedbackGenerator.FeedbackStyle = .heavy
                //            if #available(iOS 13, *) {
                //                impact = .rigid
                //            }
                let generator = UIImpactFeedbackGenerator(style: impact)
                generator.prepare()
            
                self.present(activityController, animated: true, completion: nil)
                generator.impactOccurred()
            })
            shareAction.image = #imageLiteral(resourceName: "share").withRenderingMode(.alwaysTemplate)
            shareAction.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        
            deleteAction.backgroundColor = .red
            return UISwipeActionsConfiguration(actions: [deleteAction, shareAction])
        }
        
        let createAction = UIContextualAction(style: .destructive, title:  "Crear", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            
            self.performSegue(withIdentifier: "addNewExperiment", sender: nil)
            
            
            let impact: UIImpactFeedbackGenerator.FeedbackStyle = .heavy
            //            if #available(iOS 13, *) {
            //                impact = .rigid
            //            }
            let generator = UIImpactFeedbackGenerator(style: impact)
            generator.prepare()
            generator.impactOccurred()
        })
        
        createAction.backgroundColor = #colorLiteral(red: 1, green: 0.8705882353, blue: 0.3490196078, alpha: 1)
        
        return UISwipeActionsConfiguration(actions: [createAction])
    }
    
    
}
