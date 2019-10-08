//
//  SettingViewController.swift
//  Photo_Assesment
//
//  Created by EricM on 10/7/19.
//  Copyright © 2019 EricM. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableViewOutlet: UITableView!
    var color = Setting.Colors{
        didSet{
            tableViewOutlet.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewOutlet.dataSource = self
        tableViewOutlet.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return color.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewOutlet.dequeueReusableCell(withIdentifier: "cell2", for: indexPath)
        cell.textLabel?.text = color[indexPath.row].name
        cell.detailTextLabel?.text = ""
        cell.backgroundColor = color[indexPath.row].color
        
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let segueIdentifier = segue.identifier else { fatalError("No identifier in segue") }
        
        switch segueIdentifier {
        case "settingSegue" :
            guard let setVC = segue.destination as? ViewController else {
                fatalError("Unexpected segue VC")
            }
            guard let selectedIndexPath = tableViewOutlet.indexPathForSelectedRow else {
                fatalError("No row was selected")
            }
            setVC.colors = color[selectedIndexPath.row]
        default:
            fatalError("Nice Try")
        }
    }
}
