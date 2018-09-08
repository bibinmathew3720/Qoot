//
//  CartVC.swift
//  Qoot
//
//  Created by Vishnu KM on 06/08/18.
//  Copyright © 2018 Cl. All rights reserved.
//

import UIKit
import GrowingTextView

class CartVC: BaseViewController,CartTableCellDelegate,UIGestureRecognizerDelegate{
    @IBOutlet weak var yourCartLabel: UILabel!
    @IBOutlet weak var deliveryFeeLabel: UILabel!
    @IBOutlet weak var subTotalLabel: UILabel!
    @IBOutlet var commentsTextView: GrowingTextView!
    @IBOutlet weak var proceedToCheckOutButton: UIButton!
    
    @IBOutlet weak var deliveryFeePriceLabel: UILabel!
    @IBOutlet weak var subTotalPriceLabel: UILabel!
    @IBOutlet weak var noCartItemsLabel: UILabel!
    
    
    @IBOutlet var cartTable: UITableView!
    var commentsTextViewPlaceholder:String?
    var cartList:[Cart]?
    var deliveryFee:Double = 20.0
    var totalAmount:Double = 10
    override func initView() {
        super.initView()
        initialisation()
        localization()
        addingLeftBarButton()
        addingHomeBarButton()
        populateCartList()
    }
    
    func populateCartList(){
        cartList = Cart.getAllCartItems()
        cartTable.reloadData()
        if cartList?.count == 0{
            deliveryFee = 0.0
            noCartItemsLabel.isHidden = false
        }
        else{
            deliveryFee = 20.0
            noCartItemsLabel.isHidden = true
        }
        self.deliveryFeePriceLabel.text = "SAR".localiz() + " \(deliveryFee)"  + "/-"
        totalAmount = Cart.calculateCartAmount() + deliveryFee
        self.subTotalPriceLabel.text = "SAR".localiz() + " \(totalAmount)" + "/-"
    }
    
    func initialisation(){
        self.title = "Qoot".localiz()
        commentsTextViewPlaceholder = "Comments if any".localiz()
        commentsTextView.text = commentsTextViewPlaceholder
        tableInitialisation()
        commentsTextView.textColor = UIColor.lightGray
        commentsTextView.maxHeight = 100
        commentsTextView.layer.borderWidth = 1.0
        commentsTextView.layer.borderColor = UIColor.black.cgColor
    }
    
    func localization(){
        yourCartLabel.text = "Your Cart".localiz()
        deliveryFeeLabel.text = "Delivery Fee".localiz()
        subTotalLabel.text = "Sub Total".localiz()
        proceedToCheckOutButton.setTitle("PROCEEDTOCHECKOUT".localiz(), for: UIControlState.normal)
        noCartItemsLabel.text = "YourCartIsEmpty".localiz()
    }

    func tableInitialisation(){
        cartTable.register(UINib(nibName: "CartTableCell", bundle: nil), forCellReuseIdentifier: "Cell")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func plusButtonActionDelegate(with tag: Int) {
        if let carList = self.cartList{
            let cartItem = carList[tag]
            Cart.incrementCartItemCount(cartItem: cartItem)
        }
        populateCartList()
    }
    
    func minusButtonActionDelegate(with tag: Int) {
        if let carList = self.cartList{
            let cartItem = carList[tag]
            Cart.decrementCartItemCount(cartItem: cartItem)
        }
        populateCartList()
    }
    
    func closeButtonActionDelegate(with tag: Int) {
        if let carList = self.cartList{
            let cartItem = carList[tag]
            Cart.deletCartItem(cartItem: cartItem)
        }
        populateCartList()
    }
    
    override func leftNavButtonAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func homeButtonAction() {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func proceedToCheckoutAction(_ sender: UIButton) {
        let delivertDetailVC = DeliveryDetailsVC.init(nibName: "DeliveryDetailsVC", bundle: nil)
        self.navigationController?.pushViewController(delivertDetailVC, animated: true)
    }
    
    @IBAction func tapAction(_ sender: Any) {
        view.endEditing(true)
       
    }
}
extension CartVC : UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let carList = self.cartList{
            return carList.count
        }
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CartTableCell
        cell.delegate = self
        cell.tag = indexPath.row
        if let carList = self.cartList{
            cell.setCartModel(cart:carList[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
extension CartVC: UITextViewDelegate {

    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = commentsTextViewPlaceholder
            textView.textColor = UIColor.lightGray
        }
    }
}
