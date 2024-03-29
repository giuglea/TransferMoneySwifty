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
import AudioToolbox


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
                    AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
//                    let ierror = Database.database().reference().child("Users")
//                    if (ierror){}
                        
                    
                }else{
                    print("User created succesful!")
                    let alert = UIAlertController(title: "Succes!", message: "Contul a fost creat.\nVa rugam sa va logati.", preferredStyle: UIAlertController.Style.alert)
                    //alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler:nil))
                    let alertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (UIAlertAction) in
                        self.dismissVC()
                    }
                    alert.addAction(alertAction)
                    self.present(alert, animated: true,completion: nil)
                   
                }
            }
        }
        
    }
    
    @objc func dismissVC()->Void{
         presentingViewController?.dismiss(animated: true, completion: nil)
        return
    }
    
}
