//
//  NotificationsVC.swift
//  Qoot
//
//  Created by Bibin Mathew on 11/24/18.
//  Copyright © 2018 Cl. All rights reserved.
//

import UIKit

class NotificationsVC: BaseViewController {

    @IBOutlet weak var notificationsTableView: UITableView!
    var notificationsResponseModel:NotificationsResponseModel?
    override func initView() {
        super.initView()
        initialisation()
        localisation()
        callingNotificationsApi()
    }
    
    func initialisation(){
        addingLeftBarButton()
        notificationsTableView.register(UINib(nibName: "NotificationsCell", bundle: nil), forCellReuseIdentifier: "notificationCell")
        self.notificationsTableView.estimatedRowHeight = 80
        self.notificationsTableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func localisation(){
        self.title = "Notifications".localiz()
    }
    
    func callingNotificationsApi(){
        UserManager().callingNotificationsApi(with: getNotificationsRequestBody(), success: { (model) in
            if let model = model as? NotificationsResponseModel{
                self.notificationsResponseModel = model
                self.notificationsTableView.reloadData()
            }
            
        }) { (error) in
            
        }
    }
    
    func getNotificationsRequestBody()->String{
        var dataString:String = ""
        if let user = User.getUser(){
            dataString = "CustomerId=\(user.userId)"
        }
        return dataString
    }
    
    
    override func leftNavButtonAction() {
        self.dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension NotificationsVC : UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let notResponse = self.notificationsResponseModel{
            return notResponse.notifications.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let notificationCell = tableView.dequeueReusableCell(withIdentifier: "notificationCell", for: indexPath) as! NotificationsCell
        if let notResponse = self.notificationsResponseModel{
            let notificn = notResponse.notifications[indexPath.row]
            notificationCell.setNotification(not:notificn)
        }
        notificationCell.tag = indexPath.row
        return notificationCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

