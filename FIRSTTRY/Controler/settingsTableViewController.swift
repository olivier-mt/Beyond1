//
//  settingsTableViewController.swift
//  FIRSTTRY
//
//  Created by Olivier Mountou on 14/04/2020.
//  Copyright © 2020 Olivier Mountou MT. All rights reserved.
//

import UIKit
import Firebase

class settingsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        if #available(iOS 13.0, *) {
               // Always adopt a light interface style.
               overrideUserInterfaceStyle = .light
           }
        
        
        
        var db : Firestore!

           
           
      
        
       
        
        checkIfSignedIn()
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func viewDidAppear(_ animated: Bool) {

        
      
    }
    
    var id = Auth.auth().currentUser

    private func checkIfSignedIn() {
               if Auth.auth().currentUser != nil {
                  // code to stay signed in
               }else{
                  // redirect to sign in page
                
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                           let nextViewController = storyBoard.instantiateViewController(withIdentifier: "LOGINOUT") as! ViewController
                                self.show(nextViewController, sender: (Any).self)
                
               }
            }
    
    
 
    
    
    

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
