//
//  RepoInfo.swift
//  GithubProfiles
//
//  Created by Sagar Vadapalli on 1/14/25.
//

import Foundation

struct RepoInfo: Codable, Hashable {
    let _id: Int?
    let name: String?
    let description: String?
    let language: String?
    let stargazersCount: Int?
    let forksCount: Int?
    let owner: Owner?
    let updatedDate: String?
    
    public init(_id: Int?,
                name: String?,
                description: String?,
                language: String?,
                stargazersCount: Int?,
                forksCount: Int?,
                owner: Owner?,
                updatedDate: String?) {
        self._id = _id
        self.name = name
        self.description = description
        self.language = language
        self.stargazersCount = stargazersCount
        self.forksCount = forksCount
        self.owner = owner
        self.updatedDate = updatedDate
    }
    
    public enum CodingKeys: String, CodingKey {
        case _id = "id"
        case name
        case description
        case language
        case stargazersCount = "stargazers_count"
        case forksCount = "forks_count"
        case owner
        case updatedDate = "updated_at"
    }
}
