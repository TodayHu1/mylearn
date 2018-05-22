//
//  HomeDatasourceController.swift
//  LearnTwitter
//
//  Created by Naihe Hu on 2018/5/19.
//  Copyright © 2018年 Naihe Hu. All rights reserved.
//

import LBTAComponents
import TRON
import SwiftyJSON

class HomeDatasourceController:DatasourceController {
    
    let errorMessageLabel:UILabel = {
        let label = UILabel()
        label.text = "Apologies something went wrong.Please try again later.."
        label.textAlignment = .center
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(errorMessageLabel)
        errorMessageLabel.fillSuperview() // LBTA method call
        
        collectionView?.backgroundColor = UIColor(r: 232, g: 236, b: 241)
        
        setupNavigationBarItems()
//        let homeDatasource = HomeDatasource()
//        self.datasource = homeDatasource
        
        //fetchHomeFeed()
        
        Service.sharedInstance.fetchHomeFeed { (homeDatasource, err) in
            if let err = err {
                self.errorMessageLabel.isHidden = false
                if let apiError = err as? APIError<Service.JSONError> {
                    if apiError.response?.statusCode != 200 {
                        self.errorMessageLabel.text = "Status code was not 200"
                    }
                }else{
                    self.errorMessageLabel.isHidden = false
                }
                //print("HomeDatasourceController error fetching json: ",err)
                return
            }
            self.datasource = homeDatasource
        }
//
//        Service.sharedInstance.fetchHomeFeed { (homeDatasource) in
//            self.datasource = homeDatasource
//        }
        
    }
    
//    let tron = TRON(baseURL:"https://api.letsbuildthatapp.com")
    
    
//    class Home:JSONDecodable {
//        let users:[User]
//
//        required init(json:JSON) throws {
////            print("Now ready to parse json: \n",json)
//
//            var users = [User]()
//
//            let array = json["users"].array
//            for userJson in array! {
//                let name = userJson["name"].stringValue
//                let username = userJson["username"].stringValue
//                let bio = userJson["bio"].stringValue
//
//                let user = User(name:name,username:username,bioText:bio,profileImage:UIImage())
////                print(user.username)
//                users.append(user)
//            }
//
//            self.users = users
//
//        }
//    }
    
//    class JSONError:JSONDecodable {
//        required init(json:JSON) throws {
//            print("JSON ERROR")
//        }
//    }
//
//    fileprivate func fetchHomeFeed(){
//
//        let request:APIRequest<HomeDatasource,JSONError> = tron.swiftyJSON.request("/twitter/home")
//
//        request.perform(withSuccess:{(homeDatasource) in
//            print("Successfully fetched our json objects")
//            print(homeDatasource.users.count)
//
//            self.datasource = homeDatasource
//
//        }){ (err) in
//            print("Failed to fetch json...",err)
//        }
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 0 {
//            if let user = self.datasource?.item(indexPath) as? User {
//                let approximateWidthOfBioTextView = view.frame.width - 12 - 50 - 12 - 2
//                let size = CGSize(width: approximateWidthOfBioTextView, height: 1000)
//                let attributes = [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 15)]
//
//                let estimatedFrame = NSString(string:user.bioText).boundingRect(with:size,options:.usesLineFragmentOrigin,attributes:attributes,context:nil)
                guard let user = self.datasource?.item(indexPath) as? User else {return .zero}
                let estimatedHeight = estimatedHeightForText(user.bioText)
                return CGSize(width: view.frame.width, height: estimatedHeight + 66)
//            }
        }else if indexPath.section == 1 {
            
            guard let tweet = datasource?.item(indexPath) as? Tweet else {return .zero}
            
//            let approximateWidthOfBioTextView = view.frame.width - 12 - 50 - 12 - 2
//            let size = CGSize(width: approximateWidthOfBioTextView, height: 1000)
//            let attributes = [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 15)]
//
//            let estimatedFrame = NSString(string:tweet.message).boundingRect(with:size,options:.usesLineFragmentOrigin,attributes:attributes,context:nil)
            
            let estimatedHeight = estimatedHeightForText(tweet.message)
            
            return CGSize(width: view.frame.width, height: estimatedHeight + 75)
        }

        return CGSize(width: view.frame.width, height: 180)
    }
    
    private func estimatedHeightForText(_ text:String) -> CGFloat {
        let approximateWidthOfBioTextView = view.frame.width - 12 - 50 - 12 - 2
        let size = CGSize(width: approximateWidthOfBioTextView, height: 1000)
        let attributes = [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 15)]
        
        let estimatedFrame = NSString(string:text).boundingRect(with:size,options:.usesLineFragmentOrigin,attributes:attributes,context:nil)
        return estimatedFrame.height
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 1 {
            return .zero
        }
        return CGSize(width: view.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if section == 1 {
            return .zero
        }
        return CGSize(width: view.frame.width, height: 64)
    }
    
}
