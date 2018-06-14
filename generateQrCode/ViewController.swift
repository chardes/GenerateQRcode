//
//  ViewController.swift
//  generateQrCode
//
//  Created by Patrick CHARDES on 13/06/2018.
//  Copyright © 2018 Patrick CHARDES. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var ui_dataField: UITextField!
    @IBOutlet weak var ui_codeSelector: UISegmentedControl!
    @IBOutlet weak var ui_displayCodeView: UIImageView!
    
    var filter:CIFilter!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
            
            
            ui_displayCodeView.image = image
        }
    }

}

