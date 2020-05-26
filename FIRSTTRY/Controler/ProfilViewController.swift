//
//  ProfilViewController.swift
//  FIRSTTRY
//
//  Created by Olivier Mountou on 29/12/2019.
//  Copyright © 2019 Olivier Mountou MT. All rights reserved.
//

import UIKit
import Firebase
import SPAlert

extension UIViewController{
    
    func HidenKeyboard(){
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DismissedKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    @objc func DismissedKeyboard() {
        
        view.endEditing(true)
    }
    
}



class ProfilViewController: UIViewController, UITextFieldDelegate{

 
    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var currentNameLabel: UILabel!
    
    
    @IBOutlet weak var saveButton: UIButton!
    
    var db : Firestore!
    
    var usernameString = "Username changed succefully!"
    
    var profilTitle = "Profile"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userNameTextField.delegate = self
        
        currentNameLabel.text = (Auth.auth().currentUser!.displayName as! String)

        
        saveButton.layer.cornerRadius = 5
        saveButton.layer.borderWidth = 2
        saveButton.layer.borderColor = UIColor.lightGray.cgColor
        
        self.title = "Profil settings"
        // Do any additional setup after loading the view.
        setupTranslation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        currentNameLabel.text = (Auth.auth().currentUser!.displayName as! String)
        self.title = profilTitle
        
        self.HidenKeyboard()

    }
    
    
    @IBAction func saveProfilTapped(_ sender: Any) {
        
     let username = userNameTextField.text
        
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = username
        currentNameLabel.text = username
        
        
        
        SPAlert.present(message: usernameString)
        changeRequest?.commitChanges { (error) in
        }
        
        
    }
    
    
    
     func setupTranslation(){
        
      usernameString = NSLocalizedString("Username changed succefully!", comment: "changedUsername")
        
       profilTitle = NSLocalizedString("Profile", comment: "Profile")
            
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
