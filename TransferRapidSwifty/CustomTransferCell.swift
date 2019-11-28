//
//  CustomTransferCell.swift
//  TransferRapidSwifty
//
//  Created by Andrei Giuglea on 27/11/2019.
//  Copyright © 2019 Andrei Giuglea. All rights reserved.
//

import Foundation
import UIKit

class CustomTransferCell: UITableViewCell {
    
    
    
    @IBOutlet weak var transferImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var sumLabel: UILabel!
    @IBOutlet weak var receiverLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}



func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }

    if ((cString.count) != 6) {
        return UIColor.gray
    }

    var rgbValue:UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)

    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}
