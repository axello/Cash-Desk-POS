//
//  String Extension.swift
//  Cash Desk (POS)
//
//  Created by Benji Mandel on 23/10/2019.
//  Copyright © 2019 Benji Mandel. All rights reserved.
//

import UIKit

extension String {
     struct NumFormatter {
         static let instance = NumberFormatter()
     }

     var doubleValue: Double? {
         return NumFormatter.instance.number(from: self)?.doubleValue
     }

     var integerValue: Int? {
         return NumFormatter.instance.number(from: self)?.intValue
     }
    
    var floatValue: Float? {
        return NumFormatter.instance.number(from: self)?.floatValue
    }
}
