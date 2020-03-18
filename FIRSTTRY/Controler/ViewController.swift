//
//  ViewController.swift
//  FIRSTTRY
//
//  Created by Olivier Mountou on 21/09/2019.
//  Copyright © 2019 Olivier Mountou MT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let userDefault = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        
        if userDefault.bool(forKey: "usersignedin") {
                   performSegue(withIdentifier: "firstToTab", sender: self)
                   }
    
}


}
