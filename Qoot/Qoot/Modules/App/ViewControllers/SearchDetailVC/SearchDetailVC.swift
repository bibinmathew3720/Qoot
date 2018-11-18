//
//  SearchDetailVC.swift
//  Qoot
//
//  Created by Bibin Mathew on 8/6/18.
//  Copyright © 2018 Cl. All rights reserved.
//

import UIKit

class SearchDetailVC: BaseViewController {
    @IBOutlet weak var menuTableView: UITableView!
    @IBOutlet weak var customerRatingTitleLabel: UILabel!
    @IBOutlet weak var deliveryTitleLabel: UILabel!
    @IBOutlet weak var deliveryFeeTitleLabel: UILabel!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    
    @IBOutlet var customView: UIView!
    @IBOutlet weak var kitchenImageView: UIImageView!
    @IBOutlet weak var kitchenNameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var deliveryFeeLabel: UILabel!
    @IBOutlet weak var star1: UIButton!
    @IBOutlet weak var star2: UIButton!
    @IBOutlet weak var star3: UIButton!
    @IBOutlet weak var star4: UIButton!
    @IBOutlet weak var star5: UIButton!
    
    
    
    var buttonBar =  UIView()
    var infoView = InfoHeaderView()
    var reviewsView = ReviewsHeaderView()
    
    var kitchenResponse:ViewKitchens?
     var viewKitchensInfo:ViewKitchensInfo?
    var selectedSection: Int = -1
    var kitchenCategories:KitchenCategoriesResponseModel?
    var kitchenMenus:KitchenMenusResponseModel?
    var selDishes = [Dishes]()
    override func initView() {
        super.initView()
        initialisation()
        localisation()
        populateKitchenDetails()
        getKitchenDetailsApi()
    }
    
    func initialisation(){
        self.title = "Qoot".localiz()
        addingLeftBarButton()
        addCartIconOnly()
        addHomeIconAndCartIcon()
        menuTableView.register(UINib.init(nibName: "MenuTVC", bundle: nil), forCellReuseIdentifier: "menuTVC")
       
        infoView = Bundle.main.loadNibNamed("InfoHeaderView", owner: self, options: nil)?.first as! InfoHeaderView
        infoView.frame = CGRect(x: 0, y: 0 , width: customView.bounds.width, height: customView.bounds.height)
        
        reviewsView = Bundle.main.loadNibNamed("ReviewsHeaderView", owner: self, options: nil)?.first as! ReviewsHeaderView
        reviewsView.frame = CGRect(x: 0, y: 0 , width: customView.bounds.width, height: customView.bounds.height)
        customView.addSubview(reviewsView)
        customView.addSubview(infoView)
        
        customView.isHidden = true
        let headerNib = UINib.init(nibName: "MenuSectionHeaderView", bundle: Bundle.main)
        menuTableView.register(headerNib, forHeaderFooterViewReuseIdentifier: "MenuSectionHeaderView")
        buttonBar.translatesAutoresizingMaskIntoConstraints = false
        buttonBar.backgroundColor = UIColor(red:0.64, green:0.10, blue:0.36, alpha:1.0)
        view.addSubview(buttonBar)
        buttonBar.topAnchor.constraint(equalTo: segmentControl.bottomAnchor).isActive = true
        buttonBar.heightAnchor.constraint(equalToConstant: 5).isActive = true
        buttonBar.leftAnchor.constraint(equalTo: segmentControl.leftAnchor).isActive = true
        buttonBar.widthAnchor.constraint(equalTo: segmentControl.widthAnchor, multiplier: 1 / CGFloat(segmentControl.numberOfSegments)).isActive = true
        segmentControl.selectedSegmentIndex = 0
        segmentControl.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.black,NSAttributedStringKey.font: UIFont(name: Constant.Font.Bold, size: 17)!], for: .selected)
        segmentControl.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.black,NSAttributedStringKey.font: UIFont(name: Constant.Font.Bold, size: 17)!], for: .normal)
    }
    
    func localisation(){
        self.customerRatingTitleLabel.text = "CustomerRating".localiz()
        self.deliveryTitleLabel.text = "Delivery".localiz()
        self.deliveryFeeTitleLabel.text = "DeliveryFee".localiz()
        self.segmentControl.setTitle("Menu".localiz(), forSegmentAt: 0)
        self.segmentControl.setTitle("Reviews".localiz(), forSegmentAt: 1)
        self.segmentControl.setTitle("Info".localiz(), forSegmentAt: 2)
    }
    
    func populateKitchenDetails(){
        if let kichenDetail = self.kitchenResponse{
             kitchenImageView.sd_setImage(with: URL(string: kichenDetail.KitchenLogo), placeholderImage: UIImage(named: Constant.ImageNames.placeholderImage))
            kitchenNameLabel.text = kichenDetail.KitchenName
            ratingLabel.text = String(format: "%.1f", kichenDetail.CutomerRating)
            deliveryFeeLabel.text = "SAR".localiz() + " " + String(format: "%.1f", kichenDetail.KitchenDeliveryFee)
            setRating(rating: kichenDetail.AdminRating)
        }
    }
    
    func setRating(rating:Int){
        unselectingAllRatingButtons()
        if rating == 1{
            star1.isSelected = true
        }
        else if rating == 2 {
            star1.isSelected = true
            star2.isSelected = true
        }
        else if rating == 3 {
            star1.isSelected = true
            star2.isSelected = true
            star3.isSelected = true
        }
        else if rating == 4 {
            star1.isSelected = true
            star2.isSelected = true
            star3.isSelected = true
            star4.isSelected = true
        }
        else if rating == 5 {
            star1.isSelected = true
            star2.isSelected = true
            star3.isSelected = true
            star4.isSelected = true
            star5.isSelected = true
        }
    }
    
    func unselectingAllRatingButtons(){
        star1.isSelected = false
        star2.isSelected = false
        star3.isSelected = false
        star4.isSelected = false
        star5.isSelected = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func segmentControlAction(_ sender: Any) {
        
        UIView.animate(withDuration: 0.3) {

            self.buttonBar.frame.origin.x = ((self.segmentControl.frame.width / CGFloat(self.segmentControl.numberOfSegments)) * CGFloat(self.segmentControl.selectedSegmentIndex))
        }
        switch self.segmentControl.selectedSegmentIndex {
        case 0:
            customView.isHidden = true
        case 1:
            customView.isHidden = false
            infoView.isHidden = true
            getKitchenAdminRatingApi()
        case 2:
            customView.isHidden = false
            infoView.isHidden = false
            if let kitchenInfo = self.viewKitchensInfo{
                self.infoView.setKitchenInfo(kitchenInfo: kitchenInfo)
            }
            getKitchenInfoApi()
        default:
            print("default")
        }
       print(self.segmentControl.selectedSegmentIndex)
    }
    
    //Get Kitchen Categories Api
    
    func getKitchenCategoriesApi(){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        UserManager().callingKitchenCategoriesApi(with:getKitchenCategoriesRequestBody(), success: {
            (model) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if let model = model as? KitchenCategoriesResponseModel{
                self.kitchenCategories = model
                self.menuTableView.reloadData()
                self.getKitchenMenusApi()
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
    
    func getKitchenCategoriesRequestBody()->String{
        var dataString:String = ""
        if let kitchen = self.kitchenResponse {
            let kitchenId:String = "KitchenId=\(String(kitchen.KitchenId).urlEncode())"
            dataString = dataString + kitchenId
        }
        return dataString
    }
    
    //Get Kitchen Menus Api
    
    func getKitchenMenusApi(){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        UserManager().callingGetKitchenMenusApi(with:getKitchenMenusRequestBody(), success: {
            (model) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if let model = model as? KitchenMenusResponseModel{
                self.kitchenMenus = model
                self.menuTableView.reloadData()
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
    
    func getKitchenMenusRequestBody()->String{
        var dataString:String = ""
        if let kitchen = self.kitchenResponse {
            let kitchenId:String = "KitchenId=\(String(kitchen.KitchenId).urlEncode())"
            dataString = dataString + kitchenId
        }
        return dataString
    }
    
}

extension SearchDetailVC : UITableViewDelegate,UITableViewDataSource,MenuSectionHeaderViewDelegate{
    func headerButtonActionDelegate(with tag: Int) {
        self.selectedSection = tag
        var categoryId = 0
        if let categoryResponse = self.kitchenCategories {
            categoryId = categoryResponse.kitchenCatgories[tag].categoryId
        }
        if let kitchenMenusResponse = self.kitchenMenus {
            let filteredArray = kitchenMenusResponse.dishes.filter({$0.DishMainCategory == categoryId })
            self.selDishes = filteredArray
            self.menuTableView.reloadData()
        }
    
    }
    
    func arrowButtonDelegateAction(with tag: Int) {
        if selectedSection != tag {
            selectedSection = tag
            menuTableView.reloadData()
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let categoriesResponse = self.kitchenCategories{
            return categoriesResponse.kitchenCatgories.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == selectedSection{
            return self.selDishes.count
        }
        else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuTVC", for: indexPath) as!MenuTVC
        cell.setDishDetails(dish:self.selDishes[indexPath.row])
        cell.tag = indexPath.row
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       self.selectedSection = indexPath.section
        menuTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let rowHieght = 100
        return CGFloat(rowHieght)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "MenuSectionHeaderView") as! MenuSectionHeaderView
        headerView.tag = section
        headerView.delegate = self
        if let categoriesResponse = self.kitchenCategories{
            headerView.setCategory(category: categoriesResponse.kitchenCatgories[section])
        }
        headerView.delegate = self
        return headerView
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func getKitchenDetailsApi(){
        //MBProgressHUD.showAdded(to: self.view, animated: true)
    UserManager().callingGetKitchenDetailsApi(with:getKitchenDetailsRequestBody(), success: {
            (model) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if let model = model as? ViewKitchens{
                self.kitchenResponse = model
                self.populateKitchenDetails()
               self.getKitchenCategoriesApi()
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
        if let kitchen = self.kitchenResponse {
            let kitchenId:String = "KitchenId=\(String(kitchen.KitchenId).urlEncode())"
            dataString = dataString + kitchenId
        }
        return dataString
    }
   
    func getKitchenInfoApi(){
        //MBProgressHUD.showAdded(to: self.view, animated: true)
        UserManager().callingGetKitchenInfoApi(with:getKitchenDetailsRequestBody(), success: {
            (model) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if let model = model as? ViewKitchensInfoResponseModel{
               self.viewKitchensInfo = model.kitchensInfo[0]
                if let kitchenInfo = self.viewKitchensInfo{
                    self.infoView.setKitchenInfo(kitchenInfo: kitchenInfo)
                }
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
    func getKitchenAdminRatingApi(){
        //MBProgressHUD.showAdded(to: self.view, animated: true)
        UserManager().callingGetKitchenAdminRatingApi(with:getKitchenDetailsRequestBody(), success: {
            (model) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if let model = model as? KitchenAdminRatingResponseModel{
                self.reviewsView.setAdminRating(adminRating:model)
                self.getKitchenCustomerRatingApi()
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
    
    func getKitchenCustomerRatingApi(){
        //MBProgressHUD.showAdded(to: self.view, animated: true)
        UserManager().callingGetKitchenCustomerRatingApi(with:getKitchenDetailsRequestBody(), success: {
            (model) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if let model = model as? KitchenCustomerRatingsResponseModel{
                self.reviewsView.setCustomerRating(customerRatngs:model.customerRating)
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

}

extension SearchDetailVC: MenuTVCDelegate {
    func plusButtonActionDelegate(with tag: Int) {
        let dish = self.selDishes[tag]
        Cart.addProductToCart(dish: dish)
        CCUtility.showDefaultAlertwith(_title: Constant.AppName, _message: "ItemSuccessfullyAdded".localiz(), parentController: self)
        updateCartLabel()
    }
}
