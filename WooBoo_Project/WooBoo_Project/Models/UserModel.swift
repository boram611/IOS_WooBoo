//
//  UserModel.swift
//  WooBoo_Project
//
//  Created by ssemm on 2021/02/23.
//

import Foundation

class UserModel : NSObject{
    // Properties(자바의 Field)
    var uEmail: String?
    var uPw: String?
    var uInsertDate: String?
    var uDeleteDate: String?
    var uImageFileName: String?
    
    //Empty constructor
    override init() {
        
    }
    
    init(uEmail: String, uPw: String, uInsertDate: String, uDeleteDate: String, uImageFileName: String){
        
        self.uEmail = uEmail
        self.uPw = uPw
        self.uInsertDate = uInsertDate
        self.uDeleteDate = uDeleteDate
        self.uImageFileName = uInsertDate
        
    }
    
}