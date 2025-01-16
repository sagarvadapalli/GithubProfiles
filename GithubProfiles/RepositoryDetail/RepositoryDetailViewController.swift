//
//  RepositoryDetailViewController.swift
//  GithubProfiles
//
//  Created by Sagar Vadapalli on 1/14/25.
//

import UIKit

class RepositoryDetailViewController: BaseViewController {
    // MARK: - Properties
    private let viewModel: RepositoryDetailViewModel
    
    lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 15)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var ownerNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    lazy var updatedDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 15)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 30
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Initializers
    
    init(viewModel: RepositoryDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        Task{
            await setupUIBind()
        }
        
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        navigationItem.title = viewModel.repo?.name ?? ""
        
        view.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(avatarImageView)
        verticalStackView.addArrangedSubview(ownerNameLabel)
        verticalStackView.addArrangedSubview(descriptionLabel)
        verticalStackView.addArrangedSubview(updatedDateLabel)
        
        let spacerView = UIView()
        spacerView.backgroundColor = .white
        verticalStackView.addArrangedSubview(spacerView)
        
        NSLayoutConstraint.activate([
            avatarImageView.heightAnchor.constraint(equalToConstant: 100),
            avatarImageView.widthAnchor.constraint(equalToConstant: 100),
            verticalStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            verticalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            verticalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            verticalStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 20),
        ])
    }
    
    private func setupUIBind() async {
        if let imageUrl = viewModel.repo?.owner?.imageUrl {
            avatarImageView.image = await viewModel.getAvatarImage(imageUrl)
        } else {
            avatarImageView.image = UIImage(named: "logo")
        }
        
        ownerNameLabel.text = "Owner name: \(viewModel.repo?.owner?.name ?? "")"
        descriptionLabel.text = "Description: \(viewModel.repo?.description ?? "NA")"
        
        let dateString = viewModel.repo?.updatedDate?.toDate()
        updatedDateLabel.text = "Last updated date: \(dateString?.toLocalString() ?? "NA")"
    }
}
