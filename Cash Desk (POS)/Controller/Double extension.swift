//
//  Double extension.swift
//  Cash Desk (POS)
//
//  Created by Benji Mandel on 27/10/2019.
//  Copyright © 2019 Benji Mandel. All rights reserved.
//

import Foundation

extension Double {
    
    /// easily round doubles with this extension method
    /// - Parameter number: the double you want to round
    /// - Parameter roundWith: the number behind the decimal.
    static func roundDouble( numberToRound: Double, roundNumberWith: Int) -> Double {
        
        let roundedNumberString = String(format:"%.\(roundNumberWith)f", numberToRound)
        let roundedNumber = Double(roundedNumberString) ?? 0
        return roundedNumber
        
    }
    
}
