//
//  Headlines.swift
//  DemoAPI+MVVM+CoreData
//
//  Created by Sheshnath on 26/06/19.
//  Copyright © 2019 Exp. All rights reserved.
//

import Foundation

class Headline {
    
    var title :String!
    var description :String!
    
    init?(dictionary :JSONDictionary) {
        
        guard let title = dictionary["title"] as? String,
            let description = dictionary["description"] as? String else {
                return nil
        }
        
        self.title = title
        self.description = description
    }
}
