//
//  Alerts.swift
//  Cash Desk (POS)
//
//  Created by Benji Mandel on 23/10/2019.
//  Copyright © 2019 Benji Mandel. All rights reserved.
//

import UIKit

struct Alert {
    
    private static func showBasicAlert(on vc: UIViewController, title: String?, message: String, actionTitle: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: .cancel, handler: nil ))
        
        vc.present(alert, animated: true, completion: nil)
    }
    
    
    static func showOnlyOnePointInNumberAlert(on vc: UIViewController){
        showBasicAlert(on: vc, title: nil, message: "By money, only one period is allowed. ", actionTitle: "Ok")
    }
    
}
