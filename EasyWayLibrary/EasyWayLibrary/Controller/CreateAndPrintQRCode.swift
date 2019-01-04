//
//  ViewController.swift
//  EasyWayLibrary
//
//  Created by Luke Atkinson on 03/01/2019.
//  Copyright © 2019 Luke Atkinson. All rights reserved.
//

import UIKit

class CreateAndPrintQRCodeVC: UIViewController {
    
    @IBOutlet weak var myTextField: UITextField!
    @IBOutlet weak var myImageView: UIImageView!
    
    
    @IBOutlet weak var printableView: UIView!
    
    @IBAction func button(_ sender: Any)
    {
        if let myString = myTextField.text
        {
            let data = myString.data(using: .ascii, allowLossyConversion: false)
            let filter = CIFilter(name: "CIQRCodeGenerator")
            filter?.setValue(data, forKey: "inputMessage")
            
            let img = UIImage(ciImage: (filter?.outputImage)!)
            
            myImageView.image = img
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                self.printImage(img: img)
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func printImage(img:UIImage) {
        
        let printController = UIPrintInteractionController.shared
        
        let printInfo = UIPrintInfo(dictionary:nil)
        printInfo.jobName = "Printing 's QR code"
        printInfo.outputType = .photoGrayscale
        
        printController.printInfo = printInfo
        let image = printableView.toImage()
        printController.printingItem = image
        
        printController.present(animated: true) { (_, isPrinted, error) in
            if error == nil {
                if isPrinted {
                    print("QR Code Has Been Printed :)")
                } else {
                    print("QR Code Not Printed")
                }
            }
        }
    }
}

extension UIView {
    func toImage() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
        drawHierarchy(in: self.bounds, afterScreenUpdates: false)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
