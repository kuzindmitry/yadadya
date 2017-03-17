//
//  Download.swift
//  testProject
//
//  Created by kuzindmitry on 17.03.17.
//  Copyright © 2017 kuzindmitry. All rights reserved.
//

import Foundation

class Download {
    
    static func getCategories(completion: @escaping(_ result: [Category], _ error: Error?)->Void) {
        self.load(url: "https://yadadya-development-ycms.herokuapp.com/page_categories.json") { (result, error) in
            if error != nil {
                completion([], error)
            }
            if let dicts = result as? [[String:Any]] {
                var categories = [Category]()
                for dict in dicts {
                    let category = Category(dict: dict)
                    categories.append(category)
                }
                completion(categories, nil)
            }
        }
    }
    
    static func getPages(category: Category, completion: @escaping(_ result: [Page], _ error: Error?) -> Void) {
        self.load(url: "https://yadadya-development-ycms.herokuapp.com/page_categories/1.json") { (result, error) in
            if error != nil {
                completion([], error)
            }
            if let dicts = result as? [[String:Any]] {
                var pages = [Page]()
                for dict in dicts {
                    let page = Page(dict: dict)
                    pages.append(page)
                }
                pages = pages.filter { $0.categoryId == category.id }
                completion(pages, nil)
            }
        }
    }
    
    
    static func load(url: String, completion: @escaping(_ result: Any?, _ error: Error?)->Void) {
        URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(nil, error)
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                completion(json, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
}
