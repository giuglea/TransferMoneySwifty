//
//  HelpfulFunc.swift
//  TransferRapidSwifty
//
//  Created by Andrei Giuglea on 01/12/2019.
//  Copyright © 2019 Andrei Giuglea. All rights reserved.
//

import Foundation
import UIKit





extension UITextField{
    
    @IBInspectable var doneAccessory: Bool{
        get{
            return self.doneAccessory
        }
        set (hasDone) {
            if hasDone{
                addDoneButtonOnKeyboard()
            }
        }
    }
    
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction()
    {
        self.resignFirstResponder()
    }
}


extension UIView {
    func fadeTransition(_ duration:CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.fade
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.fade.rawValue)
    }
}



  func getLatest(completion: @escaping (Result) -> Void) {
       let urlString = "http://data.fixer.io/api/latest?access_key=78393061a42b3ac215ec6f2cada75d3a"
    guard let url = URL(string: urlString) else { completion(.failure); return  }
    
    URLSession.shared.dataTask(with: url) { (data, response, error) in
         
         guard error == nil, let urlResponse = response as? HTTPURLResponse, urlResponse.statusCode == 200, let data = data else { completion(.failure); return }
         
         do {
             
             let exchangeRates = try JSONDecoder().decode(rates.self, from: data)
             completion(.success(exchangeRates))
         }
         catch { completion(.failure) }
         
         }.resume()
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
