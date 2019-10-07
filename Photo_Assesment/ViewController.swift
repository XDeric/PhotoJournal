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
        return fave.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionViewOutlet.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as? ImageCollectionViewCell {
            return cell
        }
        return UICollectionViewCell()
    }
    
    @IBAction func addItemButton(_ sender: Any) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let addVC = storyboard.instantiateViewController(identifier: "addVC") as! SaveViewController
        addVC.delegate = (self as! PhotoSaveDelegate)
        self.navigationController?.pushViewController(addVC, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewOutlet.delegate = self
        collectionViewOutlet.dataSource = self
        // Do any additional setup after loading the view.
    }
}

extension ViewController: PhotoCellDelegate {
    func showActionSheet(tag: Int) {
        let optionsMenu = UIAlertController.init(title: "Options", message: "Pick an option", preferredStyle: .actionSheet)
        let favoriteAction = UIAlertAction.init(title: "Edit", style: .default) { (action) in
            //Favorite using persistence
            let film = self.fave[tag]
            //print("My favorite film is \(film.title)")
        }
        let deleteAction = UIAlertAction.init(title: "Delete", style: .destructive) { (action) in
            //Delete from persistence
            let film = self.fave[tag]
            //print("I just deleted \(film.title)")
        }
        let cancelAction = UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil)
        optionsMenu.addAction(favoriteAction)
        optionsMenu.addAction(deleteAction)
        optionsMenu.addAction(cancelAction)
        present(optionsMenu, animated: true, completion: nil)
    }
}
