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
    
    @IBOutlet weak var logInButton: UIButton!
    // SAVE EMAIL AND PASSWORD
    @IBOutlet weak var returnButton: UIButton!
    
    let userDefault = UserDefaults.standard

                 
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        HideKeyboard()
        
        emailTextField.backgroundColor = UIColor.clear
        
        emailTextField.layer.borderWidth = 1
        emailTextField.layer.borderColor = UIColor.white.cgColor
        
        emailTextField.layer.cornerRadius = emailTextField.frame.height / 2
        emailTextField.layer.shadowColor = UIColor.black.cgColor
        emailTextField.layer.shadowRadius = 3
        emailTextField.layer.shadowOpacity = 0.5
        emailTextField.layer.shadowOffset = CGSize(width: 2, height: 2)
        emailTextField.attributedPlaceholder = NSAttributedString(string: "Email",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        passwordTextField.backgroundColor = UIColor.clear
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.borderColor = UIColor.white.cgColor
        passwordTextField.layer.cornerRadius = emailTextField.frame.height / 2
        passwordTextField.layer.shadowColor = UIColor.black.cgColor
        passwordTextField.layer.shadowRadius = 3
        passwordTextField.layer.shadowOpacity = 0.5
        passwordTextField.layer.shadowOffset = CGSize(width: 2, height: 2)
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        
        logInButton.layer.cornerRadius = emailTextField.frame.height / 2
        logInButton.layer.shadowColor = UIColor.black.cgColor
        logInButton.layer.shadowRadius = 3
        logInButton.layer.shadowOpacity = 0.5
        logInButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        
        
        
        let origImage = UIImage(named: "backarrow")
        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        returnButton.setImage(tintedImage, for: .normal)
        returnButton.tintColor = .white
        returnButton.layer.shadowColor = UIColor.black.cgColor
        returnButton.layer.shadowOpacity = 0.5
        returnButton.layer.shadowOffset = CGSize(width: 2, height: 2)
               
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func logInButton(_ sender: Any) {
      
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if error != nil {
                print (error!)
                SPAlert.present(message: "Email or Password error")
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
    


