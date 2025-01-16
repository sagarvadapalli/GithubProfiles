//
//  RepoListViewController.swift
//  GithubProfiles
//
//  Created by Sagar Vadapalli on 1/14/25.
//

import UIKit
import Combine

class RepoListViewController: BaseViewController {
    // MARK: - Properties
    private let viewModel: RepoListViewModel
    private let tableView = UITableView()
    private let languagePickerView = UIPickerView()
    private let toolbar = UIToolbar()
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - Initializers
    
    init(viewModel: RepoListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle methods.
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.reset()
        Task {
            await viewModel.fetchRepos()
            await viewModel.fetchLanguages()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
    
    private func setupUI() {
        self.view.addSubview(tableView)
        tableView.backgroundColor = .white
        
        tableView.register(UINib(nibName: RepoCell.reuseIdentifier, bundle: .main),
                           forCellReuseIdentifier: RepoCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        let filterButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(showLanguageDropdown))
        self.navigationItem.rightBarButtonItem  = filterButton
    }
    
    private func bindViewModel() {
        viewModel.$error
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                guard let self = self, let error = error else { return }
                let alert = UIAlertController(title: "Alert!", message: error.rawValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            .store(in: &cancellables)
        
        viewModel.$filteredRepos
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.tableView.reloadData()
            }
            .store(in: &cancellables)
        
        viewModel.$selectedLanguage
            .sink { [weak self] selected in
                guard let self = self, let selectedLanguage = selected else { return }
                if viewModel.currentLanguage != selectedLanguage {
                    viewModel.currentLanguage = selectedLanguage
                    viewModel.reset()
                }
                Task {
                    await self.viewModel.fetchRepos()
                }
            }
            .store(in: &cancellables)
        
        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                guard let self = self else { return }
                if isLoading {
                    self.showLoadingView()
                } else {
                    self.dismissLoadingView()
                }
            }
            .store(in: &cancellables)
    }
    
    @objc private func showLanguageDropdown() {
        let alertController = UIAlertController(title: "Select Language", message: nil, preferredStyle: .actionSheet)
        for language in viewModel.languages {
            let action = UIAlertAction(title: language, style: .default) { [weak self] language in
                guard let self = self, let title = language.title else { return }
                self.viewModel.selectedLanguage = title
            }
            alertController.addAction(action)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource

extension RepoListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RepoCell.reuseIdentifier, for: indexPath) as? RepoCell else {
            return UITableViewCell()
        }
        
        let repo = viewModel.filteredRepos[indexPath.row]
        let viewModel = RepoCellViewModel(repo)
        cell.accessoryType = .disclosureIndicator
        cell.configure(with: viewModel)
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension RepoListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return RepoCell.preferredHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repo = viewModel.filteredRepos[indexPath.row]
        let viewModel = RepositoryDetailViewModel(repo: repo)
        let repositoryDetailViewController = RepositoryDetailViewController(viewModel: viewModel)
        navigationController?.pushViewController(repositoryDetailViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if tableView.isDragging, tableView.isDecelerating || tableView.isTracking,
            indexPath.row == viewModel.filteredRepos.count - 2 {
            Task {
                await viewModel.fetchRepos()
            }
        }
    }
}
