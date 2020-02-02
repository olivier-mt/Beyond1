//
//  cityViewController.swift
//  FIRSTTRY
//
//  Created by Olivier Mountou on 05/10/2019.
//  Copyright © 2019 Olivier Mountou MT. All rights reserved.
//

import UIKit
import Firebase

class cityViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var city = ""
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let cities = ["Paris","Lyon","London","Manchester","Amsterdam","Utrecht","Barcelona","Madrid"]
    
    let cityImages : [UIImage] = [
        UIImage(named: "paris")!,
        UIImage(named: "lyon")!,
        UIImage(named: "london")!,
        UIImage(named: "manchester")!,
        UIImage(named: "amsterdam")!,
        UIImage(named: "utrecht")!,
        UIImage(named: "barcelona")!,
        UIImage(named: "madrid")!,
         ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        

        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cities.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)as! CollectionViewCell
        
        cell.cityLabel.text = cities[indexPath.item]
        cell.cityUIimageView.image = cityImages[indexPath.item]
        
        return cell
        
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderColor = UIColor.gray.cgColor
        cell?.layer.borderWidth = 2
        
        self.city = cities[indexPath.item]
        performSegue(withIdentifier: "toGroupSView", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
        
        var vc = segue.destination as! GroupSViewController
        
        vc.finalCity = self.city
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderColor = UIColor.white.cgColor
    
    }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


