//
//  EditViewController.swift
//  Photo_Assesment
//
//  Created by EricM on 10/4/19.
//  Copyright © 2019 EricM. All rights reserved.
//

import UIKit

class EditViewController: UIViewController, UITextFieldDelegate {
    var delegate: PhotoCellDelegate?
    var index: Int?
    @IBOutlet weak var textFieldOutlet: UITextField!
    @IBOutlet weak var imageOutlet: UIImageView!
    
    var text = String()
    var image = UIImage() {
        didSet {
            imageOutlet.image = image
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldOutlet.delegate = self
    // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        text = textField.text ?? "No Name"
        return true
    }
    
    @IBAction func editSave(_ sender: UIButton) {
        let newSave = Favorite(name: text, image: ((image.pngData() ?? UIImage(named: "noPic")!.pngData())!))
        DispatchQueue.global(qos: .utility).async {
            try? SavePersistenceHelper.manager.replaceFavorite(replace: newSave, index: 1)
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
}



extension EditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        self.image = image
        dismiss(animated: true, completion: nil)
    }
}
