//
//  DeliveryDetailsVC.swift
//  Qoot
//
//  Created by Vishnu KM on 07/08/18.
//  Copyright © 2018 Cl. All rights reserved.
//
let PAY_FIELDS = ["COD".localiz(),"Paypal".localiz(),"Visa".localiz(),"Wallet".localiz()]
let PAYMENT_TYPE_IMAGES = [#imageLiteral(resourceName: "cod"),#imageLiteral(resourceName: "paypal"),#imageLiteral(resourceName: "visa"),#imageLiteral(resourceName: "payviawallet")]
import UIKit

class DeliveryDetailsVC: BaseViewController,PaymentTableCellDelegate {
    @IBOutlet weak var deliveryDetailsLabel: UILabel!
     @IBOutlet var addAddressButton: UIButton!
    @IBOutlet var dateTextField: UITextField!
     @IBOutlet var promoCodeTextField: UITextField!
    @IBOutlet weak var paymentDetailsLabel: UILabel!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet var toolbar: UIToolbar!
    @IBOutlet var paymentTable: UITableView!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var addressTable: UITableView!
    @IBOutlet var closeButtonHeight: NSLayoutConstraint!
    @IBOutlet var addAddressButtonHeightConstraint: NSLayoutConstraint!
    @IBOutlet var mapViewHeight: NSLayoutConstraint!
    var selectedDate:String = ""
    var selectedIndex: Int = -1
   
    var addressResponseModel:AddressResponseModel?
    var selAddress:Address?
    override func initView() {
        initialisation()
        localization()
        addingLeftBarButton()
        callingGetAddressListApi()
    }
    
    func initialisation(){
         self.title = "Qoot".localiz()
        addressTable.register(UINib(nibName: "AddressTableCell", bundle: nil), forCellReuseIdentifier: "Cell")
        paymentTable.register(UINib(nibName: "PaymentTableCell", bundle: nil), forCellReuseIdentifier: "paymentCell")
        dateTextField.inputAccessoryView = toolbar
        dateTextField.inputView = datePicker
    }
    
    func localization(){
        self.deliveryDetailsLabel.text = "Delivery Details".localiz()
        addAddressButton.setTitle("ADDNEWADDRESS".localiz(), for: UIControlState.normal)
        dateTextField.placeholder = "CHOOSEDATEANDTIME".localiz()
        promoCodeTextField.placeholder = "ENTERPROMOCODE".localiz()
        paymentDetailsLabel.text = "PAYMENTDETAILS".localiz()
        totalLabel.text = "Total".localiz()
        confirmButton.setTitle("Confirm".localiz(), for: UIControlState.normal)
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
    
    //MARK: Login Api
    
    func  callingGetAddressListApi(){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        CartManager().callingGetAddressessApi(with: getAddressRequestBody(), success: {
            (model) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if let model = model as? AddressResponseModel{
               self.addressResponseModel = model
                if model.addresses.count>0{
                    self.selAddress = model.addresses.first
                }
                else{
                    
                }
               self.addressTable.reloadData()
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
    func getAddressRequestBody()->String{
        var dataString:String = ""
        dataString = "CustomerId=2"
        return dataString
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
            if let addressResponse = self.addressResponseModel{
                return addressResponse.addresses.count
            }
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if tableView == paymentTable{
            let payCell = tableView.dequeueReusableCell(withIdentifier: "paymentCell", for: indexPath) as! PaymentTableCell
            payCell.delegate = self
            payCell.tag = indexPath.row
            payCell.paymentTypeLabel.text = PAY_FIELDS[indexPath.row]
            payCell.paymentTypeImageView.image = PAYMENT_TYPE_IMAGES[indexPath.row]
            payCell.setModel(index:indexPath.row,selectedIndex:selectedIndex)
            cell = payCell
        }
        else{
             let addressCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! AddressTableCell
            if let addressResponse = self.addressResponseModel{
                let address = addressResponse.addresses[indexPath.row]
                if address.addressId == self.selAddress?.addressId{
                    addressCell.radioButton.isSelected = true
                }
                else{
                    addressCell.radioButton.isSelected = false
                }
                addressCell.setAddress(address:address)
            }
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
        if tableView == addressTable{
            if let addressResponse = self.addressResponseModel{
                let address = addressResponse.addresses[indexPath.row]
                self.selAddress = address
                addressTable.reloadData()
            }
        }
    }
}
