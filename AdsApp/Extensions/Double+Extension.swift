//
//  Double+Extension.swift
//  AdsApp
//
//  Created by Andrii Momot on 28.04.2022.
//

import Foundation

extension Double {
    
    func convertToCurrency() -> String? {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "nn_NO")
        formatter.numberStyle = .currency
        return formatter.string(from: self as NSNumber)

    }
}
