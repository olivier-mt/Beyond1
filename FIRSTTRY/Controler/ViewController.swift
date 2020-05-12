//
//  ViewController.swift
//  FIRSTTRY
//
//  Created by Olivier Mountou on 21/09/2019.
//  Copyright © 2019 Olivier Mountou MT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var logInButton: UIButton!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    
    
    let userDefault = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        logInButton.layer.cornerRadius = logInButton.frame.height / 2
        logInButton.layer.shadowColor = UIColor.black.cgColor
        logInButton.layer.shadowRadius = 0.5
        logInButton.layer.shadowOpacity = 0.3
        logInButton.layer.shadowOffset = CGSize(width: 1, height: 1)
        
        
        
        
        
        
        
        
        signUpButton.layer.cornerRadius = logInButton.frame.height / 2
        signUpButton.layer.shadowColor = UIColor.black.cgColor
               signUpButton.layer.shadowRadius = 1.5
               signUpButton.layer.shadowOpacity = 0.5
               signUpButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        // Do any additional setup after loading the view.
    }
  
    // LOGGED IN 
    
    override func viewDidAppear(_ animated: Bool) {
        
        if userDefault.bool(forKey: "usersignedin") {
                   performSegue(withIdentifier: "firstToTab", sender: self)
                   }
        else {}
    
}
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }


}
