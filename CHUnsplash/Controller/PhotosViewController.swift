//
//  PhotosViewController.swift
//  CHUnsplash
//
//  Created by user on 14/03/21.
//

import UIKit
import ProgressHUD
import Toast_Swift

class PhotosViewController: UIViewController {
    @IBOutlet weak var photosCollectionView: UICollectionView!
    var layout: UICollectionViewFlowLayout!
    var photoViewModel:PhotosViewModel!
    var albumId: Int
    var photoList = [Photos]() {
        didSet {
            DispatchQueue.main.async {
                self.photosCollectionView.reloadData()
            }
        }
    }
    
    init?(coder: NSCoder, albumId: Int) {
        self.albumId = albumId
        super.init(coder: coder)
    }
    required init?(coder: NSCoder) {
        fatalError("Missing album id.")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ProgressHUD.show()
        self.title = "Photos"
        setupCollectionViewItemSize()
        photoViewModel = PhotosViewModel(albumId: albumId)
        setupPhotosAPICallback()
    }
    
    func setupCollectionViewItemSize() {
        if layout == nil {
            let numberOfItemPerRow:CGFloat = 3
            let lineSpacing:CGFloat = 5
            let interitemSpacing:CGFloat = 5
            let width = (photosCollectionView.frame.size.width-(numberOfItemPerRow-1)*interitemSpacing)/numberOfItemPerRow
            let height = width
            layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize(width: width, height: height)
            layout.sectionInset = .zero
            layout.scrollDirection = .vertical
            layout.minimumLineSpacing = lineSpacing
            layout.minimumInteritemSpacing = interitemSpacing
            photosCollectionView.setCollectionViewLayout(layout, animated: true)
        }
    }
    
    func setupPhotosAPICallback() {
        photoViewModel.onPhotosAPISuccess = {[weak self] (photos) in
            guard let self = self else { return }
            self.photoList = photos
            ProgressHUD.dismiss()
        }
        photoViewModel.onPhotosAPIFailure = {[weak self] (error) in
            guard let self = self else { return }
            self.view.makeToast(error)
            ProgressHUD.dismiss()
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
}

extension PhotosViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.identifier, for: indexPath) as? PhotosCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(photoList[indexPath.row])
        return cell
    }
}
