//
//  Owner.swift
//  GithubProfiles
//
//  Created by Sagar Vadapalli on 1/14/25.
//

import Foundation

struct Owner: Codable, Hashable {
    let _id: Int?
    let name: String?
    let imageUrl: String?
    
    public init (_id: Int?,
                 name: String?,
                 imageUrl: String?) {
        self._id = _id
        self.name = name
        self.imageUrl = imageUrl
    }
    
    public enum CodingKeys: String, CodingKey {
        case _id = "id"
        case name = "login"
        case imageUrl = "avatar_url"
    }
}
