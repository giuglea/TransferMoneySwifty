//
//  TransferObjectClass.swift
//  TransferRapidSwifty
//
//  Created by Andrei Giuglea on 28/11/2019.
//  Copyright © 2019 Andrei Giuglea. All rights reserved.
//

import Foundation


class TransferObject {
    var sender: String
    var receiver: String
    var date: String
    var value: Int
    
    init(sender: String,receiver: String,date: String,value: Int) {
        self.sender = sender
        self.receiver = receiver
        self.date = date
        self.value = value
    }
}
