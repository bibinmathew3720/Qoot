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
        }
    }
    
    func getDishDetailsApi(){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        UserManager().callingGetDishDetailsApi(with:getDishDetailsRequestBody(), success: {
            (model) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if let model = model as? Dishes{
                self.dishDetail = model
                self.populateDishDetails()
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
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func minusButtonAction(_ sender: Any) {
        if count != 0{
            count = count - 1
        }
        countLabel.text = String(count)
    }
    
    @IBAction func plusButtonAction(_ sender: Any) {
         count = count + 1
        countLabel.text = String(count)
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
