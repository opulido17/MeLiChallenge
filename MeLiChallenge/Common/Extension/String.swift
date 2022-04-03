//
//  String.swift
//  MeLiChallenge
//
//  Created by Orlando Pulido Marenco on 22/03/22.
//

import Foundation

extension String {
    
    func replaceHttpUrl() -> String {
        return self.replacingOccurrences(of: "http://", with: "https://") 
    }
    
    func productState() -> String {
        let text = self.lowercased()
        return text == "new" ? "Nuevo" : "Usado"
    }
    
    func toPriceNumber() -> String {
        var text = self
        text = text.replacingOccurrences(of: ",", with: ".")
        let formater = NumberFormatter()
        formater.groupingSeparator = "."
        formater.decimalSeparator = ","
        formater.usesGroupingSeparator = true
        formater.usesSignificantDigits = false
        formater.maximumFractionDigits = 0
        formater.numberStyle = .decimal
        return "$ "+formater.string(from: Double( (text != "") ? text : "0" )! as NSNumber )!
    }
}
