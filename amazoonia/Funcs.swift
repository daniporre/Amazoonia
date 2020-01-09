//
//  Funcs.swift
//  amazoonia
//
//  Created by Daniel Martinez on 12/12/2019.
//  Copyright © 2019 Amazoonia. All rights reserved.
//

import Foundation
import UIKit

func setIconTextField(foto: UIImage, textfield: UITextField, tintColor: UIColor) {
    textfield.leftViewMode = UITextField.ViewMode.always
    let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
    let image = foto.withRenderingMode(.alwaysTemplate)
    imageView.image = image
    imageView.tintColor = tintColor
    textfield.leftView = imageView
}

func setEmptyViewTextField(textfield: UITextField) {
    textfield.leftViewMode = UITextField.ViewMode.always
    textfield.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
}


public func lanzarAlertaConUnBoton(viewController: UIViewController, title: String, message: String?, buttonText: String, buttonType: UIAlertAction.Style) {
    
    //creamos alerta
    let alertController:UIAlertController = UIAlertController(title: title, message: (message == "") ? nil : message, preferredStyle: .alert)
    
    let cancelAction:UIAlertAction = UIAlertAction(title: buttonText,
                                                   style: buttonType, handler: nil)
    //Hacemos que el boton aparezca en la alerta al usuario
    alertController.addAction(cancelAction)
    
    viewController.present(alertController, animated: true, completion: nil)
    
    
}

public func setNormalNavigationBar(viewController: UIViewController){
    if #available(iOS 11.0, *) {
        viewController.navigationItem.largeTitleDisplayMode = .never
    }
}

public func setNavigationBarStyle11(viewController: UIViewController){
    if #available(iOS 11.0, *) {
        viewController.navigationController?.navigationBar.prefersLargeTitles = true
    }
}

public func addToolBarForCalcules (viewController: UIViewController,titulo: String, textField: UITextField, selectorCalc: Selector){
    let toolBar = UIToolbar()
    toolBar.sizeToFit()
    
    let flexibleEspace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
    let calcularButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: viewController, action: selectorCalc)
    let textFieldTitle = UILabel()
    textFieldTitle.text = titulo
    textFieldTitle.textColor = #colorLiteral(red: 0.4078193307, green: 0.4078193307, blue: 0.4078193307, alpha: 1)
    let infoLabel = UIBarButtonItem(customView: textFieldTitle)
    calcularButton.tintColor = #colorLiteral(red: 0.2779085934, green: 0.3907533586, blue: 0.2644636631, alpha: 1)
    
    toolBar.setItems([infoLabel, flexibleEspace, calcularButton], animated: true)
    textField.inputAccessoryView = toolBar
}


func lanzarAlertaConTiempo(viewController: UIViewController, titulo: String, mensaje: String, segundos: Double){
    
    let alertController:UIAlertController = UIAlertController(title: titulo, message: mensaje, preferredStyle: .alert)
    viewController.present(alertController, animated: true, completion: nil)
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double((Int64)(
        segundos * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {() -> Void in
        alertController.dismiss(animated: true, completion: {() -> Void in
        })
    })
    
}

func crearVistaActionSheet(alertController: UIAlertController, objeto: AnyObject, foto: UIImage) {
    let view = UIView(frame: CGRect(x: 10, y: 40, width: alertController.view.bounds.size.width - 10 * 4.0, height: 72))
    view.backgroundColor = .clear
    
    let blurEffect = UIBlurEffect(style: .dark)
    let blurEffectView = UIVisualEffectView(effect: blurEffect)
    blurEffectView.frame = view.bounds
    blurEffectView.layer.cornerRadius = 10
    blurEffectView.clipsToBounds = true
    
    let image = UIImageView(frame: CGRect(x: 8, y: 8, width: 56, height: 56))
    image.image = foto
    image.layer.cornerRadius = image.frame.height / 2
    image.clipsToBounds = true
    
    let labelTitle = UILabel(frame: CGRect(x: 76, y: 14, width: 210, height: 24))
    labelTitle.text = objeto.name
    labelTitle.textColor = #colorLiteral(red: 0.5019607843, green: 0.6509803922, blue: 0.4862745098, alpha: 1)
    labelTitle.font = UIFont(name: "AvenirNext-Bold", size: 17)
    
    let labelDate = UILabel(frame: CGRect(x: 76, y: 36, width: 190, height: 24))
    labelDate.text = objeto.user
    labelDate.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    labelDate.font = UIFont(name: "AvenirNext-UltraLightItalic", size: 17)
    
    
    view.addSubview(blurEffectView)
    view.addSubview(image)
    view.addSubview(labelDate)
    view.addSubview(labelTitle)
    
    
    
    alertController.view.addSubview(view)
}
