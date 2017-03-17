//
//  ViewController.swift
//  testProject
//
//  Created by kuzindmitry on 17.03.17.
//  Copyright © 2017 kuzindmitry. All rights reserved.
//

import UIKit

class CategoriesTableViewCotnroller: UITableViewController {

    var categories: [Category] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 300
        updateContent()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateContent), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
    }
    
    func updateContent() {
        Download.getCategories { (categories, error) in
            DispatchQueue.main.async {
                if error == nil {
                    self.categories = categories
                    self.tableView.reloadData()
                } else {
                    let alert = UIAlertController.init(title: "Ошибка", message: error?.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction.init(title: "Закрыть", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categories[indexPath.row].title
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPageCategory" {
            let vc = segue.destination as! CategoryPageTableViewController
            vc.category = categories[self.tableView.indexPathForSelectedRow!.row]
        }
    }
}

