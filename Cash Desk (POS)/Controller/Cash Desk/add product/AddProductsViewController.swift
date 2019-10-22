//
//  AddProductsViewController.swift
//  Cash Desk (POS)
//
//  Created by Benji Mandel on 07/10/2019.
//  Copyright © 2019 Benji Mandel. All rights reserved.
//

import UIKit

class AddProductsViewController: UIViewController {
    
    
    var calcButtonsNumber = 0
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var backgourndView: UIView!
    @IBOutlet weak var productNameTextField: UITextField!
    
    
    @IBOutlet var Buttons: [UIButton]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgourndView.backgroundColor = Color.POSLightBlue
        ButtonsSetUp()
        
    }
    
    // MARK: - button methods
    fileprivate func ButtonsSetUp() {
        Buttons.forEach {
            $0.layer.cornerRadius = 40
            $0.backgroundColor = Color.POSBlue
            $0.layer.borderWidth = 5
            $0.layer.borderColor = Color.POSWhite.cgColor
            
            $0.setTitleColor(Color.POSOrange, for: .normal)
        }
    }

    

    @IBAction func calcButtonsFunc(_ sender: UIButton) {

        switch sender.titleLabel?.text {
            
        case "0":
            print("0")
        case "1":
            print("1")
        case "2":
            print("2")
        case "3":
            print("3")
        case "4":
            print("4")
        case "5":
            print("5")
        case "6":
            print("6")
        case "7":
            print("7")
        case "8":
            print("8")
        case "9":
            print("9")
        case "⏎":
            print("⏎")
            self.dismiss(animated: true, completion: nil)
        case "←":
            print("←")
        default:
            print("not all calc buttons of the addProduct alert are supported,, please double check the conections")
            
            
        }
        
    }
    

}
