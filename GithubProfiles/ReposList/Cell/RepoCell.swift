//
//  RepoCell.swift
//  FetchRewardsCodingExercise
//
//  Created by Sagar Vadapalli on 1/14/25.
//

import Foundation

import UIKit

class RepoCell: UITableViewCell {
    static let reuseIdentifier = "RepoCell"
    static let preferredHeight: CGFloat = 120
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var stargazersLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var forksLabel: UILabel!
    var viewModel: RepoCellViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        contentView.backgroundColor = .white
        
    }
    
    /// The configure method for the cell.
    /// - Parameter viewModel: The `RepoCellViewModel` type.
    func configure(with viewModel: RepoCellViewModel) {
        self.viewModel = viewModel
        
        nameLabel.text = viewModel.name
        stargazersLabel.text = "Stars \(viewModel.stargazersCount)"
        descriptionLabel.text = viewModel.description
        languageLabel.text = viewModel.language
        forksLabel.text = "Forks \(viewModel.forksCount)"
    }
}
