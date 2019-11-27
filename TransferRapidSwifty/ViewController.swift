//
//  ViewController.swift
//  TransferRapidSwifty
//
//  Created by Andrei Giuglea on 27/11/2019.
//  Copyright © 2019 Andrei Giuglea. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

//
//    - între 1-100 Euro: comision 2%
//    - între 101-500 Euro: comision 3%
//    - între 501-1000 Euro: comision 4%
    
    var sum : Int = 0
    var commission : Int = 2
    
    
    var moneySelected : Int = 0
    var moneyTypes = ["€","$","RON"]
    var moneyValue = [1, 1.1, 4.78]
    
    
    @IBOutlet weak var sumSlider: UISlider!
    @IBOutlet weak var sumText: UITextField!
    @IBOutlet weak var commisionValue: UILabel!
    @IBOutlet weak var transferButton: UIButton!
    @IBOutlet weak var commisionPercent: UILabel!
    
    
    
    @IBOutlet weak var firstLabelSlider: UILabel!
    @IBOutlet weak var secondLabelSlider: UILabel!
    @IBOutlet weak var thirdLabelSlider: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sumSlider.minimumValue = 0
        sumSlider.maximumValue = 100

        transferButton.layer.cornerRadius = 25
        transferButton.isHidden = true
        commisionValue.text = "0"
        // Do any additional setup after loading the view.
    }


    
    @IBAction func changeSum(_ sender: Any) {
        
        sumSlider.value = round(sumSlider.value)
        calculateCommission()
        commisionPercent.text = "\(commission)%"
        if( round(sumSlider.value) != 0 ){
            transferButton.isHidden = false
        }else{
            transferButton.isHidden = true
        }
        
        switch moneySelected {
        case 0:
            sumText.text! = "\(Int(sumSlider.value))€"
            commisionValue.text = "\(Int(commission*Int(sumSlider.value)/100))€"
            
            if(Int(commission*Int(sumSlider.value)/100)==0){
                commisionValue.text  = "1€"
            }
//        case 1:
//            sumText.text! = "\(Int(sumSlider.value*1.1))$"
//            commisionValue.text = "\(Int(commission*Int(sumSlider.value)*1.1/100))$"
//        case 2:
//            sumText.text! = "\(Int(sumSlider.value*4.78))RON"
//            commisionValue.text = "\(Int(commission*Int(sumSlider.value)*1.1/100))RON"
        default:
            sumText.text! = "\(Int(sumSlider.value))€"
            commisionValue.text = "\(Int(commission*Int(sumSlider.value))/100)€"
        }
        
    
        
    }
    
    
    @objc func calculateCommission(){
        
        switch (round(sumSlider.value)) {
            
        case (1...100):
            commission = 2
            
        case (101...500):
            commission = 3
            
        case (501...1000):
            commission = 4
            
        default:
            commission = 2
        }
        
    }
    
    
    @IBAction func changeMoneySelected(_ sender: Any) {
        sumSlider.minimumValue = 0
        sumSlider.maximumValue = 100
        firstLabelSlider.text = "0€"
        secondLabelSlider.text = "50€"
        thirdLabelSlider.text = "100€"
        sumSlider.updateConstraints()
    }
    
    @IBAction func changeMoneySelected500(_ sender: Any) {
        sumSlider.minimumValue = 100
        sumSlider.maximumValue = 500
        firstLabelSlider.text = "100€"
        secondLabelSlider.text = "300€"
        thirdLabelSlider.text = "500€"
        sumSlider.updateConstraints()
    }
    
    @IBAction func changeMoneySelected1000(_ sender: Any) {
        sumSlider.minimumValue = 500
        sumSlider.maximumValue = 1000
        firstLabelSlider.text = "500€"
        secondLabelSlider.text = "750€"
        thirdLabelSlider.text = "1000€"
        sumSlider.updateConstraints()
    }
    
    
    
    @IBAction func transfer(_ sender: Any) {
        //TODO: save results
        //TODO suma trimisa din taste update
        if let url = URL(string: "https://www.transferrapid.com/index.html") {
            UIApplication.shared.open(url)
        }
    }
    
    
    
}

