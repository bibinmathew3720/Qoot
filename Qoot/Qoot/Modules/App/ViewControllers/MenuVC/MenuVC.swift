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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiUpdations()
        localisation()
        // Do any additional setup after loading the view.
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
