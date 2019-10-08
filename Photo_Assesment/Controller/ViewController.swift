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
        didSet {
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
            
            cell.nameLabel.text = fave[indexPath.row].name
            cell.imageOutlet.image = UIImage(data: fave[indexPath.row].image)
            cell.delegate = self
            cell.editOutlet.tag = indexPath.row
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    @IBAction func addItemButton(_ sender: Any) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let addVC = storyboard.instantiateViewController(identifier: "addVC") as! SaveViewController
        self.navigationController?.pushViewController(addVC, animated: true)
    }
    
    @IBAction func settings(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let setVC = storyboard.instantiateViewController(identifier: "setVC") as! SettingViewController
        self.navigationController?.pushViewController(setVC, animated: true)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewOutlet.delegate = self
        collectionViewOutlet.dataSource = self
//      loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    
    func loadData() {
        do {
            fave = try SavePersistenceHelper.manager.getFavorite()
        } catch {
            print(error)
        }
    }
}



extension ViewController: PhotoCellDelegate {
    func showActionSheet(tag: Int) {
        let optionsMenu = UIAlertController.init(title: "Options", message: "Pick an option", preferredStyle: .actionSheet)
        let favoriteAction = UIAlertAction.init(title: "Edit", style: .default) { (action) in
            //Favorite/Edit using persistence
            let edit = self.fave[tag]
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let editVC = storyboard.instantiateViewController(withIdentifier: "editVC") as! EditViewController
            editVC.delegate = self
            editVC.picture = edit.image
            editVC.name = edit.name
            editVC.index = tag
            editVC.modalPresentationStyle = .currentContext
            self.navigationController?.pushViewController(editVC, animated: true)
            
        }
        let shareAction = UIAlertAction.init(title: "Share", style: .default) { (action) in
            //share it
        }
        let deleteAction = UIAlertAction.init(title: "Delete", style: .destructive) { (action) in
            //Delete from persistence
            let photo = self.fave[tag]
            self.fave.remove(at: tag)
            let newSave = Favorite(name: photo.name, image: photo.image)
            DispatchQueue.global(qos: .utility).async {
                try? SavePersistenceHelper.manager.deleteFavorite(delete: newSave, withID: tag)
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
        let cancelAction = UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil)
        optionsMenu.addAction(favoriteAction)
        optionsMenu.addAction(deleteAction)
        optionsMenu.addAction(shareAction)
        optionsMenu.addAction(cancelAction)
        present(optionsMenu, animated: true, completion: nil)
    }
}
