//
//  jsonModel.swift
//  moviee
//
//  Created by Guest on 4/4/19.
//  Copyright © 2019 Guest. All rights reserved.
//

import Foundation
import SwiftyJSON

class jsonModel {
    var actorName : String = ""
    var actorPopularity : Float = 0.0
    var actorPhoto : String = ""
    
    init (){
        
    }
    init(json: JSON){
        actorName = json["name"].stringValue
        actorPopularity = json["popularity"].floatValue
        actorPhoto = json["profile_path"].stringValue
    }
}
