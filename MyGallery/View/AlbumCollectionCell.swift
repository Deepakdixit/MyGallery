//
//  AlbumCollectionCell.swift
//  MyGallery
//
//  Created by Deepak Dixit on 17/02/21.
//  Copyright © 2021 Deepak Dixit. All rights reserved.
//

import UIKit
import Nuke

final class AlbumCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        imgView.layer.cornerRadius = 10.0
        imgView.layer.masksToBounds = true
    }
    
    /**
     Set up Collection view Cell.
    
     Setting image title and downlaoding image through Nuke.
 
 */
    func setupCellWith(_ photo:Photo?, title:String) {
        if let urlString = photo?.thumbnailUrl, let url = URL(string: urlString) {
            Nuke.loadImage(with: url, into: self.imgView);
        }
        lblTitle.text = title;
    }
    
}

