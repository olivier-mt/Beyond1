//
//  fgroupDataModel.swift
//  FIRSTTRY
//
//  Created by Olivier Mountou on 28/12/2019.
//  Copyright © 2019 Olivier Mountou MT. All rights reserved.
//

import Foundation
import Firebase

protocol DocumentSerializables {
    init?(dictionary:[String:Any])
}

struct fGroup {

    var name : String
    var documentID: String
    
    var dictionary : [String: Any]{
        return [
    
            "name" : name,
            "documentID" : documentID
        ]
    }
}

extension fGroup : DocumentSerializables {
    init?(dictionary: [String : Any]) {
        guard let name = dictionary["name"] as? String,
            
            let documentID = dictionary["documentID"] as? String else {return nil}
        
        
        self.init( name: name, documentID: documentID )
    }
}
