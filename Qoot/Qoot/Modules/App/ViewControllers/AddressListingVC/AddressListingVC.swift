//
//  AddressListingVC.swift
//  Qoot
//
//  Created by Bibin Mathew on 10/20/18.
//  Copyright © 2018 Cl. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class AddressListingVC: BaseViewController, GMSMapViewDelegate {
    
    @IBOutlet weak var deliveryDetailsLabel: UILabel!
    @IBOutlet var addAddressButton: UIButton!
    
    
    @IBOutlet var addressTable: UITableView!
    @IBOutlet var closeButtonHeight: NSLayoutConstraint!
    @IBOutlet var addAddressButtonHeightConstraint: NSLayoutConstraint!
    @IBOutlet var mapViewHeight: NSLayoutConstraint!
    @IBOutlet weak var mapView: GMSMapView!
    var locationMarker:GMSMarker!
    
    @IBOutlet weak var cityNameTF: UITextField!
    @IBOutlet weak var addressTF: UITextField!
    @IBOutlet weak var landmarkTF: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var mapBackView: UIView!
    
    var selectedIndex: Int = -1
    let locationMgr = CLLocationManager()
    var userLocLatitude = 0.000000
    var userLocLongitude = 0.00000
    var commentString:String?
    var totalAmount:Double?
    
    var addressResponseModel:AddressResponseModel?
    var selAddress:Address?
    var camera: GMSCameraPosition = GMSCameraPosition.camera(withLatitude: 10.0068361, longitude: 76.3655878, zoom: 17.5)
    var addAddressResponseModel:AddAddressResponseModel?
    var isEditingMode = false
    var selIndex = -1

    override func initView(){
        initialisation()
       localisation()
        getLocation()
        callingGetAddressListApi()
    }
    
    func initialisation(){
        addingLeftBarButton()
        addressTable.register(UINib(nibName: "AddressTableCell", bundle: nil), forCellReuseIdentifier: "Cell")
        localisation()
    }
    
    func localisation(){
        self.title = "Qoot".localiz()
        self.deliveryDetailsLabel.text = "Delivery Details".localiz()
        addAddressButton.setTitle("ADDNEWADDRESS".localiz(), for: UIControlState.normal)
        cityNameTF.placeholder = "City".localiz()
        addressTF.placeholder = "Address".localiz()
        landmarkTF.placeholder = "Landmark".localiz()
        addButton.setTitle("Add".localiz(), for: UIControlState.normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addButtonAction(_ sender: UIButton) {
        if isValidAddressDetails(){
            if isEditing{
              callingEditAddressApi(tag: self.selIndex)
            }
            else{
                callingAddAddressApi()
            }
        }
    }
    
    @IBAction func closeButtonAction(_ sender: UIButton) {
        mapBackView.isHidden = true
        mapViewHeight.constant = 0
        closeButtonHeight.constant = 0
        addAddressButtonHeightConstraint.constant = 40
    }
    
    @IBAction func addAddressButtonAction(_ sender: UIButton) {
        closeButtonHeight.constant = 30
        addAddressButtonHeightConstraint.constant = 0
        mapViewHeight.constant = 220
        mapBackView.isHidden = false
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
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

}

extension AddressListingVC : UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let addressResponse = self.addressResponseModel{
            return addressResponse.addresses.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
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
        addressCell.tag = indexPath.row
        addressCell.delegate = self
        return addressCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
            return 90
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

extension AddressListingVC:CLLocationManagerDelegate{
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

extension AddressListingVC:AddressCellDelegate{
    func editButtonDelegateAction(with tag: Int) {
        self.isEditing = true
        closeButtonHeight.constant = 30
        addAddressButtonHeightConstraint.constant = 0
        mapViewHeight.constant = 220
        mapBackView.isHidden = false
        self.selIndex = tag
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
    
    //MARK: Edit Address Api
    
    func  callingEditAddressApi(tag:Int){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        CartManager().callingEditCustomerAddressApi(with: getEditAddressRequestBody(index: tag), success: {
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
    func getEditAddressRequestBody(index:Int)->String{
        var dataString:String = ""
        if let addressList = self.addressResponseModel{
            let address = addressList.addresses[index]
            let addressIdString:String = "AddressId=\(address.addressId)"
            dataString = dataString + addressIdString
        }
        return dataString
    }
}
