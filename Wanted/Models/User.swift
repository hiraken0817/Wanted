//
//  User.swift
//  Wanted
//
//  Created by 平尾健太 on 2021/02/26.
//

import Foundation

struct User{
    let uid:String
    let username:String
    let profileImageUrl:String
    
    
    init(uid:String,dictionary:[String:Any]) {
        self.uid = uid
        self.username = dictionary["username"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
    
    }
}
