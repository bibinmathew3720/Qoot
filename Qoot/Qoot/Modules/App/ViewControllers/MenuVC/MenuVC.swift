//
//  MenuVC.swift
//  Qoot
//
//  Created by Bibin Mathew on 8/4/18.
//  Copyright © 2018 Cl. All rights reserved.
//

import UIKit
import GoogleSignIn
import FBSDKLoginKit

class MenuVC: BaseViewController {
    var isLoggedIn:Bool = false
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var profileViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var logInButtonView: UIView!
    @IBOutlet weak var loginButtonViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var menuTableView: UITableView!
    @IBOutlet weak var languageSegment: UISegmentedControl!
    
    var titleArray = ["Offers".localiz(),"Support".localiz(),"Events".localiz()]
    var imageArray = [#imageLiteral(resourceName: "offers"),#imageLiteral(resourceName: "support"),#imageLiteral(resourceName: "events")]
    var titleArrayAccount = ["MyOrders".localiz(),"MyWallet".localiz(),"MyAddresses".localiz(),"Offers".localiz(),"Support".localiz(),"Events".localiz(),"Settings".localiz(),"Logout".localiz()]
    var imageArrayAccount =  [#imageLiteral(resourceName: "myOrders"),#imageLiteral(resourceName: "myWallet"),#imageLiteral(resourceName: "myOrders"),#imageLiteral(resourceName: "offers"),#imageLiteral(resourceName: "support"),#imageLiteral(resourceName: "events"),#imageLiteral(resourceName: "settings"),#imageLiteral(resourceName: "logout")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialisation()
        uiUpdations()
        localisation()
        // Do any additional setup after loading the view.
    }
  
    func initialisation(){
         menuTableView.register(UINib.init(nibName: "ManuTVC", bundle: nil), forCellReuseIdentifier: "menuTVC")
        if LanguageManger.shared.currentLanguage == .en {
            languageSegment.selectedSegmentIndex = 0
        }
        else{
           languageSegment.selectedSegmentIndex = 1
        }
        self.profileImage.layer.cornerRadius = self.profileImage.frame.size.height/2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let user = User.getUser(){
            nameLabel.text = user.name
            if let photo = user.customerPhoto{
                profileImage.loadImageUsingCache(withUrl: photo)
            }
            }
            
        self.isLoggedIn =  UserDefaults.standard.bool(forKey: Constant.VariableNames.isLoogedIn)
        uiUpdations()
    }
    
    func uiUpdations(){
        if isLoggedIn{
            logInButtonView.isHidden = true
            loginButtonViewHeightConstraint.constant = 0
            profileViewHeightConstraint.constant = 150
            profileView.isHidden = false
        }
        else{
            logInButtonView.isHidden = false
            loginButtonViewHeightConstraint.constant = 40
            profileViewHeightConstraint.constant = 0
            profileView.isHidden = true
        }
        self.menuTableView.reloadData()
    }
    
    func localisation(){
        self.logInButton.setTitle("Login".localiz(), for: UIControlState.normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func segmentControlAction(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            if LanguageManger.shared.currentLanguage != .en {
                let selectedLanguage:Languages = .en
                UserDefaults.standard.set("en" , forKey: "language")
                LanguageManger.shared.setLanguage(language: selectedLanguage)
                reinitialiseRoot()
            }
        }
        else{
            if LanguageManger.shared.currentLanguage != .ar {
                let selectedLanguage:Languages = .ar
                UserDefaults.standard.set("ar" , forKey: "language")
                LanguageManger.shared.setLanguage(language: selectedLanguage)
                reinitialiseRoot()
            }
        }
    }
    
    func reinitialiseRoot(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.initWindow()
    }
    
    @IBAction func loginButtonAction(_ sender: UIButton) {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let dashBoardVC = storyBoard.instantiateViewController(withIdentifier: "DashboardVC") as! DashboardVC
        let dashBoardNavCntlr = UINavigationController.init(rootViewController: dashBoardVC)
        self.present(dashBoardNavCntlr, animated: true, completion: nil)
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

extension MenuVC : UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowCount :Int = 0
        if self.isLoggedIn {
            rowCount = titleArrayAccount.count
        }
        else{
            rowCount = titleArray.count
        }
        return rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuTVC", for: indexPath) as!ManuTVC
        cell.tag = indexPath.row
        if self.isLoggedIn{
            cell.menuIcon.image = self.imageArrayAccount[indexPath.row]
            cell.menuLabel.text = self.titleArrayAccount[indexPath.row]
        }
        else{
            cell.menuIcon.image = self.imageArray[indexPath.row]
            cell.menuLabel.text = self.titleArray[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isLoggedIn{
            if indexPath.row == 0{
               setOrderListVC()
            }
            else if indexPath.row == 1{ //Wallet
                self.closeLeft()
            }
            else if indexPath.row == 2 {
                setMyAddressesVC()
            }
            else if indexPath.row == 3 {
                setOffersVC()
            }
            else if indexPath.row == 4{ //Support
                self.closeLeft()
            }
            else if (indexPath.row == 5){ //Events
                self.loadEventsPage()
            }
            else if (indexPath.row == 6){
                setSettingsVC()
            }
            else if (indexPath.row == 7){
                settingLogoutPopup()
            }
        }
        else{
            if indexPath.row == 0 {
                setOffersVC()
            }
            else if indexPath.row == 1{ //Support
                self.closeLeft()
            }
            else if indexPath.row == 2{ //Events
                self.loadEventsPage()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let rowHieght = 60
        return CGFloat(rowHieght)
    }
    
    func setOffersVC(){
        let viewMoreVC:ViewMoreVC = ViewMoreVC(nibName: "ViewMoreVC", bundle: nil)
        viewMoreVC.pageType = ViewMoreType.Offers
        viewMoreVC.isFromMenu = true
        let navController = UINavigationController.init(rootViewController: viewMoreVC)
        self.present(navController, animated: true, completion: nil)
    }
    
    func setMyAddressesVC(){
        let addressListingVC = AddressListingVC.init(nibName: "AddressListingVC", bundle: nil)
        addressListingVC.isFromMenu = true
        let navController = UINavigationController.init(rootViewController: addressListingVC)
        self.present(navController, animated: true, completion: nil)
    }
    
    func setOrderListVC(){
        let orderListVC:OrderListVC = OrderListVC(nibName: "OrderListVC", bundle: nil)
        orderListVC.isFromMenu = true
        let navController = UINavigationController.init(rootViewController: orderListVC)
        self.present(navController, animated: true, completion: nil)
    }
    
    func loadEventsPage(){
        if let url = URL(string: Constant.Urls.eventsUrl) {
            if UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:])
                } else {
                    // Fallback on earlier versions
                }
            }
        }
    }
    
    func setSettingsVC(){
        let settingsVC:SettingsVC = SettingsVC(nibName: "SettingsVC", bundle: nil)
        let navController = UINavigationController.init(rootViewController: settingsVC)
        self.present(navController, animated: true, completion: nil)
    }
    
    func settingLogoutPopup(){
        self.slideMenuController()?.closeLeft()
        let alertController = UIAlertController(title: "LOGOUT".localiz(), message: "AREYOUSURE".localiz(), preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "YES".localiz(), style: .default) { (action:UIAlertAction) in
            UserDefaults.standard.set(false, forKey: Constant.VariableNames.isLoogedIn)
            User.deleteUser()
            GIDSignIn.sharedInstance().signOut()
            FBSDKLoginManager().logOut()
            self.uiUpdations()
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.initWindow()
        }
        let noAction = UIAlertAction(title: "NO".localiz(), style: .default) { (action:UIAlertAction) in
            
        }
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        self.present(alertController, animated: true) {
        }
    }
    
}



