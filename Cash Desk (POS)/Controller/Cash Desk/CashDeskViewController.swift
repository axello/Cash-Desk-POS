//
//  FirstViewController.swift
//  Cash Desk (POS)
//
//  Created by Benji Mandel on 15/09/2019.
//  Copyright © 2019 Benji Mandel. All rights reserved.
//

import UIKit
import CoreData

class CashDeskViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    //MARK: - outlets
    
    @IBOutlet weak var shoppingCartTableView: UITableView!
    @IBOutlet weak var allProductsColectionView: UICollectionView!
    @IBOutlet var calcButtons: [UIButton]!
    @IBOutlet weak var calcButtonsTextLabel: UILabel!
    @IBOutlet weak var discountOrCustomPrise: UISwitch!
    @IBOutlet var backgroundViews: [UIView]!
    @IBOutlet var mainBackgroundView: UIView!
    @IBOutlet var totalPriceToPayLabel: UILabel!
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var calcButtonsNumber: String = "" {
        didSet {
            calcButtonsTextLabel.text = "\(calcButtonsNumber)"
            print("\(String(describing: calcButtonsTextLabel.text!))")
        }
    }
    
    var totalPriceToPay: Double = 0 {
        didSet {
            
            totalPriceToPayLabel.text = "€\(totalPriceToPay)"
        }
    }

    var allProductsArray = [AllProducts]()
    
    
    var timer: Timer?
    
    var shoppingCart = [ShoppingCartData]() 

    override func viewDidLoad() {
        super.viewDidLoad()
        
        totalPriceToPayLabel?.textColor = Color.POSBlue
        totalPriceToPayLabel?.text = "€0.0"
         
//        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(loadData), userInfo: nil, repeats: true)
        
        tableViewSetUp()
        colectionViewSetUp()
        backgroundViewsSetUp()
        buttonsSetUp()
        loadData()
    }
    
    //MARK: - View SetUp methods
    
    fileprivate func backgroundViewsSetUp() {
        // setting backgroundViews layout
        backgroundViews?.forEach {
            $0.layer.cornerRadius    = 20
            $0.layer.backgroundColor = Color.POSWhite.cgColor
        }
        
        mainBackgroundView?.backgroundColor = Color.POSLightBlue
    }
    
    fileprivate func buttonsSetUp() {
        // setting calc buttons layout
        calcButtons?.forEach {
            $0.layer.borderWidth     = 5
            $0.layer.cornerRadius    = 25
            $0.layer.borderColor     = Color.POSOrange.cgColor
            $0.layer.backgroundColor = Color.POSLightBlue.cgColor
        }
    }
    
    fileprivate func tableViewSetUp() {
        // setting table view designs
        shoppingCartTableView?.backgroundColor     =  Color.POSLightBlue
        shoppingCartTableView?.layer.cornerRadius  = 25
        shoppingCartTableView?.layer.borderWidth   = 5
        shoppingCartTableView?.layer.borderColor   = Color.POSOrange.cgColor
        shoppingCartTableView?.contentInset.top    = 10
        shoppingCartTableView?.separatorStyle = .none
        
        shoppingCartTableView?.delegate   = self
        shoppingCartTableView?.dataSource = self
        
        shoppingCartTableView?.register(UINib(nibName: "ShoppingCartTableViewCell", bundle: nil), forCellReuseIdentifier: "TableCell")
    }
    
    // TODO: svp functions beginnen ook met een kleine letter!
    fileprivate func colectionViewSetUp() {
        // setting colectionView designs
        allProductsColectionView?.backgroundColor    =  Color.POSLightBlue
        allProductsColectionView?.layer.cornerRadius = 25
        allProductsColectionView?.layer.borderWidth  = 5
        allProductsColectionView?.layer.borderColor  = Color.POSOrange.cgColor
        allProductsColectionView?.contentInset.top   = 10
        allProductsColectionView?.contentInset.left  = 15
        allProductsColectionView?.contentInset.right = 15
        
        allProductsColectionView?.delegate   = self
        allProductsColectionView?.dataSource = self
        
        allProductsColectionView?.register(UINib(nibName: "allProductsColectionViewCell", bundle: nil), forCellWithReuseIdentifier: "allProductsCell")
    }
    
    fileprivate func resetCalcButtonNumberAndLabel() {
        calcButtonsNumber = ""
        calcButtonsTextLabel.text = ""
    }
    
    //MARK: - data methods
    
   @objc func loadData(){
        let request: NSFetchRequest<AllProducts> = AllProducts.fetchRequest()
        
        do {
            allProductsArray = try context.fetch(request)
        } catch {
            print("error Loading data: \(error)")
        }
        allProductsColectionView?.reloadData()
        
        print("tableView Reloaded")
    }
    
    func save() {
        do {
            try context.save()
        }
        catch {
            print("error saving data: \(error)")
        }
        loadData()
    }
    
    // MARK: - button pressed methods
    @IBAction func calcButtonsPressed(_ sender: UIButton) {

        if let title = sender.currentTitle, let number = Int(title) {
            // user tapped a number key
            let numStr = String(number)
            print(numStr)
            calcButtonsNumber.append(numStr)
        } else {
            switch sender.currentTitle {
            case "⏎":
                print("⏎")
                if discountOrCustomPrise.isOn == true {
                    shoppingCart.insert(ShoppingCartData(productName: "custom product or price", productPrice: calcButtonsNumber), at: 0)
                    
                    resetCalcButtonNumberAndLabel()
                    shoppingCartTableView.reloadData()
                } else {
                    print("discount: \(String(describing: calcButtonsTextLabel.text ?? "problems on line \(#line) on file \(#file)")) %")
                    
                    resetCalcButtonNumberAndLabel()
                }
            case "←":
                print("←")
                calcButtonsNumber = String(calcButtonsNumber.dropLast())
                
            case .none:
                print("problem with the app, please contact the developer")
            case .some(_):
                print(".some")
            }
        }
    }
    
    @IBAction func addProductsBarButtonPressed(_ sender: UIBarButtonItem) {
      
        let alertVC = AddProductAlertService.alert {
            self.loadData()
        }
                
        present(alertVC, animated: true, completion: {
//            self.loadData()
//            self.timer?.invalidate()
        })
        
    }
    
    // MARK: - Table View Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingCart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! ShoppingCartTableViewCell
        
        cell.setUpCell(productName: shoppingCart[indexPath.row].productName, amount: "\(shoppingCart[indexPath.row].quantity)", price: shoppingCart[indexPath.row].productPrice)
        
        cell.selectionStyle = .default
        
        if cell.isSelected == true {
            cell.designSetUp( backgroundColor: Color.POSOrange)
        } else {
            cell.designSetUp( backgroundColor: Color.POSBlue)
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = shoppingCartTableView.cellForRow(at: indexPath) as? ShoppingCartTableViewCell
        cell?.designSetUp( backgroundColor: Color.POSOrange)
        
        let alert = UIAlertController(title: "Tableview row number: \(indexPath.row + 1)", message: "product name: \(shoppingCart[indexPath.row].productName)", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Ok", style: .cancel) { (AlertAction) in
            self.shoppingCartTableView.deselectRow(at: indexPath, animated: true)
            cell?.designSetUp(backgroundColor: Color.POSBlue)
        }
        
        alert.addAction(action)
        present(alert, animated: true)
        
        
        print("cell selected at\(indexPath.row)")
    }

    
    // MARK: - Colection View Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allProductsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "allProductsCell", for: indexPath) as! AllProductsCollectionViewCell
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressColectionView))

        
        cell.addGestureRecognizer(longPressGesture)
        
        cell.setUpCell(productName: allProductsArray[indexPath.row].productName ?? "problem by productName", price: allProductsArray[indexPath.row].productPrice ?? "problems by productPrice")
        
        
        return cell
        
    }
    
    @objc private func longPressColectionView(recognizer: UILongPressGestureRecognizer) {
        guard let indexPath = allProductsColectionView.indexPathForItem(at: recognizer.location(in: allProductsColectionView)) else { return }
      print(indexPath)
        print("long gesture detected")
        
        let alert = UIAlertController(title: "Are you sure you want to delete this product?", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (DeleteFunctionality) in
            self.context.delete(self.allProductsArray[indexPath.item])
            self.allProductsArray.remove(at: indexPath.item)
            self.save()
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let index = shoppingCart.firstIndex(where: { $0.productName == allProductsArray[indexPath.row].productName && $0.productPrice == allProductsArray[indexPath.row].productPrice }) {
          shoppingCart[index].quantity += 1
        } else {
          let data = ShoppingCartData(productName: allProductsArray[indexPath.row].productName ?? "problems by didSelectItemAt 'productName'" , productPrice: allProductsArray[indexPath.row].productPrice ?? "problems by didSelectItemAt 'productPrice'", quantity: 1)
          shoppingCart.insert(data, at: 0)
        }
//        print("out of for in and if else blocks")
        print("appended")
        shoppingCartTableView.reloadData()
        var totalPrice: Double = 0
        
//        for number in 0 ... shoppingCart.count {
//
//            totalPrice += Double(shoppingCart[number].productPrice) ?? 1
//            totalPrice = Double.roundDouble(numberToRound: totalPrice, roundNumberWith: 2)
//        }
        
    }

}


//fileprivate func updateTotalPriceToPay() {
//    if shoppingCart.isEmpty == false {
//        var totalPrice: Double = 0
//        for placeNumber in 0...shoppingCart.count {
//            let doubleNumber = Double(shoppingCart[placeNumber].productPrice) ?? 0.0
//            let roundedDoubleNumber = Double.roundDouble(numberToRound: doubleNumber, roundNumberWith: 2)
//
//            totalPrice += roundedDoubleNumber
//        }
//
//        if totalPrice != totalPriceToPay {
//            totalPriceToPay += totalPrice
//        }
//    }
//}





//if !shoppingCart.isEmpty {
//    for productNr in 0 ..< allProductsArray.count {
//        print("productNr: \(productNr)")
//        if  allProductsArray[productNr].productName == shoppingCart[productNr].productName{
//            print("does containd")
//            shoppingCart[productNr].quantity += 1
//            TableView.reloadData()
//            break
//        } else {
//            print("doesntContain")
//            shoppingCart.insert(ShoppingCartData(productName: allProductsArray[indexPath.row].productName ?? "problems by didSelectItemAt 'productName'" , productPrice: allProductsArray[indexPath.row].productPrice ?? "problems by didSelectItemAt 'productPrice'", quantity: 1), at: 0)
//            TableView.reloadData()
//        }
//
//
//    }
//
//} else if shoppingCart.isEmpty {
//    shoppingCart.insert(ShoppingCartData(productName: allProductsArray[indexPath.row].productName ?? "problems by didSelectItemAt 'productName'" , productPrice: allProductsArray[indexPath.row].productPrice ?? "problems by didSelectItemAt 'productPrice'", quantity: 1), at: 0)
//    TableView.reloadData()
//}
