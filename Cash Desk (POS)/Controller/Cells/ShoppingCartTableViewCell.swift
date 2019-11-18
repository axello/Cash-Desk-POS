//
//  ShoppingCartTableViewCell.swift
//  Cash Desk (POS)
//
//  Created by Benji Mandel on 22/09/2019.
//  Copyright © 2019 Benji Mandel. All rights reserved.
//

import UIKit

class ShoppingCartTableViewCell: UITableViewCell {

    
    @IBOutlet weak var productNameLabel: UILabel!
    
    @IBOutlet weak var amountLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var BackgroundViews: UIView!
    
    @IBOutlet weak var spacingView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    func setUpCell(productName: String, amount: String? = "", price: String) {
        // cell text setup
        productNameLabel.text = productName
        amountLabel.text      = amount
        priceLabel.text       = "€\(String(describing: price))"
        
        BackgroundViews.layer.cornerRadius = 20
        
        designSetUp()
        
    }
    
    func designSetUp(textColor: UIColor? = Color.POSWhite, spacingColor: UIColor? = Color.POSLightBlue, backgroundColor: UIColor? = Color.POSBlue) {
        productNameLabel.textColor      = textColor
        amountLabel.textColor           = textColor
        priceLabel.textColor            = textColor
        BackgroundViews.backgroundColor = backgroundColor
        spacingView.backgroundColor     = spacingColor
    }

    

}
