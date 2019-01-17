//
//  ProductDetailVC.swift
//  DemoPgm
//
//  Created by Vishnu KM on 03/08/18.
//  Copyright © 2018 Vishnu KM. All rights reserved.
//

import UIKit

class ProductDetailVC: BaseViewController {

    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet var countLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var productDescriptionLabel: UILabel!
    @IBOutlet var productTitle: UILabel!
    @IBOutlet var addCartLabel: UILabel!
    @IBOutlet var quantityLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var servesCountLabel: UILabel!
    
    @IBOutlet var quantityTitle: UILabel!
    @IBOutlet var preparationTimeTitle: UILabel!
    @IBOutlet var servesAvailableTitle: UILabel!
    var count: Int = 1
    
    var dishDetail:Dishes?
    var kitchenResponse:ViewKitchens?
    
    override func initView() {
        super.initView()
        localisation()
        addingLeftBarButton()
        addCartIconOnly()
        populateDishDetails()
        getDishDetailsApi()
    }
    
    func localisation(){
        self.servesAvailableTitle.text = "ServicesAvailable".localiz()
        self.preparationTimeTitle.text = "PreparationTime".localiz()
        self.quantityTitle.text = "Quantity".localiz()
        self.addCartLabel.text = "AddToCart".localiz()
    }
    
    func populateDishDetails(){
        if let dish = dishDetail{
            dishImageView.sd_setImage(with: URL(string: dish.DishImage), placeholderImage: UIImage(named: Constant.ImageNames.placeholderImage))
            productTitle.text = dish.DishName
            priceLabel.text = "SAR".localiz() + " " + String(format: "%0.2f", dish.DishAmount)
            productDescriptionLabel.text = dish.DishDescription
            servesCountLabel.text = String(format: "%d", dish.DishServe)
            timeLabel.text = dish.DishTime
            quantityLabel.text = dish.DishQuantity
            countLabel.text = String(dish.SelectedQuantity)
        }
    }
    
    func getDishDetailsApi(){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        UserManager().callingGetDishDetailsApi(with:getDishDetailsRequestBody(), success: {
            (model) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if let model = model as? Dishes{
                //self.dishDetail = model
                //self.populateDishDetails()
            }
            self.getKitchenDetailsApi()
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
    
    func getDishDetailsRequestBody()->String{
        var dataString:String = ""
        if let dish = self.dishDetail {
            let kitchenId:String = "KitchenId=\(String(dish.KitchenId).urlEncode())"
            dataString = dataString + kitchenId
            let menuId:String = "MenuId=\(String(dish.MenuId).urlEncode())"
            dataString = dataString + "&" + menuId
        }
        return dataString
    }
    
    func getKitchenDetailsApi(){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        UserManager().callingGetKitchenDetailsApi(with:getKitchenDetailsRequestBody(), success: {
            (model) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if let model = model as? ViewKitchens{
                self.kitchenResponse = model
               
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
    
    func getKitchenDetailsRequestBody()->String{
        var dataString:String = ""
        if let dish = self.dishDetail {
            let kitchenId:String = "KitchenId=\(String(dish.KitchenId).urlEncode())"
            dataString = dataString + kitchenId
        }
        return dataString
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func minusButtonAction(_ sender: Any) {
        if let dish = dishDetail {
            if dish.SelectedQuantity != 0{
                dish.SelectedQuantity = dish.SelectedQuantity - 1
                countLabel.text = String(dish.SelectedQuantity)
            }
        }
    }
    
    @IBAction func plusButtonAction(_ sender: Any) {
        if let dish = dishDetail {
            dish.SelectedQuantity = dish.SelectedQuantity + 1
            countLabel.text = String(dish.SelectedQuantity)
        }
        
    }
    
    @IBAction func addToCartButtonAction(_ sender: UIButton) {
        if let dish = dishDetail{
            if let kitchenRes = self.kitchenResponse {
                if Cart.isOtherKitchensDishesAdded(dish: dish){
                    CCUtility.showAlertWithYesOrNo(_title: Constant.AppName, viewController: self, messageString: "AllItemsWillRemoveFromCart".localiz()) { (isYes) in
                        if (isYes){
                            Cart.deletAllItemsFromCart()
                            self.addDishToCart(dish: dish, kitchen: kitchenRes)
                        }
                    }
                }
                else{
                    addDishToCart(dish: dish, kitchen: kitchenRes)
                }
            }
        }
    }
    
    func addDishToCart(dish:Dishes, kitchen:ViewKitchens){
        Cart.addProductToCart(dish: dish, kitchen: kitchen)
        CCUtility.showDefaultAlertwith(_title: Constant.AppName, _message: "ItemSuccessfullyAdded".localiz(), parentController: self)
        updateCartLabel()
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
