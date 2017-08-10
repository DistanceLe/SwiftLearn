//
//  UserModel.swift
//  入门TableView
//
//  Created by celink on 15/8/6.
//  Copyright (c) 2015年 celink. All rights reserved.
//

import UIKit

class UserModel: NSObject
{
    var userName: String
    var userID: Int
    var phone: String
    var email: String
    
    init(userName: String, userID: Int, phone:  String?, email: String?)
    {
        self.userName=userName
        self.userID=userID
        self.phone=phone!
        self.email=email!
        
        super.init()
    }
    
    
    
   
}
