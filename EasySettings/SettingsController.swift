//
//  SettingsController.swift
//  Comic_Collector
//
//  Created by Dennis Müller on 13.04.18.
//  Copyright © 2018 Dennis Müller. All rights reserved.
//

import UIKit
import IGListKit
import CoreData
import SwifterSwift

class SettingsController: UIViewController, UINavigationControllerDelegate {
    
    // MARK: - Properties
    // ========== PROPERTIES ==========
    public var rootSettingsPage: SettingsBaseClass!
    public var pageController: UINavigationController?
    
    lazy var topView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: 0x222222)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(view)
        return view
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(view)
        return view
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "backArrow"), for: UIControl.State.normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(backButtonTapped(_:)), for: UIControl.Event.touchUpInside)
        
        topView.addSubview(button)
        return button
    }()
    
    lazy var closeButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(closeButtonTapped(_:)), for: UIControl.Event.touchUpInside)
        
        topView.addSubview(button)
        return button
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = UIColor(hex: 0xeeeeee)
        label.text = "Comic Book Settings"
        
        topView.addSubview(label)
        return label
    }()
    
    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10)
        label.textColor = UIColor(hex: 0x888888)
        label.text = "Tap to close"
        
        topView.addSubview(label)
        return label
    }()
    // ====================
    
    // MARK: - Initializers
    // ========== INITIALIZERS ==========
    convenience init(withRootSettingsPage rootSettingsPage: SettingsBaseClass) {
        self.init()
        self.rootSettingsPage = rootSettingsPage
    }
    // ====================
    
    // MARK: - Overrides
    // ========== OVERRIDES ==========
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: 0x222222)
        
        pageController = UINavigationController(rootViewController: rootSettingsPage)
        pageController?.isNavigationBarHidden = true
        pageController?.delegate = self
        //pageController?.interactivePopGestureRecognizer?.delegate = self
        pageController?.interactivePopGestureRecognizer?.isEnabled = true
        addChild(pageController!)
        pageController?.didMove(toParent: self)
        
        contentView.addSubview(pageController!.view)
        pageController!.view.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        topView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.trailing.equalToSuperview()
            make.height.equalTo(40)
        }
        
        contentView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.top.equalTo(self.topView.snp.bottom)
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(35)
        }
        
        subtitleLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-1)
            make.height.equalTo(15)
        }
        
        backButton.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.width.equalTo(60)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalToSuperview()
        }
        
        backButton.transform = CGAffineTransform(translationX: -60, y: 0)
        
        closeButton.snp.makeConstraints { (make) in
            make.leading.equalTo(self.backButton.snp.trailing)
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    // ====================
    
    
    // MARK: - Functions
    // ========== FUNCTIONS ==========
    @objc private func closeButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func backButtonTapped(_ sender: UIButton) {
        pageController?.popViewController(animated: true)
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        titleLabel.text = pageController?.topViewController?.title
        UIView.animate(withDuration: 0.2) {
            if viewController == self.pageController!.viewControllers.first! {
                self.backButton.transform = CGAffineTransform(translationX: -60, y: 0)
            } else {
                self.backButton.transform = .identity
            }
        }
    }
    // ====================

}
