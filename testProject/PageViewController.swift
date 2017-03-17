//
//  PageViewController.swift
//  testProject
//
//  Created by kuzindmitry on 17.03.17.
//  Copyright © 2017 kuzindmitry. All rights reserved.
//

import UIKit

class PageViewController: UIViewController {

    var page:Page!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = page.title
        textView.text = page.body
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy HH:mm"
        dateLabel.text = formatter.string(from: page.updatedAt)
    }


}
