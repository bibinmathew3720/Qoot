//
//  MenuVC.swift
//  Qoot
//
//  Created by Bibin Mathew on 8/4/18.
//  Copyright © 2018 Cl. All rights reserved.
//

import UIKit

class MenuVC: BaseViewController {
    var isLoggedIn:Bool = false
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var profileViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var logInButtonView: UIView!
    @IBOutlet weak var loginButtonViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var menuTableView: UITableView!
    
    var titleArray = ["Offers".localiz(),"Support".localiz()]
    var imageArray = [#imageLiteral(resourceName: "myWallet"),#imageLiteral(resourceName: "myWallet")]
    var titleArrayAccount = ["MyOrders".localiz(),"MyWallet".localiz(),"Offers".localiz(),"Support".localiz(),"Settings".localiz()]
    var imageArrayAccount =  [#imageLiteral(resourceName: "myWallet"),#imageLiteral(resourceName: "myWallet"),#imageLiteral(resourceName: "myWallet"),#imageLiteral(resourceName: "myWallet"),#imageLiteral(resourceName: "myWallet")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialisation()
        uiUpdations()
        localisation()
        // Do any additional setup after loading the view.
    }
    
    func initialisation(){
         menuTableView.register(UINib.init(nibName: "ManuTVC", bundle: nil), forCellReuseIdentifier: "menuTVC")
    }
    
    override func viewWillAppear(_ animated: Bool) {
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
            loginButtonViewHeightConstraint.constant = 60
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
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let rowHieght = 60
        return CGFloat(rowHieght)
    }
    
}



