//
//  Protocol.swift
//  Photo_Assesment
//
//  Created by EricM on 10/7/19.
//  Copyright © 2019 EricM. All rights reserved.
//

import Foundation

protocol PhotoCellDelegate: AnyObject {
    func showActionSheet(tag: Int)
}

protocol PhotoSaveDelegate: AnyObject {
    func savePhoto()
}
