//
//  SignUpViewController.swift
//  FIRSTTRY
//
//  Created by Olivier Mountou on 21/09/2019.
//  Copyright © 2019 Olivier Mountou MT. All rights reserved.
//

import UIKit
import Firebase


class SignUpViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var UserNameTextfield: UITextField!
    
    var ref: DatabaseReference!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
         ref = Database.database().reference()

    }
    

    
    @IBAction func signupPressed(_ sender: Any) {
        
        let userName = UserNameTextfield.text

        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = userName
        changeRequest?.commitChanges{
            error in
            if error == nil {
                print("User display name change!")
                
            }
        }
        
        
        
        Auth.auth().createUser(withEmail: email.text! , password: password.text!) { (user, error) in
            if error != nil {
                print (error!)
            } else {
    
                
                let user = Auth.auth().currentUser
                if let user = user {
                    // The user's ID, unique to the Firebase project.
                    // Do NOT use this value to authenticate with your backend server,
                    // if you have one. Use getTokenWithCompletion:completion: instead.
                    let uid = user.uid
                    let email = user.email
                    let name = user.displayName
                    
                    self.ref.child("users").child(user.uid).setValue(
                    ["name": name,
                     "email": email,
                     "uid": uid]) {
                        (error:Error?, ref:DatabaseReference) in
                        if let error = error {
                            print("Data could not be saved: \(error).")
                        } else {
                            print("Data saved successfully!")
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
