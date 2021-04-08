//
//  PhotosViewControllerTests.swift
//  CHUnsplashTests
//
//  Created by user on 08/04/21.
//

import XCTest
import ProgressHUD
@testable import CHUnsplash

class PhotosViewControllerTests: XCTestCase {
    var photosVC:PhotosViewController!
    
    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        photosVC = storyboard.instantiateViewController(identifier: "PhotosViewController", creator: { coder in
            return PhotosViewController(coder: coder, albumId: 1)
        })
        XCTAssertNotNil(photosVC)
        _ = photosVC.view
        initializeDependencies()
        ProgressHUD.dismiss()
    }
    
    override func tearDownWithError() throws {
        photosVC = nil
    }
    
    func initializeDependencies() {
        let photos = CHTestsHelper.mockPhotosList()
        photosVC.photoList = photos
    }
    
    func testPhotosCollectionView() {
        XCTAssertNotNil(photosVC.photosCollectionView)
        XCTAssertTrue(photosVC.collectionView(photosVC.photosCollectionView, numberOfItemsInSection: 0) == 5)
        guard let item = photosVC?.collectionView(photosVC.photosCollectionView, cellForItemAt: IndexPath(row: 0, section: 0)) as? PhotosCollectionViewCell else {
            return XCTFail("item is nil")
        }
        XCTAssertNotNil(item)
    }
}
