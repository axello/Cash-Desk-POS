//
//  AddProductsViewController.swift
//  Cash Desk (POS)
//
//  Created by Benji Mandel on 07/10/2019.
//  Copyright © 2019 Benji Mandel. All rights reserved.
//

import UIKit

class AddProductsViewController: UIViewController {
    
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var backgourndView: UIView!
    @IBOutlet weak var productNameTextField: UITextField!
    
    
    @IBOutlet var Buttons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        backgourndView.backgroundColor = Color.POSLightBlue
        
        Buttons.forEach {
            $0.layer.cornerRadius = 40
            $0.backgroundColor = Color.POSBlue
            $0.layer.borderWidth = 5
            $0.layer.borderColor = Color.POSWhite.cgColor
            
            $0.setTitleColor(Color.POSOrange, for: .normal)
        }
        
    }
    

    @IBAction func calcButtonsFunc(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        
    }
    

}
