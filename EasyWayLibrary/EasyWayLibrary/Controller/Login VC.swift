//
//  ViewController.swift
//  EasyWayLibrary
//
//  Created by Luke Atkinson on 04/01/2019.
//  Copyright © 2019 Luke Atkinson. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class LoginVC: UIViewController {
    
    @IBOutlet weak var EmailTextFeild: UITextField!
    @IBOutlet weak var PasswordTextFeild: UITextField!
    var ref: DatabaseReference!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        ref = Database.database().reference()
        
        
    }
    
    @IBAction func loginButton (_ sender: Any) {
        signInUser(email: EmailTextFeild.text!, password: PasswordTextFeild.text!)
    }
    
    
    func signInUser(email: String, password: String) {
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                self.performSegue(withIdentifier: "toSignUpVC", sender: nil)
            } else {
                let userID = Auth.auth().currentUser?.uid
                self.ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                    // Get user value
                    let value = snapshot.value as? NSDictionary
                    let userType = value?["type"] as? String ?? ""
                    print(userType)
                    
                    if userType == "Libarian" {
                        self.performSegue(withIdentifier: "toCurrentBooksVC", sender: nil)
                    }
                    
                    
                    
                    
                    // ...
                }) { (error) in
                    print(error.localizedDescription)
                }
                
            }
        }
    }
}

