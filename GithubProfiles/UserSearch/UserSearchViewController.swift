//
//  UserSearchViewController.swift
//  GithubProfiles
//
//  Created by Sagar Vadapalli on 1/14/25.
//

import UIKit

class UserSearchViewController: UIViewController {
    // MARK: - Properties
    private let viewModel: UserSearchViewModel
    
    lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Search for a user"
        textField.borderStyle = .roundedRect
        textField.textColor = .black
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 10
        textField.layer.borderColor = UIColor.black.cgColor
        textField.font = .systemFont(ofSize: 15)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var searchButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGray
        button.setTitle("Search", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isEnabled = false
        return button
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

    init(viewModel: UserSearchViewModel = UserSearchViewModel()) {
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
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        navigationItem.title = "Github Profiles"
        searchTextField.delegate = self
        
        view.addSubview(verticalStackView)
        
        verticalStackView.addArrangedSubview(logoImageView)
        verticalStackView.addArrangedSubview(searchTextField)
        
        searchButton.addTarget(self, action: #selector(onSearchButtonTapped), for: .touchUpInside)
        verticalStackView.addArrangedSubview(searchButton)
        
        let spacerView = UIView()
        spacerView.backgroundColor = .white
        verticalStackView.addArrangedSubview(spacerView)
        
        NSLayoutConstraint.activate([
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            verticalStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            verticalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            verticalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            verticalStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 20),
            searchTextField.heightAnchor.constraint(equalToConstant: 60),
            searchButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    @objc func onSearchButtonTapped() {
        let viewModel = RepoListViewModel(searchText: viewModel.searchText)
        let repoListViewController = RepoListViewController(viewModel: viewModel)
        navigationController?.pushViewController(repoListViewController, animated: true)
    }
}

// MARK: - UITextFieldDelegate

extension UserSearchViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text, let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            viewModel.searchText = updatedText
            if viewModel.searchText.isEmpty {
                searchButton.isEnabled = false
                searchButton.backgroundColor = .systemGray
            } else {
                searchButton.isEnabled = true
                searchButton.backgroundColor = .systemBlue
            }
        }
        
        return true
    }
        
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


// Check Alerts error
// Unit test
