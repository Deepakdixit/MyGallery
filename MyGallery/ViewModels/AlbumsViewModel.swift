//
//  AlbumsViewModel.swift
//  MyGallery
//
//  Created by Deepak Dixit on 17/02/21.
//  Copyright © 2021 Deepak Dixit. All rights reserved.
//

import Foundation
import ProgressHUD

final class AlbumsViewModel {
    var groups:[String:[Photo]]?
    var shouldReload: (() -> Void)?
    var shouldStopRefresh: (() -> Void)?
    
    
    /// This function is for downloading the data from server
    func loadData() {
        ProgressHUD.show()
        ServiceManager.shared.fetchPhotos { (photos, error) in
            ProgressHUD.dismiss()
            self.shouldStopRefresh?()
            guard let unwrappedPhotos = photos else {
                return
            }
            self.groups = self.groupImages(unwrappedPhotos)
            self.shouldReload?()
        }
    }
    
    /**
     Grouping photos by album Id
     
     - Parameter photos: array of photo instance
     - Return : dictionary keyed by album id
     */
    func groupImages(_ photos:[Photo]) -> [String:[Photo]] {
        var groupedImages = [String:[Photo]]()
        for photo in photos {
            var array = groupedImages["\(photo.albumId ?? 0)"] ?? [Photo]()
            array.append(photo);
            groupedImages["\(photo.albumId ?? 0)"] = array;
        }
        return groupedImages
    }
    
    /// Delegate method
    /// - Returns: number of section in collection view
    func numberOfItemsInSection() -> Int {
      self.groups?.keys.count ?? 0
    }
    
    
    /// This function is for data in cell for row at index path
    /// - Parameter indexPath: Index path for which data is required
    /// - Returns: Return photo and ID for album population
    func albumKeyAndPhoto(for indexPath: IndexPath) -> (Photo?, String) {
        var key = Array(groups!.keys)[indexPath.row]
        let photo = groups?[key]?.first
        key = "\(key) (\(groups?[key]?.count ?? 0))"
        return (photo, key)
    }
    
    
    /// This function is for getting data on cell selection
    /// - Parameter indexPath: Selected cell index path
    /// - Returns: All the photos from selected Album and ID of album
    func photosAlbumAndID(for indexPath: IndexPath) -> ([Photo]?, String) {
        let key = Array(groups!.keys)[indexPath.row]
        let photos = groups?[key]
        return (photos, key)
    }
}
