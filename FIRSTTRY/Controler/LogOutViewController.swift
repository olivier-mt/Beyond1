//
//  LogOutViewController.swift
//  FIRSTTRY
//
//  Created by Olivier Mountou on 19/03/2020.
//  Copyright © 2020 Olivier Mountou MT. All rights reserved.
//

import UIKit
import Firebase


class LogOutViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        if #available(iOS 13.0, *) {
               // Always adopt a light interface style.
               overrideUserInterfaceStyle = .light
           }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func logOutButton(_ sender: Any) {
        
        do
        {
           UserDefaults.standard.removeObject(forKey: "usersignedin")
            
            

             try Auth.auth().signOut()
            
         // GO BACK TO FIRST SCREEN

     let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
     let nextViewController = storyBoard.instantiateViewController(withIdentifier: "LOGINOUT") as! ViewController
            self.show(nextViewController, sender:(Any).self)
    

        }
        catch let error as NSError
        {
            print (error.localizedDescription)
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
