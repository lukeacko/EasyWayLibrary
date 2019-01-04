//
//  SignUpVC.swift
//  QR Test 0.1
//
//  Created by Luke Atkinson on 03/01/2019.
//  Copyright © 2019 Luke Atkinson. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class SignUpVC: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    var ref: DatabaseReference!
    var TypeOfUser:Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        ref = Database.database().reference()
        
    }
    
    @IBAction func SignUp(_ sender: Any) {
        
        Auth.auth().createUser(withEmail: email.text!, password: password.text!) { (user, error) in
            self.newUser()
            
        }
        
    }
    
    
    
    @IBAction func Libarian (_ sender: Any) {
        TypeOfUser = true
        
    }
    
    @IBAction func Reader (_ sender: Any) {
        TypeOfUser = false
    }
    
    func newUser(){
        if email.text != nil {
            
            self.ref.child("users").child((Auth.auth().currentUser?.uid)!).setValue(["username":email.text!])
            
            if TypeOfUser == true {
                self.ref.child("users").child((Auth.auth().currentUser?.uid)!).setValue(["type": "Libarian"])
                self.performSegue(withIdentifier: "toCurrentBooksVC", sender: nil)
            } else {
                self.ref.child("users").child((Auth.auth().currentUser?.uid)!).setValue(["type": "User"])
                self.performSegue(withIdentifier: "toUserHome", sender: nil)
            }
            
            
        }
    }
    
    
    
}






