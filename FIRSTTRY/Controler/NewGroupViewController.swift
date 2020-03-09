//
//  NewGroupViewController.swift
//  FIRSTTRY
//
//  Created by Olivier Mountou on 05/11/2019.
//  Copyright © 2019 Olivier Mountou MT. All rights reserved.
//

import UIKit
import Firebase
import SPAlert


extension UIViewController{
    
    func HideKeyboard(){
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    @objc func DismissKeyboard() {
        
        view.endEditing(true)
    }
    
}




class NewGroupViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var groupNameTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var cityLabel: UILabel!
    
    
    @IBOutlet weak var languageTextField: UITextField!
    
    @IBOutlet weak var creationButton: UIButton!
    
    
    
    var city = ""
    var db : Firestore!

  
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Creat a new group"
       
        cityLabel.text = city
        
    descriptionTextView.delegate = self
    groupNameTextField.delegate = self
        
    descriptionTextView.text = "Describ the group purpose in few words"
    descriptionTextView.textColor = UIColor.lightGray
        
    self.HideKeyboard()
        
        db = Firestore.firestore()
    
    }
    
    
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if descriptionTextView.textColor == UIColor.lightGray {
            descriptionTextView.text = nil
            descriptionTextView.textColor = UIColor.black
        }
        
        func textViewDidEndEditing(_ textView: UITextView) {
            if descriptionTextView.text.isEmpty {
                descriptionTextView.text = "Describ the group purpose in few words"
                descriptionTextView.textColor = UIColor.lightGray
            }
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            groupNameTextField.resignFirstResponder()
            return true
        }
        
        
        
        
    }
    
    @IBAction func languageChosenTextField(_ sender: Any) {
    }
    
    @IBAction func creatGroupTapped(_ sender: Any) {
        
         let descritption = descriptionTextView.text
        let name = groupNameTextField.text
        let language = languageTextField.text
        
        let newGroupRef = db.collection("GROUPS").document()
        let documentID = newGroupRef.documentID
       
        
        if name == "" ||
           descritption == "" ||
            language == ""
             { //let err = err
                print("Error adding document")
                SPAlert.present(message: "All field have to be fullfielded")
        } else {
            newGroupRef.setData([
                       "city" : city,
                       "description" : descritption as Any,
                       "language" : language as Any,
                       "name" : name as Any,
                       "documentID" : documentID
                       
                   ])
            SPAlert.present(title: "Your group is created!", preset: .done)
            navigationController?.popViewController(animated: true)

            print("Document added with ID: \(newGroupRef.documentID)")
            
        }

    }

}
    
    /*// MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */



