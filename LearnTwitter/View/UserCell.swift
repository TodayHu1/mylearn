//
//  UserCell.swift
//  LearnTwitter
//
//  Created by Naihe Hu on 2018/5/20.
//  Copyright © 2018年 Naihe Hu. All rights reserved.
//

import UIKit
import LBTAComponents

class UserCell:DatasourceCell {
    
    override var datasourceItem: Any? {
        didSet {
            guard let user = datasourceItem as? User else {return}
            nameLabel.text = user.name
            usernameLabel.text = user.username
            bioTextView.text = user.bioText
//            profileImageView.image = user.profileImage
            
            profileImageView.loadImage(urlString: user.profileImageUrl)
        }
    }
    
    let profileImageView: CachedImageView = {
        let imageView = CachedImageView()
        imageView.image = #imageLiteral(resourceName: "profile_image")
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let nameLabel:UILabel = {
        let label = UILabel()
        label.text = "Today Hu"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let usernameLabel:UILabel = {
        let label = UILabel()
        label.text = "@buildthatapp"
        label.textColor = UIColor(r: 130, g: 130, b: 130)
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let bioTextView:UITextView = {
        let textView = UITextView()
        textView.text = "iPhone,iPad,iOS programing community.iPhone,iPad,iOS programing community.iPhone,iPad,iOS programing community."
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.backgroundColor = .clear
        return textView
    }()
    
    let followButton:UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 5
        button.layer.borderColor = twitterBlue.cgColor
        button.layer.borderWidth = 1
        button.setTitle("Follow", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(twitterBlue, for: .normal)
        button.setImage(#imageLiteral(resourceName: "follow"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -8, bottom: 0, right: 0)
        return button
    }()
    
    override func setupViews() {
        super.setupViews()
        self.backgroundColor = .white
        separatorLineView.isHidden = false
        separatorLineView.backgroundColor = UIColor(r: 230, g: 230, b: 230)
        
        addSubview(profileImageView)
        addSubview(nameLabel)
        addSubview(usernameLabel)
        addSubview(bioTextView)
        addSubview(followButton)
        
        profileImageView.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(12)
            make.top.equalTo(self.snp.top).offset(12)
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
        
        //        profileImageView.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: nil, topConstant: 12, leftConstant: 12, bottomConstant: 0, rightConstant: 0, widthConstant: 50, heightConstant: 50)
        
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(profileImageView.snp.top)
            make.left.equalTo(profileImageView.snp.right).offset(8)
            make.right.equalTo(followButton.snp.left).offset(-8)
            make.height.equalTo(20)
            
        }
        
        usernameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom)
            make.left.equalTo(nameLabel.snp.left)
            make.right.equalTo(nameLabel.snp.right)
            make.height.equalTo(20)
        }
        
        bioTextView.snp.makeConstraints { (make) in
            make.top.equalTo(usernameLabel.snp.bottom)
            make.left.equalTo(usernameLabel.snp.left)
            make.right.equalTo(self.snp.right)
            make.bottom.equalTo(self.snp.bottom)
        }
        
        followButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(12)
            make.right.equalTo(self.snp.right).offset(-8)
            make.width.equalTo(120)
            make.height.equalTo(34)
        }
        
        //        nameLabel.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
    }
}
