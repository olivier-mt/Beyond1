//
//  LogInViewController.swift
//  FIRSTTRY
//
//  Created by Olivier Mountou on 21/09/2019.
//  Copyright © 2019 Olivier Mountou MT. All rights reserved.
//

import UIKit
import Firebase
import SPAlert

class LogInViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    // SAVE EMAIL AND PASSWORD
    let userDefault = UserDefaults.standard

                 
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func logInButton(_ sender: Any) {
      
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if error != nil {
                print (error!)
                SPAlert.present(title: "Email or Password error", preset: .error)

            } else {
                print("sign in successful")

                //STAY LOGGED IN
                self.userDefault.set(true, forKey: "usersignedin")
                self.userDefault.synchronize()
                
                
                self.performSegue(withIdentifier: "loginToTab" , sender: self)
            }
        }
        
    }
    
    
    
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    guard let identifier = segue.identifier else {
              assertionFailure("Segue had no idientifier")
              return
          }
    
    
    if identifier == "loginToTab" {
        
        let barViewControllers = segue.destination as! UITabBarController
        let nav = barViewControllers.viewControllers![2] as! UINavigationController
        
        
    }
    
    else if identifier == "toPasswordLost" {
        
        let resetVc = segue.destination as! resetPasswordViewController
        
    }

    else if identifier == "loginToFirstScreen" {
        
        let firstScreen = segue.destination as! ViewController
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
    


