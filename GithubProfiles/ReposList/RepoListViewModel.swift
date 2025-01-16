//
//  RepoListViewModel.swift
//  GithubProfiles
//
//  Created by Sagar Vadapalli on 1/14/25.
//

import Foundation
import Combine

class RepoListViewModel: ObservableObject {
    let searchText: String?
    @Published var filteredRepos: [RepoInfo] = []
    @Published var error: GPError?
    @Published var languages: [String] = []
    @Published var selectedLanguage: String?
    @Published var isLoading: Bool = false
    var currentPage = 0
    var reloadNext = true
    var currentLanguage: String = "All"
    
    init(searchText: String) {
        self.searchText = searchText
    }
    
    /// Method to build  the languages array.
    func fetchLanguages() async {
        guard let searchText = searchText else {
            return
        }
        
        isLoading = true
        
        do {
            let repos = try await NetworkManager.shared.getData(with: searchText)
            var languagesSet: Set<String> = Set(repos.compactMap { $0.language })
            languagesSet.insert("All")
            self.languages = languagesSet.sorted()
            isLoading = false
        } catch {
            isLoading = false
            self.languages = []
        }
    }
    
    /// Method to fetch the repos from the Network Manager.
    func fetchRepos() async {
        guard let searchText = searchText, reloadNext else {
            return
        }
        
        isLoading = true
        currentPage += 1
        
        do {
            let language = selectedLanguage ?? currentLanguage
            let repos = try await NetworkManager.shared.getDataByPage(with: searchText, language: language, page: currentPage, perPage: 10)
            if let items = repos.items, items.count > 0 {
                self.filteredRepos.append(contentsOf: items)
            } else {
                reloadNext = false
            }
            isLoading = false
        } catch {
            reloadNext = false
            isLoading = false
            if let gpError = error as? GPError {
                self.error = gpError
            } else {
                self.error = GPError.dataError
            }
        }
    }
    
    // Method to reset the properties.
    func reset() {
        currentPage = 0
        reloadNext = true
        filteredRepos.removeAll()
        error = nil
    }
    
    // MARK: - UIHelpers

    // Returns number of sections for the tableview.
    func numberOfSections() -> Int {
      return 1
    }
    
    // Returns number of rows for the tableview.
    func numberOfRows() -> Int {
        return filteredRepos.count
    }
}
