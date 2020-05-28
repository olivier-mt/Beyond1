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
    
    @IBOutlet weak var returnButton: UIButton!
  
    override func viewDidLoad() {
        super.viewDidLoad()

        
        if #available(iOS 13.0, *) {
               // Always adopt a light interface style.
               overrideUserInterfaceStyle = .light
           }
        
        HideKeyboard()
        
        emailTextField.backgroundColor = UIColor.clear
        emailTextField.layer.borderWidth = 1
        emailTextField.layer.borderColor = UIColor.white.cgColor
        emailTextField.layer.cornerRadius = emailTextField.frame.height / 2
        emailTextField.layer.shadowColor = UIColor.black.cgColor
        emailTextField.layer.shadowRadius = 3
        emailTextField.layer.shadowOpacity = 0.5
        emailTextField.layer.shadowOffset = CGSize(width: 2, height: 2)
        emailTextField.attributedPlaceholder = NSAttributedString(string: "Email address",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        
        sendButton.layer.cornerRadius = emailTextField.frame.height / 2
        sendButton.layer.shadowColor = UIColor.black.cgColor
        sendButton.layer.shadowRadius = 3
        sendButton.layer.shadowOpacity = 0.5
        sendButton.layer.shadowOffset = CGSize(width: 2, height: 2)
               
        
        
        let origImage = UIImage(named: "backarrow")
        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        returnButton.setImage(tintedImage, for: .normal)
        returnButton.tintColor = .white
        returnButton.layer.shadowColor = UIColor.black.cgColor
        returnButton.layer.shadowOpacity = 0.5
        returnButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        
        
        // Do any additional setup after loading the view.
    }
    

    @IBAction func pressSend(_ sender: Any) {
        
        let email = emailTextField.text!
        

    if email == "" {
        
        SPAlert.present(message: "email required")
        
    }
    
    else {
        
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if error != nil {
                
                SPAlert.present(message: "wrong email adresse")
                
            }
                
            else{
                
                SPAlert.present(message: "email sent!")

                self.performSegue(withIdentifier: "resetToLogin", sender: self)
                
            }
        
        
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
