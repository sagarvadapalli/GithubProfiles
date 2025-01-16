//
//  RepoCellViewModel.swift
//  FetchRewardsCodingExercise
//
//  Created by Sagar Vadapalli on 1/14/25.
//

import UIKit

class RepoCellViewModel {
    let name: String
    let stargazersCount: Int
    let description: String
    let language: String
    let forksCount: Int
    
    init(_ repoInfo: RepoInfo) {
        self.name = repoInfo.name ?? ""
        self.stargazersCount =  repoInfo.stargazersCount ?? 0
        self.description =  repoInfo.description ?? "NA"
        self.language =  repoInfo.language ?? "NA"
        self.forksCount =  repoInfo.forksCount ?? 0
    }
}

