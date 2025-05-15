//
//  EditViewModel.swift
//  BucketList
//
//  Created by Norman on 10.05.25.
//

import Foundation

extension EditView {
    @Observable
    class EditViewModel {
        var loadingState: LoadingState
        var pages: [Page]
        
        var name: String
        var description: String
        var location: Location
        
        init(location: Location) {
            self.location = location
            self.name = location.name
            self.description = location.description
            self.pages = [Page]()
            self.loadingState = LoadingState.loading
        }
    }
}
