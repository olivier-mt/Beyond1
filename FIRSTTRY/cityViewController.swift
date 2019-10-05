//
//  cityViewController.swift
//  FIRSTTRY
//
//  Created by Olivier Mountou on 05/10/2019.
//  Copyright © 2019 Olivier Mountou MT. All rights reserved.
//

import UIKit

class cityViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    
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

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
