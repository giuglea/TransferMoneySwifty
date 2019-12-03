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
import AudioToolbox


class LogInVC: UIViewController{
    
    ///UserDefault skip->this step
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    
    var hasLoggedIn = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.text! = UserDefaults.standard.string(forKey: "email")!
        //passwordTextField.text! = UserDefaults.standard.string(forKey: "password")!
        logInButton.layer.cornerRadius = 25
        let dataBase = DataBase(defaulty: 1)

        dataBase.createTable(createTableString: "CREATE TABLE LogIn(Id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, Logged INT );")
        hasLoggedIn = dataBase.query1(queryStatementString: "SELECT * FROM LogIn ;")
        
        
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if(hasLoggedIn == 1){
            print(hasLoggedIn)
            passwordTextField.text! = UserDefaults.standard.string(forKey: "password")!
            let email = UserDefaults.standard.string(forKey: "email")!
            let password = UserDefaults.standard.string(forKey: "password")!
            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                if error == nil{
                    print("Relog succesful")
                    self.performSegue(withIdentifier: "goTransfer", sender: self)
                }else{
                    
                }
            }
            
            
        }
    }
    
    
    @IBAction func goRegister(_ sender: Any) {
        
        performSegue(withIdentifier: "register", sender: self)
        
    }
    
    
    @IBAction func logIn(_ sender: Any) {
              
        
              Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
                  if error == nil {
                      print("Log in succesful")
                    UserDefaults.standard.set(self.emailTextField.text!, forKey: "email")
                    UserDefaults.standard.set(self.passwordTextField.text!, forKey: "password")
                      print(user)
                    //self.hasLoggedIn = true
                     let dataBase = DataBase(defaulty: 1)
                    dataBase.insert(logIn: 1, insertStatementString: "INSERT INTO LogIn (Id, Logged) VALUES (?, ?);")
                    print("aci")
                    print(self.hasLoggedIn)
                    UserDefaults.standard.set(self.hasLoggedIn, forKey: "LogIn")
                    self.performSegue(withIdentifier: "goTransfer", sender: self)

                  }
                  else {
                      print(error)
                    AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                  }
              }
     }
    
    
}
