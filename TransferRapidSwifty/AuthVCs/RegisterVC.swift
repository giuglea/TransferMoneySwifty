//
//  RegisterVC.swift
//  TransferRapidSwifty
//
//  Created by Andrei Giuglea on 29/11/2019.
//  Copyright © 2019 Andrei Giuglea. All rights reserved.
//

import Foundation
import UIKit
import Firebase


class RegisterVC: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var checkPasswordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerButton.layer.cornerRadius = 25
    }
    
    
    @IBAction func registerUser(_ sender: Any) {
        
        if(passwordTextField.text! != checkPasswordTextField.text!){
            let alert = UIAlertController(title: "Atentie!", message: "Parolele nu coincid", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            present(alert, animated: true, completion: nil)
        }else{
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
                if (error  != nil ){
                    print(error!)
                }else{
                    print("User created succesful!")
                }
            }
        }
        
    }
    
}
