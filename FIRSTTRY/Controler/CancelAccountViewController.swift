//
//  CancelAccountViewController.swift
//  FIRSTTRY
//
//  Created by Olivier Mountou on 19/03/2020.
//  Copyright © 2020 Olivier Mountou MT. All rights reserved.
//

import UIKit
import Firebase

class CancelAccountViewController: UIViewController {

    var user = Auth.auth().currentUser;
     


    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        

        // Do any additional setup after loading the view.
    }
    
    
    func cancel(){
        user?.delete { error in
      if let error = error {
        // An error happened.
      } else {
        // Account deleted.
      }
    } }
    
    func resignin(){
        
       

        
       
        
    }
    
    
    @IBAction func cancelPress(_ sender: Any) {
        
        let email = self.emailTextField.text!
        let password = self.passwordTextField.text!
        var credential: AuthCredential

        credential = EmailAuthProvider.credential(withEmail: email, password: password)
        
        
               let user = Auth.auth().currentUser
        
        user?.reauthenticate(with: credential)

        let uid = Auth.auth().currentUser

        cancel()
        
        UserDefaults.standard.removeObject(forKey: "usersignedin")
                   
                   self.dismiss(animated: true, completion: nil)
        
        

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
