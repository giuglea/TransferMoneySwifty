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
        currentUserLabel.text! = (Auth.auth().currentUser?.email)!
        logOutButton.layer.cornerRadius = 25
        moneyValueLabel.text! = "\(moneyValue[moneySelected])\(moneyTypes[moneySelected])"
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
       
        do{
            try Auth.auth().signOut()
            let dataBase = DataBase(defaulty: 1)
            dataBase.dropTable(tableName: "Transfer")
                presentingViewController?.dismiss(animated: true, completion: nil)
              }catch{
                  print(error)
              }
        
    }
    
    
    
}
