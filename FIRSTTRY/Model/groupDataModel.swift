//
//  groupDataModel.swift
//  FIRSTTRY
//
//  Created by Olivier Mountou on 10/10/2019.
//  Copyright © 2019 Olivier Mountou MT. All rights reserved.
//

import Foundation
import Firebase

protocol DocumentSerializable {
    init?(dictionary:[String:Any])
}

struct Group {
    var city : String
    var description : String
    var language : String
    var name : String
    var documentID: String
    
    var dictionary : [String: Any]{
        return [
        "city" : city,
        "description" : description,
        "language" : language,
        "name" : name,
        "documentID" : documentID
        ]
    }
}

extension Group : DocumentSerializable {
    init?(dictionary: [String : Any]) {
        guard let name = dictionary["name"] as? String,
              let description = dictionary["description"] as? String,
              let documentID = dictionary["documentID"] as? String,
              let city = dictionary["city"] as? String,
              let language = dictionary["language"] as? String else {return nil}
        
        
        self.init(city: city, description: description, language: language, name: name, documentID: documentID )
    }
}
