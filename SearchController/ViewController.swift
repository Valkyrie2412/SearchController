//
//  ViewController.swift
//  SearchController
//
//  Created by Hiếu Nguyễn on 8/1/18.
//  Copyright © 2018 Hiếu Nguyễn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    
    var data: String?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if data != nil {
            textField.text = data
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        data = textField.text
    }
}

