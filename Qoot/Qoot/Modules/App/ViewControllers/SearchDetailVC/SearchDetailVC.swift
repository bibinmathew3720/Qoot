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
    
    override func initView() {
        super.initView()
        initialisation()
        localisation()
        populateKitchenDetails()
        getKitchenDetailsApi()
        getKitchenInfoApi()
        getKitchenAdminRatingApi()
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
        case 2:
            customView.isHidden = false
            infoView.isHidden = false
            infoView.viewKitchensInfo = self.viewKitchensInfo
        default:
            print("default")
        }
    }
}

extension SearchDetailVC : UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowCount :Int = 1
        return rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuTVC", for: indexPath) as!MenuTVC
        cell.tag = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let rowHieght = 100
        return CGFloat(rowHieght)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = Bundle.main.loadNibNamed("MenuHeaderView", owner: self, options: nil)?.first as! MenuHeaderView
        //headerView.setterMethod(orderDetails: historyDetailsModel[section])
        //headerView.delegate = self
//        if selectedIndex == section{
//            headerView.viewButton.setTitle("close".localiz(), for: .normal)
//        }
        headerView.tag = section
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func getKitchenDetailsApi(){
        MBProgressHUD.showAdded(to: self.view, animated: true)
    UserManager().callingGetKitchenDetailsApi(with:getKitchenDetailsRequestBody(), success: {
            (model) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if let model = model as? ViewKitchens{
                self.kitchenResponse = model
                self.populateKitchenDetails()
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
        MBProgressHUD.showAdded(to: self.view, animated: true)
        UserManager().callingGetKitchenInfoApi(with:getKitchenDetailsRequestBody(), success: {
            (model) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if let model = model as? ViewKitchensInfoResponseModel{
               self.viewKitchensInfo = model.kitchensInfo[0]
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
        MBProgressHUD.showAdded(to: self.view, animated: true)
        UserManager().callingGetKitchenAdminRatingApi(with:getKitchenDetailsRequestBody(), success: {
            (model) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if let model = model as? ViewKitchensInfoResponseModel{
                self.viewKitchensInfo = model.kitchensInfo[0]
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
