//
//  BaseViewController.swift
//  GithubProfiles
//
//  Created by Sagar Vadapalli on 1/15/25.
//

import UIKit

class BaseViewController: UIViewController {
    
    fileprivate var containerView = UIView()
    
    lazy var activityIndicator : UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.tintColor = .white
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        
        self.view.addSubview(containerView)
        
        containerView.backgroundColor = .systemGray4
        containerView.alpha = 0
        
        UIView.animate(withDuration: 0.25) {
            self.containerView.alpha = 0.8
        }
        
        containerView.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
        
        activityIndicator.startAnimating()
    }
    
    func dismissLoadingView() {
        activityIndicator.stopAnimating()
        
        DispatchQueue.main.async {
            self.containerView.removeFromSuperview()
        }
    }
}
