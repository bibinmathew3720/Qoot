//
//  ViewMoreVC.swift
//  DemoPgm
//
//  Created by Vishnu KM on 03/08/18.
//  Copyright © 2018 Vishnu KM. All rights reserved.
//

import UIKit

enum ViewMoreType{
    case Offers
    case ReadyNow
}

class ViewMoreVC: BaseViewController {

    var isFromMenu:Bool?
    var pageType:ViewMoreType?
    @IBOutlet var collectionView: UICollectionView!
    
    override func initView() {
        super.initView()
        initialisation()
        localisation()
        addingLeftBarButton()
    }
    
    func localisation(){
        if pageType == ViewMoreType.Offers{
            self.title = "Offers".localiz()
        }
        else if pageType == ViewMoreType.ReadyNow {
            self.title = "ReadyNow".localiz()
        }
    }
    
    func initialisation(){
        tableInitialisation()
        setUpCollectionView()
    }
    
    func tableInitialisation(){
        collectionView.register(UINib(nibName: "HomeCollectionCell", bundle: nil), forCellWithReuseIdentifier:"homeCollectionCell" )
    }
    func setUpCollectionView(){
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let itemWidth = (UIScreen.main.bounds.width - 30)/2
            layout.itemSize = CGSize(width: itemWidth, height: 130)
        }
       
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Button Actions
    
    override func leftNavButtonAction() {
        if let isMenu = self.isFromMenu{
            self.dismiss(animated: true, completion: nil)
        }
        else{
            self.navigationController?.popViewController(animated: true)
        }
    }
   
}
extension ViewMoreVC:UICollectionViewDataSource,UICollectionViewDelegate{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:HomeCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCollectionCell", for: indexPath) as! HomeCollectionCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewController:ProductDetailVC = ProductDetailVC(nibName: "ProductDetailVC", bundle: nil)
        self.navigationController?.pushViewController(viewController, animated: true)
       
    }
    
}
