//
//  DeliveryDetailsVC.swift
//  Qoot
//
//  Created by Vishnu KM on 07/08/18.
//  Copyright © 2018 Cl. All rights reserved.
//
let PAY_FIELDS = ["COD".localiz(),"Paypal".localiz(),"Visa".localiz(),"Wallet".localiz()]
import UIKit

class DeliveryDetailsVC: BaseViewController,PaymentTableCellDelegate {
    @IBOutlet var dateTextField: UITextField!
    @IBOutlet var toolbar: UIToolbar!
    @IBOutlet var promoCodeTextField: UITextField!
    @IBOutlet var paymentTable: UITableView!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var addressTable: UITableView!
    @IBOutlet var closeButtonHeight: NSLayoutConstraint!
    @IBOutlet var addAddressButtonHeightConstraint: NSLayoutConstraint!
    @IBOutlet var addAddressButton: UIButton!
    @IBOutlet var mapViewHeight: NSLayoutConstraint!
    var selectedDate:String = ""
    var selectedIndex: Int = -1
   
    override func initView() {
        initialisation()
        addingLeftBarButton()
    }
    
    func initialisation(){
         self.title = "Qoot".localiz()
        addressTable.register(UINib(nibName: "AddressTableCell", bundle: nil), forCellReuseIdentifier: "Cell")
        paymentTable.register(UINib(nibName: "PaymentTableCell", bundle: nil), forCellReuseIdentifier: "paymentCell")
        dateTextField.inputAccessoryView = toolbar
        dateTextField.inputView = datePicker
    }
   
    @IBAction func datePickerAction(_ sender: UIDatePicker) {
       
    }
    
    @IBAction func toolbarCancelAction(_ sender: Any) {
        view.endEditing(true)
    }
    @IBAction func toolbarDoneAction(_ sender: Any) {
         if selectedDate == ""{
            
        }
    }
    @IBAction func tapAction(_ sender: Any) {
          view.endEditing(true)
    }
    
    @IBAction func addAddressButtonAction(_ sender: Any) {
        closeButtonHeight.constant = 30
        addAddressButtonHeightConstraint.constant = 0
        mapViewHeight.constant = 190
    }
    
    @IBAction func closeButtonAction(_ sender: Any) {
        mapViewHeight.constant = 0
        closeButtonHeight.constant = 0
        addAddressButtonHeightConstraint.constant = 40
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    func paymentButtonDelegateAction(with tag: Int) {
        selectedIndex = tag
        paymentTable.reloadData()
    }

}
extension DeliveryDetailsVC : UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == paymentTable{
            return 4
        }
        else{
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if tableView == paymentTable{
            let payCell = tableView.dequeueReusableCell(withIdentifier: "paymentCell", for: indexPath) as! PaymentTableCell
            payCell.delegate = self
            payCell.tag = indexPath.row
            payCell.paymentTypeLabel.text = PAY_FIELDS[indexPath.row]
            payCell.setModel(index:indexPath.row,selectedIndex:selectedIndex)
            cell = payCell
        }
        else{
             let addressCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! AddressTableCell
            cell = addressCell
        }
        return cell
    }
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == paymentTable{
            return 50
        }
        else{
            return 90
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
