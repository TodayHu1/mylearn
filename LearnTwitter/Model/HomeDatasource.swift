//
//  HomeDatasource.swift
//  LearnTwitter
//
//  Created by Naihe Hu on 2018/5/19.
//  Copyright © 2018年 Naihe Hu. All rights reserved.
//

import LBTAComponents
import TRON
import SwiftyJSON

extension Collection where Iterator.Element == JSON {
    func decode<T:JSONDecodable>() throws -> [T] {
        return try map{try T(json:$0)}
    }
}

class HomeDatasource:Datasource,JSONDecodable {
    
//    let users:[User] = {
//        let brianUser = User(name:"Brian Voong",username:"@testtesttest",
//                             bioText:"iPhone,iPad,iOS programing community.iPhone,iPad,iOS programing community.iPhone,iPad,iOS programing community.",profileImage:#imageLiteral(resourceName: "profile_image"))
//        let rayUser = User(name:"Ray Wenderlich",username:"@rwenderlich",
//                           bioText:"Ray Wenderlich is an iPhone developer.iPhone,iPad,iOS programing community.iPhone,iPad,iOS programing  community.iPhone,iPad,iOS programing community.", profileImage: #imageLiteral(resourceName: "ray_profile_image"))
//
//        let kindleCourseUser = User(name: "Kindle Course", username: "@kindleCourse", bioText: "community.iPhone,iPad,iOS programing community.iPhone,iPad,iOS programing community.iPhone,iPad,iOS programing", profileImage: #imageLiteral(resourceName: "profile_image"))
//
//        return [brianUser,rayUser,kindleCourseUser]
//    }()
    
    var users:[User]
    
    required init(json:JSON) throws {
        //            print("Now ready to parse json: \n",json)
        
        guard let usersJsonArray = json["users"].array,let tweetsJsonArray = json["tweets"].array else {
            throw NSError(domain: "com.letsbuildthatapp", code: 1, userInfo: [NSLocalizedDescriptionKey:"Parsing JSON was not valid."])
        }
        
        //let usersJsonArray = json["users"].array
        
        //self.users = usersJsonArray.map{User(json:$0)}
        
//        var users = [User]()
//
//        let array = json["users"].array
//
//        for userJson in array! {
////            let name = userJson["name"].stringValue
////            let username = userJson["username"].stringValue
////            let bio = userJson["bio"].stringValue
////
////            let user = User(name:name,username:username,bioText:bio,profileImage:UIImage())
//            //                print(user.username)
//            let user = User(json: userJson)
//            users.append(user)
//        }
        
//        var tweets = [Tweet]()
//        let tweetsJsonArray = json["tweets"].array
//        guard let tweetsJsonArray = json["tweets"].array else {
//            throw NSError(domain: "com.letsbuildthatapp", code: 1, userInfo: [NSLocalizedDescriptionKey:"'tweets' not valid in JSON."])
//        }
        //self.tweets = tweetsJsonArray.map{Tweet(json:$0)}
       
//        for tweetJson in tweetsJsonArray! {
//            print(tweetJson)
//
//            let userJson = tweetJson["user"]
//            let user = User(json: userJson)
//
////            let name = userJson["name"].stringValue
////            let username = userJson["username"].stringValue
////            let bio = userJson["bio"].stringValue
////
////            let user = User(name:name,username:username,bioText:bio,profileImage:UIImage())
//
//            let message = tweetJson["message"].stringValue
//
//            let tweet = Tweet(user: user, message: message)
//            let tweet = Tweet(json: tweetJson)
//            tweets.append(tweet)
//        }
        
        //self.users = users
//        self.tweets = tweets
        self.users = try usersJsonArray.decode()
        self.tweets = try tweetsJsonArray.decode()

    }
    
    var tweets:[Tweet]
//        = {
//        let brianUser = User(name:"Brian Voong",username:"@testtesttest",
//                             bioText:"iPhone,iPad,iOS programing community.iPhone,iPad,iOS programing community.iPhone,iPad,iOS programing community.",profileImage:#imageLiteral(resourceName: "profile_image"))
//        let tweet1 = Tweet(user:brianUser,message:"Welcome to episode 9 of the Twitter Series,really hop you guys are enjoying the series so far.I really really need a long text block to render out so we're going to stop here.")
//
//        let tweet2 = Tweet(user:brianUser,message:"Welcome to episode 9 of the Twitter Series,really hop you guys are enjoying the series so far.I really really need a long text block to render out so we're going to stop here.")
//
//        return [tweet1,tweet2]
//    }()
    
    override func headerClasses() -> [DatasourceCell.Type]? {
        return [UserHeader.self]
    }
    
    override func footerClasses() -> [DatasourceCell.Type]? {
        return [UserFooter.self]
    }
    
    override func cellClasses() -> [DatasourceCell.Type] {
        return [UserCell.self,TweetCell.self]
    }
    
    override func item(_ indexPath: IndexPath) -> Any? {
        if indexPath.section == 1 {
            return tweets[indexPath.item]
        }
        return users[indexPath.item]
    }
    
    override func numberOfSections() -> Int {
        return 2
    }
    
    override func numberOfItems(_ section: Int) -> Int {
        if section == 1 {
            return tweets.count
        }
        return users.count
    }
    
}
