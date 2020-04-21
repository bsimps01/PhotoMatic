//
//  ViewController.swift
//  PhotoMatic
//
//  Created by Thomas Vandegriff on 2/14/19.
//  Copyright © 2019 Make School. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet var collectionView: UICollectionView!
    
    //TODO: Insert your API Key here
    
    var photos: [Photo] = []
    
    
    
    //MARK: View lifecycle functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
         reloadDataSource()
    }
    
    
    //MARK: UICollectionViewDataSource delegate functions
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let identifier = "PhotoCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier,
                                               for: indexPath) as! PhotoCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        
        let photo = photos[indexPath.row]
        
        // Download the image data...
        PhotoFetchService.fetchImage(for: photo, completion: { (result) -> Void in
            
            guard let photoIndex = self.photos.index(where: { $0 === photo }),
                case let .success(image) = result else {
                    return
            }
            
            let photoIndexPath = IndexPath(item: photoIndex, section: 0)
            
            // Update  cell when the request finishes
            if let cell = self.collectionView.cellForItem(at: photoIndexPath)
                as? PhotoCell {
                cell.updateCell(with: image)
            }
        })
    }


     //MARK: Network calls and JSON processing functions
    
    private func reloadDataSource() {
        PhotoFetchService.fetchPhotos() {
            (photoFetchResult) -> Void in
            
            switch photoFetchResult {
            case let .success(photos):
                self.photos = photos
            case let .failure(error):
                self.photos.removeAll()
                print("Error fetching recent Photos: \(error)")
            }
            self.collectionView.reloadSections(IndexSet(integer: 0))
        }
    }
    

}

