//
//  RepoInfo+Extension.swift
//  GithubProfiles
//
//  Created by Sagar Vadapalli on 1/15/25.
//

import Foundation
@testable import GithubProfiles

extension RepoInfo {
    static func mock(_id: Int?,
                     name: String?,
                     description: String?,
                     language: String?,
                     stargazersCount: Int?,
                     forksCount: Int?,
                     owner: Owner?,
                     updatedDate: String?) -> RepoInfo {
        return RepoInfo(_id: 1,
                        name: "Test Repo",
                        description: "Test Repo Description",
                        language: "Swift",
                        stargazersCount: 10,
                        forksCount: 12,
                        owner: Owner(_id: 1, name: "Test Owner", imageUrl: ""),
                        updatedDate: "2025-01-15T05:05:00Z")
    }
}
