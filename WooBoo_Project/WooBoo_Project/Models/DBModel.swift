//
//  DMModel.swift
//  ServerJson_02
//
//  Created by 유민규 on 2021/02/15.
//

import Foundation

class DBModel: NSObject{
    
    // Properties
    var stitle: String?

    
    // Empty constructor
    override init() {
        
    }
    
    init(stitle: String){
        self.stitle = stitle
    }
    
}