//
//  PermisionsViewController.swift
//  amazoonia
//
//  Created by Daniel Martinez on 11/12/2019.
//  Copyright © 2019 Amazoonia. All rights reserved.
//

import UIKit
import Photos

class PermisionsViewController: UIViewController {

    
    @IBOutlet var infoLabel: UILabel!
    @IBOutlet weak var askForPermisions: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpAskForPermisionsButton()
    }
    
    @IBAction func askForPermisions(_ sender: UIButton) {
        self.askForPhotosPermissions()
    }
    
    func setUpAskForPermisionsButton() {
        self.askForPermisions.layer.cornerRadius = 10
    }
    
    
    func askForPhotosPermissions() {
        PHPhotoLibrary.requestAuthorization { [unowned self] (authStatus) in
            DispatchQueue.main.async {
                if authStatus == .authorized {
                    self.askForCameraPermisions()
                } else {
                    self.infoLabel.text = "Nos has denegado el permiso de fotos. Por favor, actívalo en los Ajustes de tu dispositvo para continuar.\nAjustes / Amazoonia / Fotos"
                }
            }
        }
    }
    
    func askForCameraPermisions() {
        AVCaptureDevice.requestAccess(for: AVMediaType.video) { response in
            if response {
                self.authorizationCompleted()
            } else {
                print("Acceso a cámara denegado")
                self.infoLabel.text = "Nos has denegado el permiso de cámara. Por favor, actívalo en los Ajustes de tu dispositvo para continuar.\nAjustes / Amazoonia / Cámara"
            }
        }
    }
    
    
    
    func authorizationCompleted() {
        dismiss(animated: true)
    }
    
}
