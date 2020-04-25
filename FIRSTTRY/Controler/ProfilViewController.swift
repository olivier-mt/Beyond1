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
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        userNameTextField.delegate = self
        
        currentNameLabel.text = (Auth.auth().currentUser!.displayName as! String)

        self.title = "Profil settings"
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        currentNameLabel.text = (Auth.auth().currentUser!.displayName as! String)
        self.title = "Profil settings"
        
        self.HidenKeyboard()

    }
    
    
    @IBAction func saveProfilTapped(_ sender: Any) {
        
     let username = userNameTextField.text
        
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = username
        currentNameLabel.text = username
        
        
        SPAlert.present(title: "Username changed succefully!", preset: .done)
        changeRequest?.commitChanges { (error) in
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
