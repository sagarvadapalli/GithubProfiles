//
//  GithubProfilesTests.swift
//  GithubProfilesTests
//
//  Created by Sagar Vadapalli on 1/14/25.
//

import XCTest
@testable import GithubProfiles

final class GithubProfilesTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testUpdatedDateFormatString() throws {
        // GIVEN
        let repoInfo: RepoInfo = RepoInfo(_id: 1,
                                          name: "Test Repo",
                                          description: "Test Repo Description",
                                          language: "Swift",
                                          stargazersCount: 10,
                                          forksCount: 12,
                                          owner: Owner(_id: 1, name: "Test Owner", imageUrl: ""),
                                          updatedDate: "2025-01-15T05:05:00Z")
        
        // WHEN
        let toUpdatedDateString = repoInfo.updatedDate?.toDate()?.toLocalString()
        
        // THEN
        XCTAssertEqual(toUpdatedDateString, "Wednesday, 01-15-2025 00:05 AM")
    }
    
    /// Test for Asynchronous network call.
    /// We marked the method to be async and throwing.
    func testImageFetching() async throws {
        let imageURL = "https://avatars.githubusercontent.com/u/20141661?v=4"
        
        let image = try await NetworkManager.shared.downloadImage(from: imageURL)
        XCTAssertNotNil(image)
    }
}
