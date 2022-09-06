//
//  WelcomeViewController.swift
//  SpotifyProject
//
//  Created by 陳飛 on 21/5/2022.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    private lazy var signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.setTitle("Sign in with Spotify", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Spotify"
        self.view.backgroundColor = .green
        self.view.addSubview(signInButton)
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        signInButton.frame = CGRect(x: self.view.safeAreaLayoutGuide.layoutFrame.minX+20,
                                    y: self.view.safeAreaLayoutGuide.layoutFrame.maxY-50,
                                    width: self.view.safeAreaLayoutGuide.layoutFrame.width-40,
                                    height: 50)
    }
    
    @objc
    private func didTapSignIn() {
        let vc = AuthViewController()
        vc.completionHandler = { [weak self] success in
            DispatchQueue.main.async {
                self?.handleSignIn(success: success)
            }
        }
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func handleSignIn(success: Bool) {
        // log user in or yell at them for error
    }
    
}
