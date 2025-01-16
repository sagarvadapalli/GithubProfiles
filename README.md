//
//  Readme.swift
//  GithubProfiles
//
//  Created by Sagar Vadapalli on 1/15/25.
//

GitHub Profiles is a Swift iOS app that allows users to search for GitHub profiles and fetch repository information using the GitHub API.

Features
* Search for GitHub users by username
* Display user profile information
* Fetch and display user repositories
* Uses Swift's async/await for network calls
* Includes unit tests with mocked networking calls
* Added ratelimit and Error handling
* Pagination is included for loading repositories

Requirements
* iOS 17.6+
* Xcode 16.0+
* Swift 5.0+

Installation
1. Clone the repository: bash git clone https://github.com/sagarvadapalli/GithubProfiles
2. cd GithubProfiles
3. Open in Xcode 16.
4. Open the project:
    * Open GithubProfiles.xcodeproj in Xcode.
5. Run in any iOS simulator or build to personal phone to run app.
6. No dependencies


Usage
1. Search for users:
    * Enter a GitHub username in the search field and press the "Search" button.
    * The app will display the user's profile information and a list of their repositories.
2. View repository details:
    * Tap on a repository to view more details.

Youtube Video:
https://youtube.com/shorts/Z0pzyzyIV6U

Unit Tests
* The project includes unit tests for the network manager.
* Tests are written using XCTest and mock network responses.
* To run the tests, select the test scheme in Xcode and press Cmd + U.

Screen Shots

![image alt](https://github.com/sagarvadapalli/GithubProfiles/blob/a454c9f3b5a12cce20e40d88d02e9fb6f619ef31/Screenshots.jpg)
