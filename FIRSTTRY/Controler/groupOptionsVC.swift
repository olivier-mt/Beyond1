//
//  groupOptionsVC.swift
//  FIRSTTRY
//
//  Created by Olivier Mountou on 07/05/2020.
//  Copyright © 2020 Olivier Mountou MT. All rights reserved.
//

import UIKit
import Firebase
import SPAlert


class groupOptionsVC: UIViewController {

    
    @IBOutlet weak var groupImage: UIImageView!
    
    
    @IBOutlet weak var groupNameLabel: UILabel!
    
    
    @IBOutlet weak var notifButton: UIButton!
    
    
    
    var groupName = ""
    var groupID = ""
    var storageRef = Storage.storage()

    
    
    
    
    
                                        
                                        
                                        
                                        
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        groupImage.layer.cornerRadius = groupImage.bounds.height / 2
              groupImage.clipsToBounds = true
        
        
        groupNameLabel.text = groupName
        
        
        
        notifButton.contentMode = .center
        notifButton.imageView?.contentMode = .scaleAspectFit
        notifButton.layer.cornerRadius = notifButton.bounds.height / 2

        
        let imagePath = storageRef.reference(withPath:"\(groupID)/resizes/profilImage_300x300.jpg")
         
        let image =  imagePath.getData(maxSize: 10 * 1024 * 1024) { (data, error) in
            if let error = error {
                print("Got an error fetching data : \(error.localizedDescription)")
                        return
                                          }
                    if let data = data {
                                              
                self.groupImage.image = UIImage(data: data)
        
        
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
    
    @IBAction func notifButtonTap(_ sender: Any) {
        
        
        
        
        Messaging.messaging().unsubscribe(fromTopic: self.groupID) { err in
            if let err = err {
                
                SPAlert.present(message: "subscribe")
                
            }
            
            else {
                
                SPAlert.present(message: "UNsubscribe")
                
                  print("unsubscribed from \(self.groupID) topic")
            }
            
            
        }
        
        
        
        
    }
    
    
}
