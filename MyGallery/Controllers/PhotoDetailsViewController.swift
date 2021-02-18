//
//  PhotoDetailsViewController.swift
//  MyGallery
//
//  Created by Deepak Dixit on 1/12/19.
//  Copyright © 2021 Deepak Dixit. All rights reserved.
//

import UIKit
import Nuke

class PhotoDetailsViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    var photo:Photo?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Photo Detail"
        self.configureUIWith()
    }
    
    /**
     Updating UI for particular image and downloading image using Nuke
     
     This method call from view load and this method downloading the Image from usrl and title of that image.
    */
    func configureUIWith() {
        self.lblTitle.text =  self.photo?.title
        if let urlString = self.photo?.url, let url = URL(string: urlString) {
            Nuke.loadImage(with: url, into: self.imageView);
        }
    }
}
