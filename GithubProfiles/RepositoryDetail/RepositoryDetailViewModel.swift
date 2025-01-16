//
//  RepositoryDetailViewModel.swift
//  GithubProfiles
//
//  Created by Sagar Vadapalli on 1/14/25.
//

import UIKit

class RepositoryDetailViewModel {
    let repo: RepoInfo?
    
    init(repo: RepoInfo) {
        self.repo = repo
    }
    
    /// Method to download image from the network manager.
    /// - Parameters:
    ///   - urlString: url to download the image.
    /// - Returns: The image.
    func getAvatarImage(_ urlString: String) async -> UIImage? {
        return await NetworkManager.shared.downloadImage(from: urlString)
    }
}
