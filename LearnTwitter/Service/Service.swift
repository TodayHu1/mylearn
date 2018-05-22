//
//  Service.swift
//  LearnTwitter
//
//  Created by Naihe Hu on 2018/5/21.
//  Copyright © 2018年 Naihe Hu. All rights reserved.
//

import Foundation
import TRON
import SwiftyJSON

struct Service {
    
    let tron = TRON(baseURL:"https://api.letsbuildthatapp.com")
    
    static let sharedInstance = Service()
    
    func fetchHomeFeed(completion:@escaping (HomeDatasource?,Error?) -> ()) {
        
        let request:APIRequest<HomeDatasource,JSONError> = tron.swiftyJSON.request("/twitter/home")
        
        request.perform(withSuccess:{(homeDatasource) in
//            print("Successfully fetched our json objects")
//            print(homeDatasource.users.count)            
            completion(homeDatasource,nil)
        }){ (err) in
            completion(nil, err)
            print("Failed to fetch json...",err)
        }
        
        //print("Fetching home food")
    }
    
    class JSONError:JSONDecodable {
        
        required init(json:JSON) throws {
            print("JSON ERROR")
        }
    }
    
}


