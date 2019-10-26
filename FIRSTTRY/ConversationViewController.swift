//
//  ConversationViewController.swift
//  FIRSTTRY
//
//  Created by Olivier Mountou on 13/10/2019.
//  Copyright © 2019 Olivier Mountou MT. All rights reserved.
//

import UIKit
import Firebase

class ConversationViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate {
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var ConvertationTableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    
    var finalGroup = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
         print("here Is the final group \(finalGroup)")
        tabBarController?.tabBar.isHidden = true
        
        messageTextField.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tableViewTapped)  )
        
        ConvertationTableView.addGestureRecognizer(tapGesture)
    }
    

    @objc func tableViewTapped() {
        self.messageTextField.endEditing(true)
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        
        
        UIView.animate(withDuration: 0.5){
     
    self.heightConstraint.constant = 308
        self.view.layoutIfNeeded()
            
        }
        
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        UIView.animate(withDuration: 0.5){
            
            self.heightConstraint.constant = 50
            self.view.layoutIfNeeded()
            
            
         
            
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
