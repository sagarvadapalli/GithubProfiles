//
//  NetworkManager.swift
//  GithubProfiles
//
//  Created by Sagar Vadapalli on 1/14/25.
//

import UIKit

/// The enum for error type.
enum GPError: String, Error {
    case error = "Error"
    case invalidURL = "Invalid URL"
    case responseUnsuccessful = "Not found"
    case dataError = "Invalid data"
    case rateLimit = "Rate limit exceeded"
}

class NetworkManager {
    static let shared = NetworkManager()
    private let cache = NSCache<NSString, UIImage>()
    private var httpResponse: HTTPURLResponse? = nil
    
    /// Method to fetch repos data. This method is used to build the languages array.
    /// - Parameter searchText: The search string.
    /// - Returns: List of Repos.
    func getData(with searchText: String) async throws -> [RepoInfo] {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.github.com"
        components.path = "/users/\(searchText)/repos"
        
        guard let url = components.url else {
            throw GPError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode ==  200 else {
            throw GPError.responseUnsuccessful
        }
        
        do {
            let decoder = JSONDecoder()
            let repos = try decoder.decode([RepoInfo].self, from: data)
            return repos
        } catch {
            throw GPError.dataError
        }
    }
    
    /// Method to fetch repos data by user.
    /// - Parameters:
    ///   - searchText: The search string.
    ///   - language: The language string.
    ///   - page: The page number.
    ///   - perPage: Fetch items per page number.
    /// - Returns: The list of Repos
    func getDataByPage(with searchText: String, language: String, page: Int, perPage: Int) async throws -> Repos {
        let baseURL = "https://api.github.com/search/repositories" + "?q=user:\(searchText)+language:\(language)&per_page=\(perPage)&page=\(page)"
        
        guard let url = URL(string: baseURL) else {
            throw GPError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        self.httpResponse = response as? HTTPURLResponse
        guard let response = response as? HTTPURLResponse,
                response.statusCode ==  200 else {
            if let value = httpResponse?.allHeaderFields["x-ratelimit-remaining"], value as? String == "0" {
                throw GPError.rateLimit
            } else {
                throw GPError.responseUnsuccessful
            }
        }
        
        do {
            let decoder = JSONDecoder()
            let repos = try decoder.decode(Repos.self, from: data)
            return repos
        } catch {
            throw GPError.dataError
        }
    }
    
    /// Method to download image from a url.
    /// - Parameters:
    ///   - urlString: url to download the image.
    /// - Returns: The image.
    func downloadImage(from urlString: String) async -> UIImage? {
        let cacheKey = NSString(string: urlString)
        if let image = cache.object(forKey: cacheKey) { return image }
        guard let url = URL(string: urlString) else { return nil }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let image = UIImage(data: data) else { return nil }
            cache.setObject(image, forKey: cacheKey)
            return image
        } catch {
            return nil
        }
    }
}
