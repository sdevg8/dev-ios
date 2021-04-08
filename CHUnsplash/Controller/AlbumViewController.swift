//
//  AlbumViewController.swift
//  CHUnsplash
//
//  Created by user on 05/04/21.
//

import UIKit
import ProgressHUD

class AlbumViewController: UIViewController {
    @IBOutlet weak var albumSearchBar: UISearchBar!
    @IBOutlet weak var albumTableView: UITableView!
    var albumViewModel: AlbumViewModel!
    var searchActive = false
    var filterAlbumList = [Albums]() {
        didSet {
            reloadAlbumTableView()
        }
    }
    
    var albumList = [Albums]() {
        didSet {
            reloadAlbumTableView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setKeyboardObserver()
        self.title = "Albums"
        setupSearchBar()
        setupTableView()
        ProgressHUD.show()
        albumViewModel = AlbumViewModel()
        setupAlbumAPICallback()
    }
    
    func setKeyboardObserver() {
        let notifier = NotificationCenter.default
        notifier.addObserver(self,
                             selector: #selector(self.keyboardWillShow(_:)),
                             name: UIWindow.keyboardWillShowNotification,
                             object: nil)
        notifier.addObserver(self,
                             selector: #selector(self.keyboardWillHide(_:)),
                             name: UIWindow.keyboardWillHideNotification,
                             object: nil)
    }
    
    func setupTableView() {
        self.albumTableView.estimatedRowHeight = UITableView.automaticDimension
        self.albumTableView.tableFooterView = UIView(frame: .zero)
    }
    
    func setupSearchBar() {
        albumSearchBar.delegate = self
    }
    
    func reloadAlbumTableView() {
        DispatchQueue.main.async {
            self.albumTableView.reloadData()
        }
    }
    
    func setupAlbumAPICallback() {
        albumViewModel.onAlbumAPISuccess = {[weak self] (album) in
            guard let self = self else { return }
            self.albumList = album
            ProgressHUD.dismiss()
        }
        albumViewModel.onAlbumAPIFailure = {[weak self] (error) in
            guard let self = self else { return }
            self.view.makeToast(error)
            ProgressHUD.dismiss()
        }
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            albumTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        if ((notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            albumTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    
    func pushToPhotoVC(_ albumId: Int) {
        guard let photosVC = self.storyboard?.instantiateViewController(identifier: "PhotosViewController", creator: { coder in
            return PhotosViewController(coder: coder, albumId: albumId)
        }) else {return}
        self.navigationController?.pushViewController(photosVC, animated: false)
    }
    
}

//MARK:- Table View
extension AlbumViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterAlbumList.count == 0 && !searchActive ? albumList.count:filterAlbumList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AlbumTableViewCell.identifier, for: indexPath) as? AlbumTableViewCell else{
            return UITableViewCell()
        }
        cell.configure(filterAlbumList.count == 0 && !searchActive ? albumList[indexPath.row]:filterAlbumList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pushToPhotoVC(self.albumList[indexPath.row].id)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK:- SearchBar
extension AlbumViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: false)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterAlbumList = searchText.isEmpty ? [] : albumList.filter({ (album) -> Bool in
            album.title.localizedCaseInsensitiveContains(searchText)
        })
        searchActive = filterAlbumList.count == 0 && searchText.isEmpty  ? false : true
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        filterAlbumList = []
        searchActive = false
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.endEditing(true)
    }
}





