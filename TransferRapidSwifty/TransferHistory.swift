//
//  TransferHistory.swift
//  TransferRapidSwifty
//
//  Created by Andrei Giuglea on 27/11/2019.
//  Copyright © 2019 Andrei Giuglea. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift



class TransferHistoryController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    
    var transferArray = [TransferObject]()
    var transferObject  = [TransferObject]()
   
    @IBOutlet weak var tableViewN: UITableView!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
       var dataBase = checkCreateDatabase()

        transferArray = dataBase.query(queryStatementString: "SELECT * FROM Transfer;")
        tableViewN.reloadData()
        
    }
    
  
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transferArray.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "transferCell", for: indexPath) as! CustomTransferCell
       
        cell.dateLabel.text = transferArray[transferArray.count - indexPath.row - 1].date
        cell.sumLabel.text = "\(transferArray[transferArray.count - indexPath.row - 1].value)€"
        cell.receiverLabel.text = transferArray[transferArray.count -  indexPath.row - 1].receiver
       
        
        return cell
    }
    
    
    
    
    
    @IBAction func deleteHistory(_ sender: Any) {
        var dataBase = DataBase(defaulty: 1)
        dataBase.dropTable(tableName: "Transfer")
        transferArray = [TransferObject]()
        tableViewN.reloadData()
        
        
    }
    
    
    
    @IBAction func goToSite(_ sender: Any) {
        
        if let url = URL(string: "https://www.transferrapid.com/index.html") {
                  UIApplication.shared.open(url)
              }
        
    }
    
    
}


func checkCreateDatabase()->DataBase{
    var first = UserDefaults.standard.bool(forKey: "first")
             
    if(first == false) {
        var dataBase = DataBase(defaulty: 0) //Transfer (Id, Sender,Data,Value,Receiver)
        first = true
        UserDefaults.standard.set(first, forKey: "first")
    }
             
    var dataBase = DataBase(defaulty: 1)
      
      return dataBase
  }

