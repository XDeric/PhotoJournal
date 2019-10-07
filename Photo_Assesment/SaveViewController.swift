//
//  SaveViewController.swift
//  Photo_Assesment
//
//  Created by EricM on 10/4/19.
//  Copyright © 2019 EricM. All rights reserved.
//

import UIKit

class SaveViewController: UIViewController {
    var delegate: PhotoSaveDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
        //self.navigationController?.popViewController(animated: true)
    }
    @IBAction func save(_ sender: UIBarButtonItem) {
    }
    
    

}
