//
//  settingsViewController.swift
//  FIRSTTRY
//
//  Created by Olivier Mountou on 14/04/2020.
//  Copyright © 2020 Olivier Mountou MT. All rights reserved.
//

import UIKit
import Firebase

class settingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

  
        
        if #available(iOS 13.0, *) {
               // Always adopt a light interface style.
               overrideUserInterfaceStyle = .light
           }
        
        // Do any additional setup after loading the view.
    }
    

    
    var db : Firestore!

    var id = Auth.auth().currentUser!.uid
    
    
    func loginCheck(){
        
        if Auth.auth().currentUser == nil {
            self.navigationController?.popToRootViewController(animated: true)

        }
        else {}
        
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
