//
//  resetPasswordViewController.swift
//  FIRSTTRY
//
//  Created by Olivier Mountou on 17/03/2020.
//  Copyright © 2020 Olivier Mountou MT. All rights reserved.
//

import UIKit
import Firebase
import SPAlert

class resetPasswordViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func pressSend(_ sender: Any) {
        
        let email = emailTextField.text!
        

    if email == "" {
        
        SPAlert.present(message: "email required")
        
    }
    
    else {
        
        Auth.auth().sendPasswordReset(withEmail: email) { error in
        
        SPAlert.present(title: "Link sent!", preset: .done)

    }
    
    
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

}
