//
//  TransferHistory.swift
//  TransferRapidSwifty
//
//  Created by Andrei Giuglea on 27/11/2019.
//  Copyright © 2019 Andrei Giuglea. All rights reserved.
//

import Foundation
import UIKit
//import RealmSwift



class TransferHistoryVC: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    
    var transferArray = [TransferObject]()
    var transferObject  = [TransferObject]()
    
    var refreshControl = UIRefreshControl()
   
    @IBOutlet weak var tableViewN: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getUserHistory()
  
//        refreshControl.addTarget(self, action: "refresh:", for: UIControl.Event.valueChanged)
//        self.refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
//
//       tableViewN.addSubview(refreshControl)
        
       
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
    
    
    
    @IBAction func updateTable(_ sender: Any) {
        var dataBase = checkCreateDatabase()

        transferArray = dataBase.query(queryStatementString: "SELECT * FROM Transfer;")
        tableViewN.reloadData()
        
    }
    
    @objc func refresh(sender:AnyObject)
     {
         // Updating your data here...
        var dataBase = checkCreateDatabase()

        transferArray = dataBase.query(queryStatementString: "SELECT * FROM Transfer;")

         self.tableViewN.reloadData()
         self.refreshControl.endRefreshing()
     }
    
    func getUserHistory(){
        ///fireBase
    }
    
    
}




