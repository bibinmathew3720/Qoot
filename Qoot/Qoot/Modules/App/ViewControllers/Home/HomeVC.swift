//
//  HomeVC.swift
//  DemoPgm
//
//  Created by Vishnu KM on 03/08/18.
//  Copyright © 2018 Vishnu KM. All rights reserved.
//

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
    var cityNamesResponseModel:QootCityNamesResponseModel?
    var selCity:CityName?
    var mealModel:QootMealTypeResponseModel?
    var selMeal:MealTypes?
    var cuisinesModel:ViewCuisinesResponseModel?
    var selCuisine:ViewCuisines?
    var kitchenModel:KitchensResponseModel?
    var selKitchen:ViewKitchens?
    var offersResponseModel:OfferDishesResponseModel?
    var reayNowDishesReaponseModel:ReadyNowDishesResponseModel?
    
    override func initView() {
        super.initView()
        initialisation()
        localisation()
        addingLeftBarButton()
        addCartIconOnly()
        getOfferDishesApi()
        //callingCityNameApi()
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
        if let city = self.selCity {
            MBProgressHUD.showAdded(to: self.view, animated: true)
            callingKitchensApi { (status, kitchenResponseModel) in
                if status {
                    let searchResultsVC = SearchResultsVC.init(nibName: "SearchResultsVC", bundle: nil)
                    searchResultsVC.kitchensResponseModel = kitchenResponseModel
                self.navigationController?.pushViewController(searchResultsVC, animated: true)
                }
            }
        }
        else{
            CCUtility.showDefaultAlertwith(_title: Constant.AppName, _message: "CHOOSECITYFIRST".localiz(), parentController: self)
        }
        
    }
     //MARK: City Names Api
    
    func callingCityNameApi(){
        //MBProgressHUD.showAdded(to: self.view, animated: true)
        UserManager().callingCityNameApi(with: "", success: {
            (model) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if let model = model as? QootCityNamesResponseModel{
                self.cityNamesResponseModel = model
                self.pickerView.reloadAllComponents()
                self.callingMealTypeApi()
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
    
    //MARK: MealType Api
    
    func  callingMealTypeApi(){
        //MBProgressHUD.showAdded(to: self.view, animated: true)
        UserManager().callingViewMealTypeApi(with: "", success: {
            (model) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if let model = model as? QootMealTypeResponseModel{
               self.mealModel = model
               self.pickerView.reloadAllComponents()
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
        //MBProgressHUD.showAdded(to: self.view, animated: true)
        UserManager().callingViewCuisinesApi(with: getCuisinesRequestBody(), success: {
            (model) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if let model = model as? ViewCuisinesResponseModel{
                self.cuisinesModel = model
                self.pickerView.reloadAllComponents()
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
        var dataString:String = ""
        if let seMeal = self.selMeal {
            let mealId:String = "CategoryId=\(String(seMeal.catId).urlEncode())"
            dataString = dataString + mealId
        }
        return dataString
    }
    
    //MARK: Kitchens Api
    
    func  callingKitchensApi(response:@escaping(Bool,KitchensResponseModel?)->()){
        //MBProgressHUD.showAdded(to: self.view, animated: true)
        UserManager().callingKitchensApi(with: getKitchenRequestBody(), success: {
            (model) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if let model = model as? KitchensResponseModel{
               
                response(true,model)
            }
            response(false,nil)
            
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
    
    func getKitchenRequestBody()->String{
        var dataString:String = ""
        if let seCity = self.selCity {
            let cityId:String = "CityName=\(String(seCity.cityName).urlEncode())"
            dataString = dataString + cityId
            
        }
        if let seMeal = self.selMeal {
            if dataString.count>0{
                dataString = dataString + "&"
            }
            let mealId:String = "Category=\(String(seMeal.catId).urlEncode())"
            dataString = dataString + mealId
        }
       
        if let seCuisine = self.selCuisine {
            if dataString.count>0{
                dataString = dataString + "&"
            }
            let cuisineId:String = "SubCategory=\(String(seCuisine.subCatId).urlEncode())"
            dataString = dataString + cuisineId
        }
        return dataString
    }
    
    func getOfferDishesApi(){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        UserManager().callingOfferDishesApi(with:"", success: {
            (model) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if let model = model as? OfferDishesResponseModel{
                self.offersResponseModel = model
                self.offersCollectionView.reloadData()
                self.getReadyNowDishesApi()
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
    
    func getReadyNowDishesApi(){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        UserManager().callingReadyNowDishesApi(with:"", success: {
            (model) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if let model = model as? ReadyNowDishesResponseModel{
                self.reayNowDishesReaponseModel = model
                self.readyNowCollectionView.reloadData()
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
    
    @IBAction func toolBarDoneAction(_ sender: Any) {
//        if selectedCity == TYPE_FIELDS[0] || selectedMeal == TYPE_FIELDS[1] || selectedCuisine == TYPE_FIELDS[2] || selectedKitchen == TYPE_FIELDS[3]{
            switch selectedTableRowIndex {
            case 0:
                if let cityModel = self.cityNamesResponseModel{
                    selCity = cityModel.cityNames[pickerView.selectedRow(inComponent: 0)]
                }
            case 1:
                if let mealMd = self.mealModel {
                    selMeal = mealMd.mealTypes[pickerView.selectedRow(inComponent: 0)]
                    callingViewCuisinesApi()
                }
            case 2:
                if let cuisineModel = self.cuisinesModel{
                    selCuisine = cuisineModel.viewCuisines[pickerView.selectedRow(inComponent: 0)]
                    callingKitchensApi { (status, kitchenResponseModel) in
                        if status {
                            self.kitchenModel = kitchenResponseModel
                            self.pickerView.reloadAllComponents()
                        }
                    }
                }
            case 3:
                if let kitchenModel = self.kitchenModel{
                     selKitchen = kitchenModel.viewKitchens[pickerView.selectedRow(inComponent: 0)]
                }
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
            if let selCity = self.selCity{
               cell.nameLabel.text = selCity.cityName
            }
            else{
                cell.nameLabel.text = selectedCity
            }
            
        case 1:
            if let selMeal = self.selMeal{
                cell.nameLabel.text = selMeal.catName
            }
            else{
                cell.nameLabel.text = selectedMeal
            }
        case 2:
            if let selCui = self.selCuisine{
                cell.nameLabel.text = selCui.subCatName
            }
            else{
                cell.nameLabel.text = selectedCuisine
            }
        case 3:
            if let selKi = self.selKitchen{
                cell.nameLabel.text = selKi.KitchenName
            }
            else{
                cell.nameLabel.text = selectedKitchen
            }
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
        if collectionView == offersCollectionView {
            if let offerDishes = self.offersResponseModel{
                if offerDishes.dishes.count>7{
                    return 7
                }
                else{
                    return offerDishes.dishes.count
                }
            }
        }
        if collectionView == readyNowCollectionView {
            if let readyDishes = self.reayNowDishesReaponseModel{
                if readyDishes.dishes.count>7{
                    return 7
                }
                else{
                    return readyDishes.dishes.count
                }
            }
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:HomeCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCollectionCell", for: indexPath) as! HomeCollectionCell
        if collectionView == offersCollectionView {
            if let offerDishes = self.offersResponseModel{
                if offerDishes.dishes.count>7{
                    if indexPath.row != 6{
                        cell.setDish(dish:offerDishes.dishes[indexPath.row])
                    }
                    else{
                        cell.hideDishControls()
                    }
                }
                else{
                     cell.setDish(dish:offerDishes.dishes[indexPath.row])
                }
            }
        }
        
        if collectionView == readyNowCollectionView {
            if let readyDishes = self.reayNowDishesReaponseModel{
                if readyDishes.dishes.count>7{
                    if indexPath.row != 6{
                        cell.setDish(dish:readyDishes.dishes[indexPath.row])
                    }
                    else{
                        cell.hideDishControls()
                    }
                }
                else{
                    cell.setDish(dish:readyDishes.dishes[indexPath.row])
                }
            }
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
            if let cityModel = self.cityNamesResponseModel{
                return cityModel.cityNames.count
            }
            return 0
        case 1:
            if let mealTypeModel = self.mealModel{
                return mealTypeModel.mealTypes.count
            }
           return 0
        case 2:
            if let cuisineModel = self.cuisinesModel{
                return cuisineModel.viewCuisines.count
            }
            return 0
        case 3:
            if let kitchenModel = self.kitchenModel{
                return kitchenModel.viewKitchens.count
            }
            return 0
        default:
            return 4
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        switch selectedTableRowIndex {
        case 0:
            if let cityModel = self.cityNamesResponseModel{
                return cityModel.cityNames[row].cityName
            }
            return ""
        case 1:
            if let mealTypeModel = self.mealModel{
                return mealTypeModel.mealTypes[row].catName
            }
            return ""
        case 2:
            if let cuisineModel = self.cuisinesModel{
                return cuisineModel.viewCuisines[row].subCatName
            }
            return ""
        case 3:
            if let kitchenModel = self.kitchenModel{
                return kitchenModel.viewKitchens[row].KitchenName
            }
            return ""
        default:
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
    }
}
