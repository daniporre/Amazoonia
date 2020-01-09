//
//  CommentExperimentViewController.swift
//  amazoonia
//
//  Created by Daniel Martinez on 06/01/2020.
//  Copyright © 2020 Amazoonia. All rights reserved.
//

import UIKit
import CoreData

class CommentExperimentViewController: UIViewController {
    
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var commentTextview: UITextView!
    
    @IBOutlet weak var experimentImageView: UIImageView!
    @IBOutlet weak var nameExperimentLabel: UILabel!
    @IBOutlet weak var dateExperimentLabel: UILabel!
    @IBOutlet weak var markExperimentImageView: UIImageView!
    @IBOutlet weak var experimentBlurview: UIVisualEffectView!
    @IBOutlet weak var commentButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    var experimento: Experimento!
    var container: NSPersistentContainer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.commentTextview.becomeFirstResponder()
        
        self.experimentImageView.image = UIImage(data: self.experimento.photo as Data)
        self.nameExperimentLabel.text = self.experimento.name
        self.dateExperimentLabel.text = self.experimento.dateString
        if self.experimento.mark == "bad" {
            self.markExperimentImageView.image = #imageLiteral(resourceName: "bad")
        }
        if self.experimento.mark == "good" {
            self.markExperimentImageView.image = #imageLiteral(resourceName: "good")
        }
        if self.experimento.mark == "great" {
            self.markExperimentImageView.image = #imageLiteral(resourceName: "great")
        }
        if self.experimento.mark == "" {
            self.markExperimentImageView.image = #imageLiteral(resourceName: "mark")
        }
        self.experimentBlurview.layer.cornerRadius = 10
        self.experimentBlurview.clipsToBounds = true
        self.commentButton.image = #imageLiteral(resourceName: "done").withRenderingMode(.alwaysTemplate)
        self.cancelButton.image = #imageLiteral(resourceName: "cancel").withRenderingMode(.alwaysTemplate)
        
        if !self.experimento.comment.isEmpty {
            self.commentTextview.text = self.experimento.comment
        }
    }
    
    @IBAction func commentButton(_ sender: UIBarButtonItem) {
        if commentTextview.text != "" {
            
            let alertController = UIAlertController(title: "Comentar", message: "¿Estás seguro/a de que quieres comentar el experimento?", preferredStyle: .actionSheet)
            
            let ok = UIAlertAction(title: "Cancelar", style: .cancel) { (UIAlertAction) in
            }
            let cancel = UIAlertAction(title: "Comentar", style: .default) { (UIAlertAction) in
                self.experimento.comment = self.commentTextview.text
                self.saveContext()
                self.performSegue(withIdentifier: "commentUndwind", sender: nil)
                
            }
            
            alertController.addAction(cancel)
            alertController.addAction(ok)
            
            present(alertController, animated: true)
            
        }
        
    }
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        if self.commentTextview.text != "" {
            let alertController = UIAlertController(title: "Cancelar", message: "¿Estás seguro/a de que no quieres comentar el experimento?", preferredStyle: .alert)
            
            let delete = UIAlertAction(title: "Eliminar", style: .destructive) { (UIAlertAction) in
                self.experimento.comment = ""
                self.performSegue(withIdentifier: "commentUndwind", sender: nil)
            }
            let comment = UIAlertAction(title: "Comentar", style: .default) { (UIAlertAction) in
                
            }
            let cancel = UIAlertAction(title: "Cancelar", style: .cancel) { (UIAlertAction) in
                self.performSegue(withIdentifier: "commentUndwind", sender: nil)
            }
            
            
            alertController.addAction(comment)
            alertController.addAction(cancel)
            alertController.addAction(delete)
            
            present(alertController, animated: true)
        } else {
            
            let alertController = UIAlertController(title: "Cancelar", message: "¿Quieres eliminar el comentario?", preferredStyle: .alert)
            
            let delete = UIAlertAction(title: "Eliminar", style: .destructive) { (UIAlertAction) in
                self.experimento.comment = ""
                self.performSegue(withIdentifier: "commentUndwind", sender: nil)
            }
            
            let cancel = UIAlertAction(title: "Cancelar", style: .cancel) { (UIAlertAction) in
            }
            
            
            alertController.addAction(cancel)
            alertController.addAction(delete)
            
            present(alertController, animated: true)
        }
    }
    
    
    @IBAction func vaciarButton(_ sender: UIButton) {
        self.commentTextview.text = ""
    }
    
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
