//
//  Repos.swift
//  GithubProfiles
//
//  Created by Sagar Vadapalli on 1/15/25.
//

import Foundation

struct Repos: Codable, Hashable {
    let items: [RepoInfo]?
    
    public init (items:  [RepoInfo]?) {
        self.items = items
    }
    
    public enum CodingKeys: String, CodingKey {
        case items
    }
}
