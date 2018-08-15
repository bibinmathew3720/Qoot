//
//  LanguageVC.swift
//  Qoot
//
//  Created by Bibin Mathew on 8/15/18.
//  Copyright © 2018 Cl. All rights reserved.
//

import UIKit

class LanguageVC: BaseViewController {

    override func initView() {
        super.initView()
        initialisation()
    }
    
    func initialisation(){
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func segmentControlAction(_ sender: UISegmentedControl) {
    }
    
    @IBAction func startButtonAction(_ sender: UIButton) {
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
