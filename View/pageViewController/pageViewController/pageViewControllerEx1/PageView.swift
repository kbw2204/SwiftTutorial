//
//  PageView.swift
//  pageViewController
//
//  Created by 강병우 on 2020/07/01.
//  Copyright © 2020 강병우. All rights reserved.
//

import UIKit

class PageView: UIView {
    
    // MARK: - Enum
    enum SelectedType {
        case firstView
        case secondView
    }
    
    // MARK: - Property
    private weak var firstButton: UIButton?
    private weak var secondButton: UIButton?
    private weak var selectedLineView: UIView?
    let pageViewController: UIPageViewController = {
        let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        return pageViewController
    }()
    
    // MARK: - Init
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .systemBackground

        let firstButton = UIButton()
        self.firstButton = firstButton
        firstButton.setTitle("첫번째 뷰", for: .normal)
        self.addSubview(firstButton)
        firstButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            firstButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            firstButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16)
        ])
        
        firstButton.addTarget(self, action: #selector(touchButton(_:)), for: .touchUpInside)
        
        let secondButton = UIButton()
        self.secondButton = secondButton
        secondButton.setTitle("두번째 뷰", for: .normal)
        self.addSubview(secondButton)
        secondButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            secondButton.centerYAnchor.constraint(equalTo: firstButton.centerYAnchor),
            secondButton.leadingAnchor.constraint(equalTo: firstButton.trailingAnchor, constant: 20)
        ])
        secondButton.addTarget(self, action: #selector(touchButton(_:)), for: .touchUpInside)
        selectedLabel(.firstView)
        
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(pageViewController.view)
        NSLayoutConstraint.activate([
            pageViewController.view.topAnchor.constraint(equalTo: firstButton.bottomAnchor),
            pageViewController.view.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            pageViewController.view.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            pageViewController.view.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Func
    func getCurrentViewControllerType() -> SelectedType? {
        let currentVC = self.pageViewController.viewControllers?.first
        return currentVC is FirstVC ? .firstView : .secondView
    }
    
    func makeButtonStatus(_ target: UIButton?, isSelected: Bool) {
        guard let target = target else { return }
        let type = isSelected ? "Bold" : "Regular"
        let titleColor: UIColor = isSelected ? .white : .gray
        
        target.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-\(type)", size: 20)
        target.setTitleColor(titleColor, for: .normal)
    }
    
    func selectedLabel(_ selectedType: SelectedType) {
        let isFirstButton = selectedType == .firstView ? true : false
        self.makeButtonStatus(self.firstButton, isSelected: isFirstButton)
        self.makeButtonStatus(self.secondButton, isSelected: !isFirstButton)
    }
    
    func finishAnimation() {
        UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveLinear], animations: {
            if self.pageViewController.viewControllers?[0] as? FirstVC != nil {
                self.selectedLabel(.firstView)
            } else {
                self.selectedLabel(.secondView)
            }
            self.layoutIfNeeded()
        })
    }
    
    @objc func touchButton(_ sender: UIButton) {
        if sender == self.firstButton, getCurrentViewControllerType() != .firstView {
            self.pageViewController.setViewControllers([FirstVC()], direction: .reverse, animated: true)
        } else if sender == self.secondButton, getCurrentViewControllerType() != .secondView {
            self.pageViewController.setViewControllers([SecondVC()], direction: .forward, animated: true)
        }
        finishAnimation()
    }
}
