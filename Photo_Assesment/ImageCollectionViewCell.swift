//
//  ImageCollectionViewCell.swift
//  Photo_Assesment
//
//  Created by EricM on 10/4/19.
//  Copyright © 2019 EricM. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageOutlet: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    weak var delegate: PhotoCellDelegate?
    
    
    @IBAction func editButton(_ sender: UIButton) {
        delegate?.showActionSheet(tag: sender.tag)
    }
    
    
}
