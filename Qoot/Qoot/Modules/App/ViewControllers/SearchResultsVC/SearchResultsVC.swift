//
//  SearchResultsVC.swift
//  Qoot
//
//  Created by Bibin Mathew on 8/6/18.
//  Copyright © 2018 Cl. All rights reserved.
//

import UIKit

class SearchResultsVC: BaseViewController {
    @IBOutlet weak var searchResultsTV: UITableView!
    var kitchensResponseModel:KitchensResponseModel?
    
    override func initView() {
        super.initView()
        initialisation()
        localisation()
    }
    
    func initialisation(){
       self.title = "Qoot".localiz()
       addingLeftBarButton()
      addCartIconOnly()
      addHomeIconAndCartIcon()
        searchResultsTV.register(UINib.init(nibName: "SearchResultsTVC", bundle: nil), forCellReuseIdentifier: "searchResults")
    }
    func localisation(){
    
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

extension SearchResultsVC : UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let kitchenResponse = self.kitchensResponseModel {
            return kitchenResponse.viewKitchens.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchResults", for: indexPath) as!SearchResultsTVC
        cell.tag = indexPath.row
        if let kitchenResponse = self.kitchensResponseModel {
            cell.setKitchen(kitchen: kitchenResponse.viewKitchens[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let searchDetailVC = SearchDetailVC.init(nibName: "SearchDetailVC", bundle: nil)
        if let kitchenResponse = self.kitchensResponseModel {
            searchDetailVC.kitchenResponse = kitchenResponse.viewKitchens[indexPath.row]
        }
        self.navigationController?.pushViewController(searchDetailVC, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let rowHieght = 100
        return CGFloat(rowHieght)
    }
    
}
