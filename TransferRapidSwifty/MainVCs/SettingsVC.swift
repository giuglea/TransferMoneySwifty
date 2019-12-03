//
//  SettingsVC.swift
//  TransferRapidSwifty
//
//  Created by Andrei Giuglea on 29/11/2019.
//  Copyright © 2019 Andrei Giuglea. All rights reserved.
//

import Foundation
import UIKit
import Firebase


class SettingsVC: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource{
   
    var moneySelected : Int = 0
    var moneyTypes = ["€","$","RON"]
    var moneyValue = [1, 1.1, 4.78]
    
    @IBOutlet weak var moneyValueLabel: UILabel!
    
    @IBOutlet weak var currentUserLabel: UILabel!
    @IBOutlet weak var logOutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do {try currentUserLabel.text! = (Auth.auth().currentUser?.email)!}catch{print(error)}
        logOutButton.layer.cornerRadius = 25
        moneyValueLabel.text! = "\(moneyValue[moneySelected])\(moneyTypes[moneySelected])"
        
        
        getLatest { [weak self] (result) in
            
            DispatchQueue.main.async {
                switch result {
                                    
                    case .success(let response):
                                    
                                    
                        let dollar = response.rates["USD"]!
                        let dollarRound = Double(round(1000*dollar)/1000)
                        self?.moneyValue[1] = dollarRound
                        let romanianLeu = response.rates["RON"]!
                        let ronRound = Double(round(1000*romanianLeu)/1000)
                        self?.moneyValue[2] = ronRound
                        print(romanianLeu)
        //
                    case .failure: print("error")
                    }
                }
            }
        
        
        
        
        
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
       
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return moneyTypes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return moneyTypes[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        moneySelected = row
        moneyValueLabel.text! = "\(moneyValue[moneySelected])\(moneyTypes[moneySelected])"
    }
    
    
    @IBAction func goSite(_ sender: Any) {
        if let url = URL(string: "https://www.transferrapid.com/index.html") {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func logOut(_ sender: Any) {
//       UserDefaults.standard.set(false, forKey: "LogIn")
//        print("Aci 111\n")
//        print(UserDefaults.standard.bool(forKey: "LogIn"))
        do{
            
            let tried = try? Auth.auth().signOut()
            if (tried != nil){
            let dataBase = DataBase(defaulty: 1)
            saveTableFire(tableName: "")
            dataBase.dropTable(tableName: "Transfer")
            dataBase.dropTable(tableName: "LogIn")
                presentingViewController?.dismiss(animated: true, completion: nil)
            }
              }catch{
                  print(error)
              }
        
        
    }
    
    
    func  saveTableFire(tableName:String){
        ///TODO: Save Tables
    }
    
    
    
}



