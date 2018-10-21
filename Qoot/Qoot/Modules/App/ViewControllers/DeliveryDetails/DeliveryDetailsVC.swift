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
import GoogleMaps
import GooglePlaces

enum PaymentType {
    case cashOnDelivery
    case payPal
    case Visa
    case wallet
}

class DeliveryDetailsVC: BaseViewController,PaymentTableCellDelegate, GMSMapViewDelegate,UIGestureRecognizerDelegate {
    @IBOutlet weak var deliveryDetailsLabel: UILabel!
     @IBOutlet var addAddressButton: UIButton!
    @IBOutlet var dateTextField: UITextField!
     @IBOutlet var promoCodeTextField: UITextField!
    @IBOutlet weak var paymentDetailsLabel: UILabel!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var priceTotalLabel: UILabel!
    
    @IBOutlet var toolbar: UIToolbar!
    @IBOutlet var paymentTable: UITableView!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var addressTable: UITableView!
    @IBOutlet var closeButtonHeight: NSLayoutConstraint!
    @IBOutlet var addAddressButtonHeightConstraint: NSLayoutConstraint!
    @IBOutlet var mapViewHeight: NSLayoutConstraint!
    @IBOutlet weak var mapView: GMSMapView!
    var locationMarker:GMSMarker!
    
    var selectedDate:String?
    var selectedIndex: Int = -1
    let locationMgr = CLLocationManager()
    var userLocLatitude = 0.000000
    var userLocLongitude = 0.00000
    var commentString:String?
    var totalAmount:Double?
   
    var addressResponseModel:AddressResponseModel?
    var addCustomerOrderResponseModel:AddCustomerOrderResponseModel?
    var selAddress:Address?
     var camera: GMSCameraPosition = GMSCameraPosition.camera(withLatitude: 10.0068361, longitude: 76.3655878, zoom: 17.5)
    var addAddressResponseModel:AddAddressResponseModel?
    var selPaymentType:PaymentType?
    
    @IBOutlet weak var cityNameTF: UITextField!
    @IBOutlet weak var addressTF: UITextField!
    @IBOutlet weak var landmarkTF: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var mapBackView: UIView!
    override func initView() {
        initialisation()
        localization()
        addingLeftBarButton()
        callingGetAddressListApi()
        getLocation()
    }
    
    func initialisation(){
         self.title = "Qoot".localiz()
        addressTable.register(UINib(nibName: "AddressTableCell", bundle: nil), forCellReuseIdentifier: "Cell")
        paymentTable.register(UINib(nibName: "PaymentTableCell", bundle: nil), forCellReuseIdentifier: "paymentCell")
        dateTextField.inputAccessoryView = toolbar
        dateTextField.inputView = datePicker
        datePicker.minimumDate = Date()
        if let total = self.totalAmount{
            priceTotalLabel.text = "SAR".localiz() + " \(total)" + "/-"
        }
    }
    
    func localization(){
        self.deliveryDetailsLabel.text = "Delivery Details".localiz()
        addAddressButton.setTitle("ADDNEWADDRESS".localiz(), for: UIControlState.normal)
        dateTextField.placeholder = "CHOOSEDATEANDTIME".localiz()
        promoCodeTextField.placeholder = "ENTERPROMOCODE".localiz()
        paymentDetailsLabel.text = "PAYMENTDETAILS".localiz()
        totalLabel.text = "Total".localiz()
        confirmButton.setTitle("Confirm".localiz(), for: UIControlState.normal)
        cityNameTF.placeholder = "City".localiz()
        addressTF.placeholder = "Address".localiz()
        landmarkTF.placeholder = "Landmark".localiz()
        addButton.setTitle("Add".localiz(), for: UIControlState.normal)
    }
   
    @IBAction func datePickerAction(_ sender: UIDatePicker) {
       
    }
    
    @IBAction func toolbarCancelAction(_ sender: Any) {
        view.endEditing(true)
    }
    @IBAction func toolbarDoneAction(_ sender: Any) {
        self.selectedDate = CCUtility.stringFromDate(date: self.datePicker.date)
        if let seDate = self.selectedDate{
            self.dateTextField.text = seDate
        }
        self.view.endEditing(true)
    }
    @IBAction func tapAction(_ sender: Any) {
          view.endEditing(true)
    }
    
    @IBAction func addAddressButtonAction(_ sender: Any) {
        closeButtonHeight.constant = 30
        addAddressButtonHeightConstraint.constant = 0
        mapViewHeight.constant = 220
        mapBackView.isHidden = false
    }
    
    @IBAction func confirmButtonAction(_ sender: UIButton) {
        if isValidDeliveryDetails(){
            addCustomerOrderApi()
        }
    }
    
    func isValidDeliveryDetails()->Bool{
        var isValid = true
        var messageString = ""
        if let address = self.selAddress{
            if let seDate = self.selectedDate{
                if let payType = self.selPaymentType{
                    
                }
                else{
                    isValid = false
                    messageString = "SPECIFYPAYMENTMETHOD".localiz()
                }
            }
            else{
                isValid = false
                messageString = "PLEASECHOOSEADELIVERYDATEANDTIME".localiz()
            }
        }
        else{
            isValid = false
            messageString = "PLEASECHOOSEADELIVERYADDRESS".localiz()
        }
        if !isValid{
            CCUtility.showDefaultAlertwith(_title: Constant.AppName, _message: messageString, parentController: self)
        }
        return isValid
    }
    
    @IBAction func closeButtonAction(_ sender: Any) {
        mapBackView.isHidden = true
        mapViewHeight.constant = 0
        closeButtonHeight.constant = 0
        addAddressButtonHeightConstraint.constant = 40
    }
    
    @IBAction func addButtonAction(_ sender: UIButton) {
        if isValidAddressDetails(){
            callingAddAddressApi()
        }
    }
    
    func isValidAddressDetails()->Bool{
        var isValid = true
        var messageString = ""
        if let cityNameText = cityNameTF.text{
            if cityNameText.isEmpty{
                isValid = false
                messageString = "CITYNAMEANDHOMEADDRESSEMPTY".localiz()
            }
        }
        if let landmarkText = landmarkTF.text{
            if landmarkText.isEmpty{
                isValid = false
                messageString = "CITYNAMEANDHOMEADDRESSEMPTY".localiz()
            }
        }
        if !isValid{
            CCUtility.showDefaultAlertwith(_title: Constant.AppName, _message: messageString, parentController: self)
        }
        return isValid
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    func paymentButtonDelegateAction(with tag: Int) {
        selectedIndex = tag
        if selectedIndex == 0{
            self.selPaymentType = PaymentType.cashOnDelivery
        }
        else if selectedIndex == 1{
            self.selPaymentType = PaymentType.payPal
        }
        else if selectedIndex == 2{
            self.selPaymentType = PaymentType.Visa
        }
        else if selectedIndex == 3{
            self.selPaymentType = PaymentType.wallet
        }
        paymentTable.reloadData()
    }
    
    // MARK:- Get location
    
    func getLocation() {
        let status  = CLLocationManager.authorizationStatus()
        if status == .notDetermined {
            locationMgr.requestWhenInUseAuthorization()
            //return
        }
        if status == .denied || status == .restricted {
            let alert = UIAlertController(title: "Location Services Disabled", message: "Please enable Location Services in Settings", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            
            present(alert, animated: true, completion: nil)
            return
        }
        locationMgr.delegate = self
        locationMgr.startUpdatingLocation()
    }
    
    //MARK: Get Address Api
    
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
        if let user = User.getUser(){
            dataString = "CustomerId=\(user.userId)"
        }
        return dataString
    }

    
    //MARK: Add Address Api
    
    func  callingAddAddressApi(){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        CartManager().callingAddCustomerAddressApi(with: getAddAddressRequestBody(), success: {
            (model) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if let model = model as? AddAddressResponseModel{
                self.addAddressResponseModel = model
                if model.statusCode == 1 {
                    self.callingGetAddressListApi()
                    self.clearAllAddressFields()
                }
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
    func getAddAddressRequestBody()->String{
        var dataString:String = ""
        if let cityName = self.cityNameTF.text {
            let cityNameString:String = "LocationName=\(cityName.urlEncode())"
            dataString = dataString + cityNameString + "&"
        }
        if let user = User.getUser(){
            dataString = dataString + "CustomerId=\(user.userId)&"
        }
        if let address = self.addressTF.text {
            let addressString:String = "Address=\(address.urlEncode())"
            dataString = dataString + addressString + "&"
        }
        if let landmark = self.landmarkTF.text {
            let landmarkString:String = "Description=\(landmark.urlEncode())" + "&"
            dataString = dataString + landmarkString
        }
        let latAndLongString:String = "GeoCode=\(self.userLocLatitude)" + ",\(self.userLocLongitude)"
        dataString = dataString + latAndLongString
        return dataString
    }
    
    func clearAllAddressFields(){
        self.landmarkTF.text = ""
        self.addressTF.text = ""
        self.cityNameTF.text = ""
        self.mapBackView.isHidden = true
        self.mapViewHeight.constant = 0
    }
    
    //MARK: Add Customer Order Api
    
    func  addCustomerOrderApi(){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        CartManager().addCustomerOrderApi(with: addCustomerOrderRequestBody(), success: {
            (model) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if let model = model as? AddCustomerOrderResponseModel{
                self.addCustomerOrderResponseModel = model
                if model.statusCode == 1 {
                    Cart.deletAllItemsFromCart()
                    self.addOrderConfirmVC()
                }
                else{
                   CCUtility.showDefaultAlertwith(_title: Constant.AppName, _message: model.statusMessage, parentController: self)
                }
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
    func addCustomerOrderRequestBody()->String{
        var dataString:String = ""
        dataString = dataString + "OrderDetails=\(addOrderDetails())"
        return dataString
    }
    func addOrderDetails()->String {
        let array = NSMutableArray()
        var paramDict = [String:String]()
        for item in Cart.getAllCartItems(){
            if let user = User.getUser(){
                paramDict["customerid"] = "\(user.userId)"
            }
            paramDict["menuid"] = "\(item.menuId)"
            paramDict["quantity"] = "\(item.productCount)"
            if let payType = self.selPaymentType{
                if payType == .cashOnDelivery{
                   paramDict["paymenttype"] = "Cash On Delivery"
                }
            }
            if let address = self.selAddress{
                paramDict["addressid"] = "\(address.addressId)"
            }
            if let promo = self.promoCodeTextField.text {
                paramDict["promocode"] = promo
            }
            if let comment = self.commentString {
                paramDict["comment"] = comment
            }
            if let delDate = self.selectedDate{
                paramDict["deliverydate"] = delDate
            }
            array.add(paramDict)
        }
        guard let data = try? JSONSerialization.data(withJSONObject: array, options: []) else {
            return ""
        }
        if let jsonString = String(data: data, encoding: String.Encoding.utf8){
            return jsonString
        }
        return ""
    }
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        var destinationLocation = CLLocation()
  
            destinationLocation = CLLocation(latitude: mapView.camera.target.latitude, longitude: mapView.camera.target.longitude)
            let destinationCoordinate:CLLocationCoordinate2D = destinationLocation.coordinate
            updateLocationoordinates(coordinates: destinationCoordinate)
            
//            userLocLatitude = mapView.camera.target.latitude
//            userLocLongitude = mapView.camera.target.longitude
        
    }
    
    func updateLocationoordinates(coordinates:CLLocationCoordinate2D) {
        userLocLatitude = mapView.camera.target.latitude
        userLocLongitude = mapView.camera.target.longitude
        getLocationInformation(coordinate: coordinates)
        if locationMarker == nil
        {
            locationMarker = GMSMarker()
            let markerImage = UIImage(named: "locationPin")!.withRenderingMode(.alwaysOriginal)
            let markerView = UIImageView(image: markerImage)
            locationMarker.iconView = markerView
            locationMarker.position = coordinates
            locationMarker.map = mapView
            locationMarker.appearAnimation = GMSMarkerAnimation.pop
        }
        else
        {
            CATransaction.begin()
            CATransaction.setAnimationDuration(0.25)
            locationMarker.position =  coordinates
            CATransaction.commit()
        }
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        //getLocationInformation(coordinate: coordinate)
        print(coordinate)
    }
    
    func getLocationInformation(coordinate: CLLocationCoordinate2D){
        // Add below code to get address for touch coordinates.
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            
            // Place details
            var placeMark: CLPlacemark!
            placeMark = placemarks?[0]
            
            // Location name
            if let plceMark = placeMark {
                if let locationName = plceMark.location {
                    print("Location Name:\(locationName)")
                }
                // Street address
                if let street = plceMark.thoroughfare {
                    print(street)
                }
                // City
                if let city = plceMark.subAdministrativeArea {
                    self.cityNameTF.text = city
                    print("City:\(city)")
                }
                // Zip code
                if let zip = plceMark.isoCountryCode {
                    print(zip)
                }
                // Country
                if let country = plceMark.country {
                    print(country)
                }
                
                if let locality = plceMark.locality {
                    self.landmarkTF.text = locality
                }
                if let subLocality = plceMark.subLocality {
                    self.addressTF.text = subLocality
                }
            }
        })
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view?.isDescendant(of: addressTable ))! {
            return false
        }
        return true
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
            addressCell.editButton.isHidden = true
            addressCell.tag = indexPath.row
            addressCell.delegate = self
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
    
    func addOrderConfirmVC(){
       let orderConfirmVC = OrderConfirmVC.init(nibName: "OrderConfirmVC", bundle: nil)
        orderConfirmVC.customerOrderResponse = self.addCustomerOrderResponseModel
        self.navigationController?.pushViewController(orderConfirmVC, animated: true)
    }
}

extension DeliveryDetailsVC:CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currentLocation:CLLocation = locations.last!
        let camera = GMSCameraPosition.camera(withLatitude: (currentLocation.coordinate.latitude), longitude: (currentLocation.coordinate.longitude), zoom: 17.5)
        
        self.mapView?.animate(to: camera)
        locationMgr.stopUpdatingLocation()
        getLocation()
//        let position = currentLocation.coordinate
//        let marker = GMSMarker(position: position)
//        marker.title = "wewl"
//        marker.map = mapView
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    }
    
}

extension DeliveryDetailsVC:AddressCellDelegate{
    func editButtonDelegateAction(with tag: Int) {
    
    }
    
    func closeButtonDelegateAction(with tag: Int) {
        callingRemoveAddressApi(tag: tag)
    }
    
    //MARK: Remove Address Api
    
    func  callingRemoveAddressApi(tag:Int){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        CartManager().callingRemoveCustomerAddressApi(with: getRemoveAddressRequestBody(index: tag), success: {
            (model) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if let model = model as? RemoveAddressResponseModel{
                if model.statusCode == 1 {
                    if let addressList = self.addressResponseModel{
                        let address = addressList.addresses[tag]
                        if let selAdd = self.selAddress{
                            if selAdd.isEqual(address){
                                self.selAddress = nil
                            }
                        }
                        addressList.addresses.remove(at: tag)
                        self.addressTable.reloadData()
                    }
                }
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
    func getRemoveAddressRequestBody(index:Int)->String{
        var dataString:String = ""
        if let addressList = self.addressResponseModel{
            let address = addressList.addresses[index]
            let addressIdString:String = "AddressId=\(address.addressId)"
            dataString = dataString + addressIdString
        }
        return dataString
    }

}
    
   
