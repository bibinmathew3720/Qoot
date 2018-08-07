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
 
    @IBOutlet var commentsTextView: GrowingTextView!
    @IBOutlet var cartTable: UITableView!
    var count: Int = 1
    var selectedIndex: Int = -1
    
    override func initView() {
        super.initView()
        initialisation()
        addingLeftBarButton()
        addingHomeBarButton()
    }
    
    func initialisation(){
        tableInitialisation()
        commentsTextView.textColor = UIColor.lightGray
        commentsTextView.maxHeight = 100
        commentsTextView.layer.borderWidth = 1.0
        commentsTextView.layer.borderColor = UIColor.black.cgColor
    }

    func tableInitialisation(){
        cartTable.register(UINib(nibName: "CartTableCell", bundle: nil), forCellReuseIdentifier: "Cell")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func plusButtonActionDelegate(with tag: Int) {
        count = count + 1
        selectedIndex = tag
        cartTable.reloadData()
    }
    
    func minusButtonActionDelegate(with tag: Int) {
        if count != 0{
            count = count - 1
        }
        selectedIndex = tag
        cartTable.reloadData()
        
    }
    
    override func leftNavButtonAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func homeButtonAction() {
        self.dismiss(animated: true, completion: nil)
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
        return 3
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CartTableCell
        cell.delegate = self
        cell.tag = indexPath.row
        cell.setCartModel(index: indexPath.row, selectedIndex: selectedIndex, value: String(count))
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
            textView.text = "Comments if any"
            textView.textColor = UIColor.lightGray
        }
    }
}
