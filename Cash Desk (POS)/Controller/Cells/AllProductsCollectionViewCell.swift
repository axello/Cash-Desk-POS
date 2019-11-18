//
//  AllProductsCollectionViewCell.swift
//  Cash Desk (POS)
//
//  Created by Benji Mandel on 18/09/2019.
//  Copyright © 2019 Benji Mandel. All rights reserved.
//

import UIKit

class AllProductsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var productNameLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var BackgroundViews: UIView!
    
    @IBOutlet weak var shadowView: UIView!
    
    let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(didLongPress))
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        self.addGestureRecognizer(longPressGesture)
        
    }
    
    func setUpCell(productName: String, price: String) {
        productNameLabel.text = productName
        priceLabel.text       = price
        
        self.layer.cornerRadius    = 40
        productNameLabel.textColor = Color.POSWhite
        priceLabel.textColor       = Color.POSWhite
        
        BackgroundViews.backgroundColor = Color.POSBlue
        
        // setting the shaddow
        shadowView.layer.shadowColor   = UIColor.black.cgColor
        shadowView.layer.shadowOpacity = 1
        shadowView.layer.shadowOffset  = .zero
        shadowView.layer.shadowRadius  = 10
        shadowView.layer.shadowPath    = UIBezierPath(rect: shadowView.bounds).cgPath
        
        
    }
    
    
    @objc func didLongPress() {
        
        print("lomg gesture detected")
        Alert.showColectionViewDataAlert(on: CashDeskViewController(), indexRow: 1, products: "2345678")
        
    }
}
