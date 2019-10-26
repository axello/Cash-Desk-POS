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
    @IBOutlet weak var TableView: UITableView!
    @IBOutlet weak var allProductsColectionView: UICollectionView!
    @IBOutlet var CalcButtons: [UIButton]!
    @IBOutlet weak var calcButtonsTextLabel: UILabel!
    @IBOutlet weak var discountOrCustomPrise: UISwitch!
    @IBOutlet var backgroundViews: [UIView]!
    @IBOutlet var mainBackgroundView: UIView!
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var calcButtonsNumber: String = "" {
        didSet {
            calcButtonsTextLabel.text = "\(calcButtonsNumber)"
            print("\(String(describing: calcButtonsTextLabel.text!))")
        }
    }
    
    var allProductsArray = [AllProducts]()
    
    var shoppingCart = [ShoppingCartData]()
    
    //MARK: - test data for colection and table view's
    //    var testDataForCelcetionCell = [
    //        testColectionViewCellData(productName: "potato"                          ,price: "51.46"),
    //        testColectionViewCellData(productName: "beaf"                            ,price: "51.46"),
    //        testColectionViewCellData(productName: "iPad"                            ,price: "51.46"),
    //        testColectionViewCellData(productName: "iPhone"                          ,price: "52.06"),
    //        testColectionViewCellData(productName: "bike"                            ,price: "53.06"),
    //        testColectionViewCellData(productName: "tomato"                          ,price: "55.06"),
    //        testColectionViewCellData(productName: "egg"                             ,price: "55.06"),
    //        testColectionViewCellData(productName: "icecream"                        ,price: "24.58"),
    //        testColectionViewCellData(productName: "stake"                           ,price: "75.99"),
    //        testColectionViewCellData(productName: "MacBook Pro 13\" 265GB 16GB RAM" ,price: "10.50")
    //    ]
    var testDataForTableViewCell = [
        testTableViewCellData(amount: "25", price: "51.46", name: "potato"),
        testTableViewCellData(amount: "25", price: "51.46", name: "beaf"),
        testTableViewCellData(amount: "25", price: "51.46", name: "iPad"),
        testTableViewCellData(amount: "25", price: "52.06", name: "iPhone"),
        testTableViewCellData(amount: "25", price: "53.06", name: "bike"),
        testTableViewCellData(amount: "25", price: "55.06", name: "tomato"),
        testTableViewCellData(amount: "25", price: "55.06", name: "egg"),
        testTableViewCellData(amount: "25", price: "24.58", name: "icecream"),
        testTableViewCellData(amount: "25", price: "10.50", name: "MacBook Pro 13\" 265GB 16GB RAM"),
        testTableViewCellData(amount: "25", price: "75.99", name: "stake")
        
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        TableViewSetUp()
        ColectionViewSetUp()
        backgroundViewsSetUp()
        buttonsSetUp()
        loadData()
    }
    
    //MARK: - View SetUp methods
    
    fileprivate func backgroundViewsSetUp() {
        // setting backgroundViews layout
        backgroundViews.forEach {
            $0.layer.cornerRadius    = 20
            $0.layer.backgroundColor = Color.POSWhite.cgColor
        }
        
        mainBackgroundView.backgroundColor = Color.POSLightBlue
    }
    fileprivate func buttonsSetUp() {
        // setting calc buttons layout
        CalcButtons.forEach {
            $0.layer.borderWidth     = 5
            $0.layer.cornerRadius    = 25
            $0.layer.borderColor     = Color.POSOrange.cgColor
            $0.layer.backgroundColor = Color.POSLightBlue.cgColor
        }
    }
    fileprivate func TableViewSetUp() {
        // setting table view designs
        TableView.backgroundColor     =  Color.POSLightBlue
        TableView.layer.cornerRadius  = 25
        TableView.layer.borderWidth   = 5
        TableView.layer.borderColor   = Color.POSOrange.cgColor
        TableView.contentInset.top    = 10
        TableView.separatorStyle = .none
        
        TableView.delegate   = self
        TableView.dataSource = self
        
        TableView.register(UINib(nibName: "ShoppingCartTableViewCell", bundle: nil), forCellReuseIdentifier: "TableCell")
    }
    fileprivate func ColectionViewSetUp() {
        // setting colectionView designs
        allProductsColectionView.backgroundColor    =  Color.POSLightBlue
        allProductsColectionView.layer.cornerRadius = 25
        allProductsColectionView.layer.borderWidth  = 5
        allProductsColectionView.layer.borderColor  = Color.POSOrange.cgColor
        allProductsColectionView.contentInset.top   = 10
        allProductsColectionView.contentInset.left  = 15
        allProductsColectionView.contentInset.right = 15
        
        allProductsColectionView.delegate   = self
        allProductsColectionView.dataSource = self
        
        
        allProductsColectionView.register(UINib(nibName: "allProductsColectionViewCell", bundle: nil), forCellWithReuseIdentifier: "allProductsCell")
    }
    
    fileprivate func resetCalcButtonNumberAndLabel() {
        calcButtonsNumber = ""
        calcButtonsTextLabel.text = ""
    }
    
    
    //MARK: - data methods
    
    func loadData(){
        let request: NSFetchRequest<AllProducts> = AllProducts.fetchRequest()
        do {
            allProductsArray = try context.fetch(request)
        } catch {
            print("error Loading data: \(error)")
        }
        //tableView.reloadData()
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
    @IBAction func CalcButtonsPressed(_ sender: UIButton) {

        switch sender.currentTitle {
        case "0":
            print("0")
            calcButtonsNumber.append("0")
        case "1":
            print("1")
            calcButtonsNumber.append("1")
        case "2":
            print("2")
            calcButtonsNumber.append("2")
        case "3":
            print("3")
            calcButtonsNumber.append("3")
        case "4":
            print("4")
            calcButtonsNumber.append("4")
        case "5":
            print("5")
            calcButtonsNumber.append("5")
        case "6":
            print("6")
            calcButtonsNumber.append("6")
        case "7":
            print("7")
            calcButtonsNumber.append("7")
        case "8":
            print("8")
            calcButtonsNumber.append("8")
        case "9":
            print("9")
            calcButtonsNumber.append("9")
        case "⏎":
            print("⏎")
            if discountOrCustomPrise.isOn == true {
                shoppingCart.insert(ShoppingCartData(productName: "custom product or price", productPrice: calcButtonsNumber), at: 0)
                
                resetCalcButtonNumberAndLabel()
                TableView.reloadData()
            } else {
                print("discount: \(String(describing: calcButtonsTextLabel.text ?? "problems on line 201")) %")
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
    
    @IBAction func AddProductsBarButtonPressed(_ sender: UIBarButtonItem) {
        
        let alertVC = AddProductAlertService.alert()
        
        present(alertVC, animated: true, completion: {
            //            self.loadData()
            
        })
    }
    
    // MARK: - Table View Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingCart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! ShoppingCartTableViewCell
        
//        cell.setUpCell(productName: testDataForTableViewCell[indexPath.row].name, amount: testDataForTableViewCell[indexPath.row].amount, price: "€ \(testDataForTableViewCell[indexPath.row].price)")
        
        cell.setUpCell(productName: shoppingCart[indexPath.row].productName, amount: "", price: shoppingCart[indexPath.row].productPrice)
        
        cell.selectionStyle = .default
        
        if cell.isSelected == true {
            cell.designSetUp( backgroundColor: Color.POSOrange)
        } else {
            cell.designSetUp( backgroundColor: Color.POSBlue)
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = TableView.cellForRow(at: indexPath) as? ShoppingCartTableViewCell
        cell?.designSetUp( backgroundColor: Color.POSOrange)
        
        let alert = UIAlertController(title: "Tableview row number: \(indexPath.row + 1)", message: "product name: \(testDataForTableViewCell[indexPath.row].name)", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Ok", style: .cancel) { (AlertAction) in
            self.TableView.deselectRow(at: indexPath, animated: true)
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
        
        cell.setUpCell(productName: allProductsArray[indexPath.row].productName ?? "problem by productName", price: allProductsArray[indexPath.row].productPrice ?? "problems by productPrice")
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        shoppingCart.insert(ShoppingCartData(productName: allProductsArray[indexPath.row].productName ?? "problems by didSelectItemAt 'productName'" , productPrice: allProductsArray[indexPath.row].productPrice ?? "problems by didSelectItemAt 'productPrice'"), at: 0)
        
        print("appended")
        TableView.reloadData()
    }

}
