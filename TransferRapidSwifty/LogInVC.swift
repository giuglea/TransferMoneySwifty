//
//  LogInVC.swift
//  TransferRapidSwifty
//
//  Created by Andrei Giuglea on 29/11/2019.
//  Copyright © 2019 Andrei Giuglea. All rights reserved.
//

import Foundation
import UIKit
import Firebase


class LogInVC: UIViewController{
    
    ///UserDefault skip->this step
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    var  hasLoggedIn : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logInButton.layer.cornerRadius = 25
        hasLoggedIn = UserDefaults.standard.bool(forKey: "LoggedIn")
        if(hasLoggedIn){
            performSegue(withIdentifier: "goTransfer", sender: self)
            
        }
    }
    
    
    @IBAction func goRegister(_ sender: Any) {
        
        performSegue(withIdentifier: "register", sender: self)
        
    }
    
    
    @IBAction func logIn(_ sender: Any) {
              
        
              Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
                  if error == nil {
                      print("Log in succesful")
                      print(user)
                    self.hasLoggedIn = true
                    UserDefaults.standard.set(self.hasLoggedIn, forKey: "LoggedIn")
                    self.performSegue(withIdentifier: "goTransfer", sender: self)

                  }
                  else {
                      print(error)
                  }
              }
     }
    
    
}
