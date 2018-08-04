//
//  ProductDetailVC.swift
//  DemoPgm
//
//  Created by Vishnu KM on 03/08/18.
//  Copyright © 2018 Vishnu KM. All rights reserved.
//

import UIKit

class ProductDetailVC: UIViewController {

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
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
