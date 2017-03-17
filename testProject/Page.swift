//
//  Post.swift
//  testProject
//
//  Created by kuzindmitry on 17.03.17.
//  Copyright © 2017 kuzindmitry. All rights reserved.
//

import Foundation

class Page {
    let id: Int
    let title: String
    let body: String
    let createdAt: Date
    let updatedAt: Date
    let categoryId: Int
    let slug: String
    
    init(dict: [String:Any]) {
        self.id = dict["id"] as! Int
        self.title = dict["title"] as! String
        self.body = dict["body"] as! String
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let createdText = (dict["created_at"] as! String).components(separatedBy: ".").first!.replacingOccurrences(of: "T", with: " ")
        self.createdAt = dateFormatter.date(from: createdText)!
        
        let updatedText = (dict["updated_at"] as! String).components(separatedBy: ".").first!.replacingOccurrences(of: "T", with: " ")
        self.updatedAt = dateFormatter.date(from: updatedText)!
        self.categoryId = dict["page_category_id"] as! Int
        self.slug = dict["slug"] as! String
    }
}
