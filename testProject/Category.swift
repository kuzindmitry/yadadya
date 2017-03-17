//
//  Category.swift
//  testProject
//
//  Created by kuzindmitry on 17.03.17.
//  Copyright © 2017 kuzindmitry. All rights reserved.
//

import Foundation

class Category {
    let id: Int
    let title: String
    let createdAt: Date
    let updatedAt: Date
    let slug: String
    
    init(dict: [String:Any]) {
        self.id = dict["id"] as! Int
        self.title = dict["title"] as! String
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let createdText = (dict["created_at"] as! String).components(separatedBy: ".").first!.replacingOccurrences(of: "T", with: " ")
        self.createdAt = dateFormatter.date(from: createdText)!
        
        let updatedText = (dict["updated_at"] as! String).components(separatedBy: ".").first!.replacingOccurrences(of: "T", with: " ")
        self.updatedAt = dateFormatter.date(from: updatedText)!
        self.slug = dict["slug"] as! String
    }
}
