//
//  fCell.swift
//  FIRSTTRY
//
//  Created by Olivier Mountou on 31/12/2019.
//  Copyright © 2019 Olivier Mountou MT. All rights reserved.
//

import UIKit

class fCell: UITableViewCell {

    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var id: UILabel!
    
    @IBOutlet weak var describ: UILabel!
    
    @IBOutlet weak var city: UILabel!
    
    @IBOutlet weak var language: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
