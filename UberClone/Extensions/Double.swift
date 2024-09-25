//
//  Double.swift
//  UberClone
//
//  Created by A'zamjon Abdumuxtorov on 25/09/24.
//

import Foundation

extension Double{
    
    private var currentFormatter:NumberFormatter{
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "$" 
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    func toCurrency() -> String{
        return currentFormatter.string(for: self) ?? ""
    }
}
