//
//  cityViewController.swift
//  FIRSTTRY
//
//  Created by Olivier Mountou on 05/10/2019.
//  Copyright © 2019 Olivier Mountou MT. All rights reserved.
//

import UIKit
import Firebase

class cityViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    var city = ""
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let cities = ["Paris","Lyon","London","Berlin","Amsterdam","Dublin","Barcelona","Helsinki"]
    
    let cityImages : [UIImage] = [
        UIImage(named: "paris")!,
        UIImage(named: "lyon")!,
        UIImage(named: "london")!,
        UIImage(named: "berlin")!,
        UIImage(named: "amsterdam")!,
        UIImage(named: "dublin")!,
        UIImage(named: "barcelona")!,
        UIImage(named: "helsinki2")!,
         ]
    let userDefault = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if #available(iOS 13.0, *) {
               // Always adopt a light interface style.
               overrideUserInterfaceStyle = .light
           }
        
        
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let height = view.frame.size.height
        let width = view.frame.size.width
        // in case you you want the cell to be 40% of your controllers view
        return CGSize(width: width * 0.4785, height: height * 0.40)
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


