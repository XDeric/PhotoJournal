//
//  ViewController.swift
//  Photo_Assesment
//
//  Created by EricM on 10/4/19.
//  Copyright © 2019 EricM. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var collectionViewOutlet: UICollectionView!
    var fave = [Favorite](){
        didSet{
            collectionViewOutlet.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 340, height: 270)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionViewOutlet.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as? ImageCollectionViewCell {
            
            cell.nameLabel.text = "test"
            cell.imageOutlet.image = UIImage(named: "noPic")
            cell.delegate = self
            cell.editOutlet.tag = indexPath.row
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    @IBAction func addItemButton(_ sender: Any) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let addVC = storyboard.instantiateViewController(identifier: "addVC") as! SaveViewController
        //addVC.delegate = (self as! PhotoSaveDelegate)
        self.navigationController?.pushViewController(addVC, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewOutlet.delegate = self
        collectionViewOutlet.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func loadData(){
        
    }
    
    
}

extension ViewController: PhotoCellDelegate {
    func showActionSheet(tag: Int) {
        let optionsMenu = UIAlertController.init(title: "Options", message: "Pick an option", preferredStyle: .actionSheet)
        let favoriteAction = UIAlertAction.init(title: "Edit", style: .default) { (action) in
            //Favorite/Edit using persistence
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let editVC = storyboard.instantiateViewController(withIdentifier: "editVC") as! EditViewController
            editVC.delegate = self
            self.navigationController?.pushViewController(editVC, animated: true)
            
        }
        let deleteAction = UIAlertAction.init(title: "Delete", style: .destructive) { (action) in
            //Delete from persistence

        }
        let cancelAction = UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil)
        optionsMenu.addAction(favoriteAction)
        optionsMenu.addAction(deleteAction)
        optionsMenu.addAction(cancelAction)
        present(optionsMenu, animated: true, completion: nil)
    }
}
