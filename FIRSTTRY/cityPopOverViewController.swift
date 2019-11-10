//
//  cityPopOverViewController.swift
//  FIRSTTRY
//
//  Created by Olivier Mountou on 10/11/2019.
//  Copyright © 2019 Olivier Mountou MT. All rights reserved.
//

import UIKit

class cityPopOverViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
     @IBOutlet weak var Popupview: UIView!
    
    @IBOutlet weak var tableView: UITableView!

    var names: [String] = ["Mumbai","New York","Tokyo","London","Beijing","Sydney","Wellington","Madrid","Rome","Cape Town","Ottawa"]


    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        // Apply radius to Popupview
        Popupview.layer.cornerRadius = 10
        Popupview.layer.masksToBounds = true
        
    }
    
    
    // Returns count of items in tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.names.count;
    }
    
    
    // Select item from tableView
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("Company Name : " + names[indexPath.row])
        
        Shared.shared.companyName = names[indexPath.row]
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "NewGroupViewController") as! NewGroupViewController
        self.present(newViewController, animated: true, completion: nil)
        
    }
    
    //Assign values for tableView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath)
        
        cell.textLabel?.text = names[indexPath.row]
        
        return cell
    }
    
    // Close PopUp
    @IBAction func closePopup(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
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


