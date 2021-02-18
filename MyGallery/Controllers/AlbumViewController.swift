//
//  HomeViewController.swift
//  MyGallery
//
//  Created by Deepak Dixit on 17/02/21.
//  Copyright © 2021 Deepak Dixit. All rights reserved.
//

import UIKit
import Reachability

class AlbumViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var refreshControl = UIRefreshControl()
    private let viewModel = AlbumsViewModel()
        override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: Constants.shared.reachability)
        self.loadData()
        self.setupViewModelClosures()
    }
    
    private func setupViewModelClosures() {
        viewModel.shouldStopRefresh = { [weak self] in
            guard let self = self else {
                return
            }
            self.stopRefresh()
        }
        
        viewModel.shouldReload = { [weak self] in
            guard let self = self else {
                return
            }
            self.collectionView.reloadData()
        }
    }
    
    @objc private func loadData() {
        self.viewModel.loadData()
    }
    
    @objc func reachabilityChanged(note: Notification) {
        guard let reachability = note.object as? Reachability else {
            return
        }
        if reachability.connection != .none && self.viewModel.groups == nil {
            self.loadData()
        }
    }
    
    func addPullToRefress() {
        refreshControl.attributedTitle = NSAttributedString(string: "Refresh")
        self.refreshControl.tintColor = UIColor.red
        refreshControl.addTarget(self, action: #selector(loadData), for: .valueChanged)
        self.collectionView.refreshControl = self.refreshControl
    }
    
    func stopRefresh() {
        self.refreshControl.endRefreshing()
    }
}

//  In Album view controller extension I am implementing Datasource and delegate of UICollectionView.
extension AlbumViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.viewModel.numberOfItemsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? AlbumCollectionCell
        let keyAndPhoto = viewModel.albumKeyAndPhoto(for: indexPath)
        cell?.setupCellWith(keyAndPhoto.0, title: "Album : \(keyAndPhoto.1)")
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let controller = self.storyboard?.instantiateViewController(withIdentifier: "PhotoViewController") as? PhotoViewController else {
            return
        }
        let albumAndID = viewModel.photosAlbumAndID(for: indexPath)
        controller.photos = albumAndID.0
        controller.albumId = albumAndID.1
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: SCREEN_WIDTH/2-15, height: SCREEN_WIDTH/2)
    }
}
