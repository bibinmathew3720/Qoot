//
//  HomeVC.swift
//  DemoPgm
//
//  Created by Vishnu KM on 03/08/18.
//  Copyright © 2018 Vishnu KM. All rights reserved.
//

let ARR1 = ["1","2","3","4"]
let ARR2 = ["2","3","4","5"]
let ARR3 = ["3","4","5","6"]
let ARR4 = ["4","5","6","7"]

import UIKit


class HomeVC: BaseViewController {
    
    @IBOutlet var searchButton: UIButton!
    @IBOutlet var tableViewContainerView: UIView!
    @IBOutlet var offersLabel: UILabel!
    @IBOutlet var readyNowLabel: UILabel!
    
    @IBOutlet var toolBar: UIToolbar!
    @IBOutlet var pickerTextField: UITextField!
    @IBOutlet var pickerView: UIPickerView!
    @IBOutlet var offersCollectionView: UICollectionView!
    @IBOutlet var readyNowCollectionView: UICollectionView!
    @IBOutlet var homeTableView: UITableView!
    var selectedTableRowIndex: Int = -1
    var selectedCity: String = "SelectCity".localiz()
    var selectedMeal: String = "MealType".localiz()
    var selectedCuisine: String = "Cuisine".localiz()
    var selectedKitchen: String = "KitchenName".localiz()
    
    var imagesArray = [#imageLiteral(resourceName: "city"),#imageLiteral(resourceName: "mealtype"),#imageLiteral(resourceName: "cuisine"),#imageLiteral(resourceName: "kitchenName")]
   var mealModel = [MealTypes]()
    var cuisinesModel = [ViewCuisines]()
     var kitchenModel = [ViewKitchens]()
    
    override func initView() {
        super.initView()
        initialisation()
        localisation()
        addingLeftBarButton()
        addCartIconOnly()
        callingMealTypeApi()
        callingViewCuisinesApi()
        self.leftButton?.setImage(UIImage(named: "hamburger"), for: UIControlState.normal)
    }
    
    override func leftNavButtonAction() {
        if LanguageManger.shared.currentLanguage == .en {
            self.slideMenuController()?.openLeft()
        }
        else{
            self.slideMenuController()?.openRight()
        }
    }
    
    func initialisation(){
        self.title = "Qoot".localiz()
        pickerTextField.inputView = pickerView
        pickerTextField.inputAccessoryView = toolBar
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        tableViewContainerView.layer.borderWidth = 1.0
        tableViewContainerView.layer.borderColor = UIColor.black.cgColor
        tableInitialisation()
        setUpCollectionView()
    }
    
    func localisation(){
        self.searchButton.setTitle("SEARCH".localiz(), for: UIControlState.normal)
        self.offersLabel.text = "OFFERS".localiz()
        self.readyNowLabel.text = "READYNOW".localiz()
    }

    func tableInitialisation(){
        homeTableView.register(UINib(nibName: "HomeTableCell", bundle: nil), forCellReuseIdentifier: "Cell")
         readyNowCollectionView.register(UINib(nibName: "HomeCollectionCell", bundle: nil), forCellWithReuseIdentifier:"homeCollectionCell" )
         offersCollectionView.register(UINib(nibName: "HomeCollectionCell", bundle: nil), forCellWithReuseIdentifier:"homeCollectionCell" )
    }
    
    func setUpCollectionView(){
        if let readylayout = readyNowCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let itemWidth = (UIScreen.main.bounds.width - 45)/3
            readylayout.itemSize = CGSize(width: itemWidth, height: 130)
        }
        if let offerslayout = offersCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let itemWidth = (UIScreen.main.bounds.width - 45)/3
            offerslayout.itemSize = CGSize(width: itemWidth, height: 130)
        }
    }
   
    @IBAction func searchButtonAction(_ sender: Any) {
        let searchResultsVC = SearchResultsVC.init(nibName: "SearchResultsVC", bundle: nil)
        self.navigationController?.pushViewController(searchResultsVC, animated: true)
    }
    
    //MARK: MealType Api
    
    func  callingMealTypeApi(){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        UserManager().callingViewMealTypeApi(with: "", success: {
            (model) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if let model = model as? QootMealTypeResponseModel{
               self.mealModel = model.mealTypes
            }
            
        }) { (ErrorType) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if(ErrorType == .noNetwork){
                CCUtility.showDefaultAlertwith(_title: Constant.AppName, _message: Constant.ErrorMessages.noNetworkMessage, parentController: self)
            }
            else{
                CCUtility.showDefaultAlertwith(_title: Constant.AppName, _message: Constant.ErrorMessages.serverErrorMessamge, parentController: self)
            }
            
            print(ErrorType)
        }
    }
    //MARK: ViewCuisines Api
    
    func  callingViewCuisinesApi(){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        UserManager().callingViewCuisinesApi(with: getCuisinesRequestBody(), success: {
            (model) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if let model = model as? ViewCuisinesResponseModel{
                self.cuisinesModel = model.viewCuisines
            }
            
        }) { (ErrorType) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if(ErrorType == .noNetwork){
                CCUtility.showDefaultAlertwith(_title: Constant.AppName, _message: Constant.ErrorMessages.noNetworkMessage, parentController: self)
            }
            else{
                CCUtility.showDefaultAlertwith(_title: Constant.AppName, _message: Constant.ErrorMessages.serverErrorMessamge, parentController: self)
            }
            
            print(ErrorType)
        }
    }
    
    func getCuisinesRequestBody()->String{
        var dict:[String:String] = [String:String]()
        dict.updateValue("22", forKey: "CategoryId")
        return CCUtility.getJSONfrom(dictionary: dict)
    }
    
    //MARK: Kitchens Api
    
    func  callingKitchensApi(){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        UserManager().callingKitchensApi(with: "", success: {
            (model) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if let model = model as? KitchensResponseModel{
                self.kitchenModel = model.viewKitchens
            }
            
        }) { (ErrorType) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if(ErrorType == .noNetwork){
                CCUtility.showDefaultAlertwith(_title: Constant.AppName, _message: Constant.ErrorMessages.noNetworkMessage, parentController: self)
            }
            else{
                CCUtility.showDefaultAlertwith(_title: Constant.AppName, _message: Constant.ErrorMessages.serverErrorMessamge, parentController: self)
            }
            
            print(ErrorType)
        }
    }
    
//    func getLoginRequestBody()->String{
//        var dataString:String = ""
//        if let phone = self.mobileTextField.text {
//            let phoneString:String = "username=\(phone.urlEncode())"
//            dataString = dataString + phoneString + "&"
//        }
//        if let password = self.passwordTextField.text {
//            let passwordString:String = "password=\(password.urlEncode())"
//            dataString = dataString + passwordString
//        }
//        //dataString = "username=0550154967&password=123456"
//        return dataString
//    }
    
    @IBAction func toolBarDoneAction(_ sender: Any) {
//        if selectedCity == TYPE_FIELDS[0] || selectedMeal == TYPE_FIELDS[1] || selectedCuisine == TYPE_FIELDS[2] || selectedKitchen == TYPE_FIELDS[3]{
            switch selectedTableRowIndex {
            case 0:
                selectedCity = ARR1[0]
            case 1:
                selectedMeal = self.mealModel[0].catName
            case 2:
                selectedCuisine = self.cuisinesModel[0].subCatName
            case 3:
                selectedKitchen = self.kitchenModel[0].KitchenName
            default:
                print("default")
            }
        //}
        homeTableView.reloadData()
        view.endEditing(true)
    }
    
    @IBAction func toolBarCancelAction(_ sender: Any) {
        view.endEditing(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension HomeVC : UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 4
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! HomeTableCell
        switch indexPath.row {
        case 0:
            cell.nameLabel.text = selectedCity
        case 1:
            cell.nameLabel.text = selectedMeal
        case 2:
            cell.nameLabel.text = selectedCuisine
        case 3:
            cell.nameLabel.text = selectedKitchen
        default:
            print("default")
        }
        cell.typeIcon.image = self.imagesArray[indexPath.row]
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedTableRowIndex = indexPath.row
        pickerTextField.becomeFirstResponder()
    }
}
extension HomeVC:UICollectionViewDataSource,UICollectionViewDelegate{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:HomeCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCollectionCell", for: indexPath) as! HomeCollectionCell
        if indexPath.row == 6{
            cell.itemIcon.backgroundColor = UIColor(red:0.64, green:0.10, blue:0.36, alpha:1.0)
            cell.viewMoreLabel.isHidden = false
        }
        else{
            cell.itemIcon.backgroundColor = .clear
            cell.viewMoreLabel.isHidden = true
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 6{
            let viewMoreVC:ViewMoreVC = ViewMoreVC(nibName: "ViewMoreVC", bundle: nil)
            if collectionView == offersCollectionView{
               viewMoreVC.pageType = ViewMoreType.Offers
            }
            else{
                viewMoreVC.pageType = ViewMoreType.ReadyNow
            }
            self.navigationController?.pushViewController(viewMoreVC, animated: true)
        }
        else{
            let viewController:ProductDetailVC = ProductDetailVC(nibName: "ProductDetailVC", bundle: nil)
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
}
extension HomeVC:UIPickerViewDelegate,UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch selectedTableRowIndex {
        case 0:
            return 4
        case 1:
           return self.mealModel.count
        case 2:
            return self.cuisinesModel.count
        case 3:
            return self.kitchenModel.count
        default:
            return 4
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        switch selectedTableRowIndex {
        case 0:
            return ARR1[row]
        case 1:
            return self.mealModel[row].catName
        case 2:
            return self.cuisinesModel[row].subCatName
        case 3:
            return self.kitchenModel[row].KitchenName
        default:
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        switch selectedTableRowIndex {
        case 0:
            selectedCity = ARR1[row]
        case 1:
            selectedMeal = self.mealModel[row].catName
        case 2:
            selectedCuisine = self.cuisinesModel[row].subCatName
        case 3:
            selectedKitchen = self.kitchenModel[row].KitchenName
        default:
            print("default")
        }
    }
}
