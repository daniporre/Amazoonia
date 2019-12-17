//
//  ReviewViewController.swift
//  Recetas
//
//  Created by Daniel Martinez on 17/11/2018.
//  Copyright © 2018 Daniel Martinez. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {

    @IBOutlet weak var backGroundImageView: UIImageView!
    @IBOutlet weak var greatButton: UIButton!
    @IBOutlet weak var badButton: UIButton!
    @IBOutlet weak var goodButton: UIButton!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var blurViewMarks: UIVisualEffectView!
    
    var ratingSelected : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //MARK: - Aplicar efecto blur
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        
        backGroundImageView.addSubview(blurEffectView)
        
        blurViewMarks.effect = UIBlurEffect(style: .dark)
        blurEffectView.alpha = 1
        
        backGroundImageView.addSubview(blurEffectView)
        blurViewMarks.layer.cornerRadius = 10
        blurViewMarks.clipsToBounds = true
        
        //MARK: - ANIMACION1
        
        //Creamos animacion de escalado
        let scaleGreat = CGAffineTransform(scaleX: 0.0, y: 0.0)
        let scaleGood = CGAffineTransform(scaleX: 0.0, y: 0.0)
        let scaleBad = CGAffineTransform(scaleX: 0.0, y: 0.0)
        let scaleBlurView = CGAffineTransform(scaleX: 0.0, y: 0.0)
        
        //Creamos animacion de traslacion
        let transformGreat = CGAffineTransform(translationX: 0.0, y: 500.0)
        let transformGood = CGAffineTransform(translationX: 0.0, y: 500.0)
        let transformBad = CGAffineTransform(translationX: 0.0, y: 500.0)
        let transformBlurView = CGAffineTransform(translationX: 0.0, y: 500.0)
        
        
        //Combinamos la animacion de escalado con la de translacion
        greatButton.transform = scaleGreat.concatenating(transformGreat)
        goodButton.transform = scaleGood.concatenating(transformGood)
        badButton.transform = scaleBad.concatenating(transformBad)
        blurViewMarks.transform = scaleBlurView.concatenating(transformBlurView)
        
        //Creamos animacion de traslacion del questionLabel
        questionLabel.transform = CGAffineTransform(translationX: 0.0, y: -500.0)
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        //MARK: - ANIMACION2
//        UIView.animate(withDuration: 0.5, delay: 0.0, options: [], animations: {
//
//            self.questionLabel.transform = CGAffineTransform(scaleX: 1, y: 1)
////            self.greatButton.transform = CGAffineTransform(scaleX: 1, y: 1)
////            self.goodButton.transform = CGAffineTransform(scaleX: 1, y: 1)
////            self.badButton.transform = CGAffineTransform(scaleX: 1, y: 1)
//
//
//        }, completion: nil)
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: [], animations: {
            
            self.questionLabel.transform = CGAffineTransform(scaleX: 1, y: 1)
            
        }, completion: nil)
        
        //MARK: - ANIMACION CON SALTO
        UIView.animate(withDuration: 0.5, delay: 0.7, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: [], animations: {
            
            self.badButton.transform = CGAffineTransform(scaleX: 1, y: 1)
            
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.9, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: [], animations: {
            
            self.goodButton.transform = CGAffineTransform(scaleX: 1, y: 1)
            
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 1.1, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: [], animations: {
            
            self.greatButton.transform = CGAffineTransform(scaleX: 1, y: 1)
            
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 1.5, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: [], animations: {
            
            self.blurViewMarks.transform = CGAffineTransform(scaleX: 1, y: 1)
            
        }, completion: nil)
        
    }
    
    @IBAction func ratingPress(_ sender: UIButton) {
        
        switch sender.tag {
        case 1:
            ratingSelected = "dislike"
        case 2:
            ratingSelected = "good"
        case 3:
            ratingSelected = "great"
        default:
            break
        }
        
//        performSegue(withIdentifier: "", sender: sender)
        dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func cancelButton(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Cancelar", message: "¿Está seguro/a de que no quiere calificar este experimento?", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "No calificar", style: .destructive) { (UIAlertAction) in
            self.dismiss(animated: true, completion: nil)
        }
        let cancel = UIAlertAction(title: "Calificar", style: .cancel) { (UIAlertAction) in
            
        }
        
        alertController.addAction(cancel)
        alertController.addAction(ok)
        
        present(alertController, animated: true)
    }
    
    
    


}
