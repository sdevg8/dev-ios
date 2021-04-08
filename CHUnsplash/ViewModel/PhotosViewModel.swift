//
//  PhotosViewModel.swift
//  CHUnsplash
//
//  Created by user on 14/03/21.
//

import Foundation

class PhotosViewModel {
    var onPhotosAPISuccess: (([Photos]) ->Void)?
    var onPhotosAPIFailure: ((String) ->Void)?
    init(albumId: Int) {
        getAlbums(albumId)
    }
    
    private func getAlbums(_ albumId: Int) {
        CHAPIManager.sessionProvider?.request(type: [Photos].self, service: PostService.photos(albumId: albumId)) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case let .success(photos):
                self.onPhotosAPISuccess?(photos)
            case let .failure(error):
                self.onPhotosAPIFailure?(error.value)
            }
        }
    }
}

