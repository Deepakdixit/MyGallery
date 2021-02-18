//
//  PhotoViewController.swift
//  MyGallery
//
//  Created by Deepak Dixit on 1/12/19.
//  Copyright © 2021 Deepak Dixit. All rights reserved.
//

import UIKit
import Nuke

class PhotoViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var photos:[Photo]?
    var albumId:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Album \(albumId!)"
    }
}

    /**
    Extension of Photoview Controller In which, All the Collectionview delegstes and Datasource is handling
    */
extension PhotoViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photos?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! AlbumCollectionCell
        let thumbnailUrl = self.photos?[indexPath.row].thumbnailUrl
        if let thumbnailUrl = thumbnailUrl, let url = URL(string: thumbnailUrl) {
            Nuke.loadImage(with: url, into: cell.imgView);
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "PhotoDetailsViewController") as? PhotoDetailsViewController
        controller?.photo = self.photos![indexPath.row]
        self.navigationController?.pushViewController(controller!, animated: true)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: SCREEN_WIDTH/4-1, height: SCREEN_WIDTH/4-1)
    }
}
