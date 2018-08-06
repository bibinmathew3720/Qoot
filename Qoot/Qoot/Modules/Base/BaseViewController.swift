//
//  BaseViewController.swift
//  Preparture
//
//  Created by praveen raj on 17/06/18.
//  Copyright © 2018 praveen raj. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    var leftButton:UIButton?
    var rightButton:UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initView() {
        
    }
    //MARK: Adding Navigation Bar Buttons
    
    func addingLeftBarButton(){
        self.leftButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        self.leftButton?.addTarget(self, action: #selector(leftNavButtonAction), for: .touchUpInside)
        self.leftButton?.setImage(UIImage.init(named: Constant.ImageNames.backArrow), for: UIControlState.normal)
        var leftBarButton = UIBarButtonItem()
        leftBarButton = UIBarButtonItem.init(customView: self.leftButton!)
        self.navigationItem.leftBarButtonItem = leftBarButton
    }
    
    @objc func leftNavButtonAction(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func addRightNavBarIcon(){
        self.rightButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        self.rightButton?.addTarget(self, action: #selector(rightNavButtonAction), for: .touchUpInside)
        self.rightButton?.setImage(UIImage.init(named: "cartIcon"), for: UIControlState.normal)
        var rightBarButton = UIBarButtonItem()
        rightBarButton = UIBarButtonItem.init(customView: self.rightButton!)
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc func rightNavButtonAction(){
        self.navigationController?.popToRootViewController(animated: true)
        self.tabBarController?.selectedIndex = 2
    }
    
    //MARK: Adding Shadow View
    
    func addShadowToAView(shadowView:UIView){
        shadowView.layer.shadowColor = UIColor.lightGray.cgColor
        shadowView.layer.shadowOpacity = 1
        shadowView.layer.shadowOffset = CGSize.zero
        shadowView.layer.shadowRadius = 3
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
