//
//  NewGroupViewController.swift
//  FIRSTTRY
//
//  Created by Olivier Mountou on 05/11/2019.
//  Copyright © 2019 Olivier Mountou MT. All rights reserved.
//

import UIKit

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
    
    
    
    @IBOutlet weak var btnSelect: UIButton!

    @IBOutlet weak var groupNameTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Creat a new group"
        
    descriptionTextView.delegate = self
    groupNameTextField.delegate = self
        
    descriptionTextView.text = "Describ the group purpose in few words"
    descriptionTextView.textColor = UIColor.lightGray
        
    self.HideKeyboard()
        
        // Mark : button city
        
        btnSelect.backgroundColor = .clear
        btnSelect.layer.cornerRadius = 5
        btnSelect.layer.borderWidth = 0.5
        btnSelect.layer.borderColor = UIColor.lightGray.cgColor
        
        let cn : String = Shared.shared.companyName ?? "Choose a city"
        btnSelect.setTitle(cn,for: .normal)

       
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
