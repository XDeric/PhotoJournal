//
//  SaveViewController.swift
//  Photo_Assesment
//
//  Created by EricM on 10/4/19.
//  Copyright © 2019 EricM. All rights reserved.
//

import UIKit

class SaveViewController: UIViewController, UITextFieldDelegate {
    var delegate: PhotoSaveDelegate?
    
    @IBOutlet weak var imageOutlet: UIImageView!
    @IBOutlet weak var textOutlet: UITextField!
    var text = String()
    
    var image = UIImage() {
        didSet {
            imageOutlet.image = image
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textOutlet.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addSave(_ sender: UIButton) {
        let newSave = Favorite(name: text, image: ((image.pngData() ?? UIImage(named: "noPic")!.pngData())!))
        DispatchQueue.global(qos: .utility).async {
            try? SavePersistenceHelper.manager.save(newFavorite: newSave)            
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        }
        
    }
    @IBAction func pickImage(_ sender: UIButton) {
        let imagePickerVC = UIImagePickerController()
        imagePickerVC.delegate = self
        present(imagePickerVC, animated: true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        text = textField.text ?? "No Name"
        return true
    }
    
}



extension SaveViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        self.image = image
        dismiss(animated: true, completion: nil)
    }
}
