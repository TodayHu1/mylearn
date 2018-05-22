//
//  Tweet.swift
//  LearnTwitter
//
//  Created by Naihe Hu on 2018/5/20.
//  Copyright © 2018年 Naihe Hu. All rights reserved.
//

import Foundation
import SwiftyJSON
import TRON

struct Tweet:JSONDecodable {
    let user:User
    let message:String
    
    init(json:JSON) {
        let userJson = json["user"]
        self.user = User(json: userJson)

        self.message = json["message"].stringValue
    }
    
}
