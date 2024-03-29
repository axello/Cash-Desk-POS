//
//  AddProductAlertService.swift
//  Cash Desk (POS)
//
//  Created by Benji Mandel on 07/10/2019.
//  Copyright © 2019 Benji Mandel. All rights reserved.
//

import UIKit

class AddProductAlertService {
    
    static func alert(completion: @escaping () -> Void) -> AddProductsViewController {
        
        let storyboard = UIStoryboard(name: "AddProductsView", bundle: .main)
        
        let alertVC = storyboard.instantiateViewController(withIdentifier: "addProductsAlertVC") as! AddProductsViewController
        alertVC.completion = completion
        
        return alertVC
    }
    
}
