//
//  AlbumViewControllerTests.swift
//  CHUnsplashTests
//
//  Created by user on 07/04/21.
//

import XCTest
import UIKit
import ProgressHUD
@testable import CHUnsplash

class AlbumViewControllerTests: XCTestCase {
    var albumVC:AlbumViewController!
    
    override func setUpWithError() throws {
        albumVC = AlbumViewController.load(from: .main)
        let nv = UINavigationController(rootViewController: albumVC)
        let window = UIWindow()
        window.rootViewController = nv
        window.makeKeyAndVisible()
        _ = albumVC.view
        initializeDependencies()
        ProgressHUD.dismiss()
    }
    
    override func tearDownWithError() throws {
        albumVC = nil
    }
    
    func initializeDependencies() {
        let albums = CHTestsHelper.mockAlbumsList()
        albumVC.albumList = albums
    }
    
    func testAlbumTableView() {
        XCTAssertNotNil(albumVC.albumTableView)
        XCTAssertTrue(albumVC.tableView(albumVC.albumTableView, numberOfRowsInSection: 0) == 5)
        guard let row = albumVC.tableView(albumVC.albumTableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? AlbumTableViewCell else {
            return XCTFail("row is nil")
        }
        XCTAssertEqual(row.albumTitleLabel.text, "quidem molestiae enim")
    }
    
    func testAlbumSelect() {
        albumVC?.tableView(albumVC.albumTableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        XCTAssertNotNil(UIApplication.getTopViewController())
        XCTAssertTrue(UIApplication.getTopViewController() is PhotosViewController)
    }
    
    func testSearchBar() {
        albumVC.searchBar(albumVC.albumSearchBar, textDidChange: "om")
        XCTAssertEqual(albumVC.albumList.count, 5)
        XCTAssertEqual(albumVC.filterAlbumList.count, 3)
        XCTAssertTrue(albumVC.searchActive)
        albumVC?.searchBarCancelButtonClicked(albumVC!.albumSearchBar)
        XCTAssertEqual(albumVC.albumList.count, 5)
        XCTAssertEqual(albumVC.filterAlbumList.count, 0)
        XCTAssertFalse(albumVC.searchActive)
    }
}
