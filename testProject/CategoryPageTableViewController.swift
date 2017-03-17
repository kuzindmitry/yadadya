//
//  CategoryPageTableViewController.swift
//  testProject
//
//  Created by kuzindmitry on 17.03.17.
//  Copyright © 2017 kuzindmitry. All rights reserved.
//

import UIKit

class CategoryPageTableViewController: UITableViewController {

    var category: Category!
    var pages: [Page] = []
    
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
        Download.getPages(category: category) { (pages, error) in
            DispatchQueue.main.async {
                if error == nil {
                    self.pages = pages
                    self.tableView.reloadData()
                } else {
                    let alert = UIAlertController.init(title: "Ошибка", message: error?.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction.init(title: "Закрыть", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if (section == 0) {
            return 1
        }
        return pages.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "Категория"
        case 1: if (pages.count > 0) { return "Страницы" } else { return "Страниц не найдено" }
        default:
            return ""
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pageCell", for: indexPath)
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = category.title
            cell.selectionStyle = .none
            cell.accessoryType = .none
        case 1:
            cell.textLabel?.text = pages[indexPath.row].title
        default:
            break
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            self.performSegue(withIdentifier: "showPage", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPage" {
            let vc = segue.destination as! PageViewController
            vc.page = pages[self.tableView.indexPathForSelectedRow!.row]
        }
    }
}
