//
//  AlbumViewModel.swift
//  CHUnsplash
//
//  Created by user on 14/03/21.
//

import Foundation

class AlbumViewModel {
    var onAlbumAPISuccess: (([Albums]) ->Void)?
    var onAlbumAPIFailure: ((String) ->Void)?
    init() {
        getAlbums()
    }
    
    private func getAlbums() {
        CHAPIManager.sessionProvider?.request(type: [Albums].self, service: PostService.albums) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case let .success(albums):
                self.onAlbumAPISuccess?(albums)
            case let .failure(error):
                self.onAlbumAPIFailure?(error.value)
            }
        }
    }
}
    
