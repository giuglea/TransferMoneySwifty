//
//  Database.swift
//  TransferRapidSwifty
//
//  Created by Andrei Giuglea on 28/11/2019.
//  Copyright © 2019 Andrei Giuglea. All rights reserved.
//

import Foundation
import SQLite3

class DataBase{

    var db: OpaquePointer? = nil
    var fileURL: Any? = nil
    var id: Int32 = 0;
    
    
   
   
    init(defaulty:Int) {
    
        do{
            id = Int32(UserDefaults.standard.integer(forKey: "id"))
            let manager = FileManager.default
            let documentURL = try manager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("myDB.db")
                if defaulty == 1{
                    var rc = sqlite3_open_v2(documentURL.path, &db, SQLITE_OPEN_READWRITE, nil)
                    if rc == SQLITE_CANTOPEN{
                        let bundleULR = Bundle.main.url(forResource: "myDB", withExtension: "db")!
                        try manager.copyItem(at:bundleULR,to:documentURL)
                    }
                    if rc != SQLITE_OK{
                        print("Error : \(rc)  ")
                    }
                
                }
                if defaulty == 0{
                    var rc = sqlite3_open(documentURL.path, &db)
                    if rc == SQLITE_CANTOPEN{
                        let bundleULR = Bundle.main.url(forResource: "myDB", withExtension: "db")!
                        try manager.copyItem(at:bundleULR,to:documentURL)
                    }
                    if rc != SQLITE_OK{
                        print("Error : \(rc)  ")
                    }
                           
                }
        }
        catch{
            print("Error creating DB \(error)")
        }
    }
    
  




    
func createTable(createTableString: String ){
    
    
    var createTableStatement: OpaquePointer? = nil
    
    if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil)==SQLITE_OK{
        if sqlite3_step(createTableStatement)==SQLITE_DONE{
            print("Contact Table created")
            
        }
        else {
            print("Contact Table could not be created")
        }
    }
    else{
        print("CREATE TABLE statement could not be prepared")
    }
    sqlite3_finalize(createTableStatement)
}
   
    
    
    // let insertStatementString = "INSERT INTO Transfer (Id, Sender,Data,Value,Receiver) VALUES (?, ?, ?, ?, ?);"
    func insert(sender: String, receiver: String, value: Int, insertStatementString: String)->Bool{
         var insertStatement:OpaquePointer?=nil
         id+=1
         if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil)==SQLITE_OK{
             
               let formatter = DateFormatter()
               formatter.dateFormat = "yyyy-MM-dd HH:mm"
               let myString = formatter.string(from: Date())
               let yourDate = formatter.date(from: myString)
               formatter.dateFormat = "yyyy-MM-dd HH:mm"
               let myStringafd = formatter.string(from: yourDate!)
             
            sqlite3_bind_int(insertStatement, 1, id)
            sqlite3_bind_text(insertStatement, 2, sender, -1, nil)
            sqlite3_bind_text(insertStatement, 3, myStringafd, -1, nil)
            sqlite3_bind_int(insertStatement, 4, Int32(value))
            sqlite3_bind_text(insertStatement, 5, receiver, -1, nil)
    
             if sqlite3_step(insertStatement) == SQLITE_DONE {
                 print("Successfully inserted row.")
                 UserDefaults.standard.set(id, forKey: "id")//MARK: Atentie
                sqlite3_finalize(insertStatement)
                return true
                
             } else {
                 print("Could not insert row.")
             }
             //sqlite3_reset(insertStatement)
         }
             
         else  {
             print("INSERT statement could not be prepared.")
             
         }
         sqlite3_finalize(insertStatement)
        return false
     }
    
    
    
    
    
    
    func query(queryStatementString:String)->[TransferObject] {
        
      var queryStatement: OpaquePointer? = nil
        
        var transferArray = [TransferObject]()
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
        //(Id, Sender,Data,Value,Receiver)
        while (sqlite3_step(queryStatement) == SQLITE_ROW) {
          let queryResultCol1 = sqlite3_column_text(queryStatement, 1)
          let queryResultCol2 = sqlite3_column_text(queryStatement, 2)
          let value = sqlite3_column_int(queryStatement, 3)
          let queryResultCol4 = sqlite3_column_text(queryStatement, 4)
            
          let sender = String(cString: queryResultCol1!)
          let data = String(cString: queryResultCol2!)
          let receiver = String(cString: queryResultCol4!)
            
        let converted=String(value) ///mmmm
            
        let transferObject = TransferObject(sender: sender, receiver: receiver, date: data, value: Int(value))
        transferArray.append(transferObject)
            
          
        }

      } else {
        print("SELECT statement could not be prepared")
      }
        
        
        sqlite3_finalize(queryStatement)
        return transferArray
        
       
    }
    func dropTable(tableName:String){
        let destroyStatementString = "DROP TABLE \(tableName)"
        var destroyTableStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, destroyStatementString, -1, &destroyTableStatement, nil)==SQLITE_OK{
            if sqlite3_step(destroyTableStatement)==SQLITE_DONE{
                print("\(tableName) deleted")
                
            }
            else {
                print("\(tableName) could not be deleted")
            }
        }
        else{
            print("Delete \(tableName) statement could not be prepared")
        }
        sqlite3_finalize(destroyTableStatement)
    }
    

}


