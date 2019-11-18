//
//  Alerts.swift
//  Cash Desk (POS)
//
//  Created by Benji Mandel on 23/10/2019.
//  Copyright © 2019 Benji Mandel. All rights reserved.
//

import UIKit

struct Alert {
    
    private static func showBasicAlert(on vc: UIViewController, title: String?, message: String?, actionTitle: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: .cancel, handler: nil ))
        
        vc.present(alert, animated: true, completion: nil)
    }
    
    
    static func showOnlyOnePointInNumberAlert(on vc: UIViewController){
        showBasicAlert(on: vc, title: nil, message: "By money, only one period is allowed. ", actionTitle: "Ok")
    }
    
    static func showEmptyProductNameTextField(on vc: UIViewController) {
        showBasicAlert(on: vc, title: "To continue, please enter a name for the product.", message: nil, actionTitle: "Ok")
       
    }
    
    static func showInvalidNumberForPrice(on vc: UIViewController) {
        showBasicAlert(on: vc, title: "Invalide price.", message: "Please enter a valid number to continue.", actionTitle: "Ok")
    }
    
    static func showColectionViewDataAlert(on vc: UIViewController, indexRow: Int, products: String) {
        showBasicAlert(on: vc, title: "colectionViewData", message: "indexPath: \(indexRow), data: \(products)", actionTitle: "Ok")
    }
    
   
    
}
