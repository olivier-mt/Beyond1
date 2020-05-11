//
//  SignUpViewController.swift
//  FIRSTTRY
//
//  Created by Olivier Mountou on 21/09/2019.
//  Copyright © 2019 Olivier Mountou MT. All rights reserved.
//

import UIKit
import Firebase
import SPAlert


class SignUpViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var UserNameTextfield: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
   
    var ref: DatabaseReference!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
         ref = Database.database().reference()
        
        
        signUpButton.layer.cornerRadius = signUpButton.frame.height / 2
        signUpButton.layer.shadowColor = UIColor.black.cgColor
        signUpButton.layer.shadowRadius = 3
        signUpButton.layer.shadowOpacity = 0.5
        signUpButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        
        
        
        email.backgroundColor = UIColor.clear
        email.layer.borderWidth = 1
        email.layer.borderColor = UIColor.white.cgColor
        email.layer.cornerRadius = email.frame.height / 2
        email.layer.shadowColor = UIColor.black.cgColor
        email.layer.shadowRadius = 3
        email.layer.shadowOpacity = 0.5
        email.layer.shadowOffset = CGSize(width: 2, height: 2)
        email.attributedPlaceholder = NSAttributedString(string: "Email address",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        password.backgroundColor = UIColor.clear
        password.layer.borderWidth = 1
        password.layer.borderColor = UIColor.white.cgColor
        password.layer.cornerRadius = email.frame.height / 2
        password.layer.shadowColor = UIColor.black.cgColor
        password.layer.shadowRadius = 3
        password.layer.shadowOpacity = 0.5
        password.layer.shadowOffset = CGSize(width: 2, height: 2)
        password.attributedPlaceholder = NSAttributedString(string: "New Password",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        UserNameTextfield.backgroundColor = UIColor.clear
        UserNameTextfield.layer.borderWidth = 1
        UserNameTextfield.layer.borderColor = UIColor.white.cgColor
        UserNameTextfield.layer.cornerRadius = email.frame.height / 2
        UserNameTextfield.layer.shadowColor = UIColor.black.cgColor
        UserNameTextfield.layer.shadowRadius = 3
        UserNameTextfield.layer.shadowOpacity = 0.5
        UserNameTextfield.layer.shadowOffset = CGSize(width: 2, height: 2)
        UserNameTextfield.attributedPlaceholder = NSAttributedString(string: "New Username",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        
        
        
        
        
        
        
        
        
        
        
        
        
       

    }
    

    
    @IBAction func signupPressed(_ sender: Any) {
        
        let userName = UserNameTextfield.text

        
        Auth.auth().createUser(withEmail: email.text! , password: password.text!) { (user, error) in
            if error != nil {
                
                SPAlert.present(message: "Email or Password invalid")

                print (error!)
            } else {
    
                let user = Auth.auth().currentUser
                
                if let user = user {
                    // The user's ID, unique to the Firebase project.
                    // Do NOT use this value to authenticate with your backend server,
                    // if you have one. Use getTokenWithCompletion:completion: instead.
                    let uid = user.uid
                    let email = user.email
                    let name = userName
                    
                    self.ref.child("users").child(user.uid).setValue(
                    ["name": name,
                     "email": email,
                     "uid": uid]) {
                        (error:Error?, ref:DatabaseReference) in
                        if let error = error {
                            
                            
                            print("Data could not be saved: \(error).")
                        } else {
                            let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                            changeRequest?.displayName = userName
                            changeRequest?.commitChanges { (error) in
                            }
                            print("Data saved successfully! \(String(describing: user.displayName))")
            
                        }
                    }
                    
                print("registration successful")
                
                self.performSegue(withIdentifier: "signinToTab" , sender: self)
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
}
