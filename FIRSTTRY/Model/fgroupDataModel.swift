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
    var city : String
    var language : String
    var description : String



    
    var dictionary : [String: Any]{
        return [
    
            "name" : name,
            "documentID" : documentID,
            "city" : city,
            "language" : language,
            "description" : description
        ]
    }
}

extension fGroup : DocumentSerializables {
    init?(dictionary: [String : Any]) {
        guard let name = dictionary["name"] as? String,
            
            let documentID = dictionary["documentID"] as? String,
            let city = dictionary["city"] as? String,
            let language = dictionary["language"] as? String,
            let description = dictionary["description"] as? String

            else {return nil}
        
        
        self.init( name: name, documentID: documentID, city: city, language: language, description: description )
    }
}
