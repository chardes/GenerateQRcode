//
//  ViewController.swift
//  generateQrCode
//
//  Created by Patrick CHARDES on 13/06/2018.
//  Copyright © 2018 Patrick CHARDES. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var ui_dataField: UITextField!
    @IBOutlet weak var ui_codeSelector: UISegmentedControl!
    @IBOutlet weak var ui_displayCodeView: UIImageView!
    
    private var brightness : CGFloat = UIScreen.main.brightness
    
    var filter:CIFilter!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        ui_dataField.delegate = self
    }
    
    @IBAction func ui_generatePressed(_ sender: UIButton) {
        if let text = ui_dataField.text {
            let data = text.data(using: .ascii, allowLossyConversion: false)
            
            if ui_codeSelector.selectedSegmentIndex == 0 {
                // Barcode
                filter = CIFilter(name: "CICode128BarcodeGenerator")
            } else {
                // QRCode
                filter = CIFilter(name: "CIQRCodeGenerator")
            }
            filter.setValue(data, forKey: "inputMessage")
            
            // 1er version qui fonctionne
            // let image = UIImage(ciImage: filter.outputImage!)
            
            // 2eme version pour une image plus nette
            let transform = CGAffineTransform(scaleX: 10, y: 10)
            let image = UIImage(ciImage: filter.outputImage!.transformed(by: transform))
            
            // On mets la luminosité au max
            UIScreen.main.brightness = CGFloat(1.0)
            
            ui_displayCodeView.image = image
            // Je supprime le clavier
            self.view.endEditing(true)
        }
    }

    

    //This is for the keyboard to GO AWAYY !! when user clicks anywhere on the view
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //This is for the keyboard to GO AWAYY !! when user clicks "Return" key  on the keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        defaultBrightness()
    }
    
    // On remet la luminosité par defaut
    private func defaultBrightness() {
        UIScreen.main.brightness = brightness
    }

}

