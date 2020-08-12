//
//  ViewController.swift
//  pageViewControllerSubView
//
//  Created by 강병우 on 2020/08/12.
//  Copyright © 2020 강병우. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: View
    private let mainView: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label: UILabel = UILabel()
        
        label.text = "PageViewController"
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.textAlignment = .center
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl: UIPageControl = UIPageControl()
                
        pageControl.currentPage = 0
        pageControl.numberOfPages = 2
        pageControl.backgroundColor = .blue
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        
        return pageControl
    }()
    
    private var selectButton: UIButton = {
        let button: UIButton = UIButton()
        
        button.setTitle("다음", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemPink
        button.layer.cornerRadius = 28
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    // MARK: - Property
    var curIndex = 0
    
    // MARK: - View Life Cycle
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .systemBackground
        self.view = view
        
        [titleLabel, mainView, pageControl, selectButton].forEach {
            view.addSubview($0)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setConstraint()
        initPageViewController()
    }
    
    func setConstraint() {
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            mainView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -200)
        ])
        
        NSLayoutConstraint.activate([
            pageControl.topAnchor.constraint(equalTo: mainView.bottomAnchor, constant: 30),
            pageControl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            pageControl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            selectButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            selectButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            selectButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40),
            selectButton.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
    
    // MARK: - func
    func initPageViewController() {
        let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        pageViewController.dataSource = self
        pageViewController.delegate = self
        
        pageViewController.view.frame = mainView.frame
        
        let viewController = [FirstViewController()] // 이부분에 왜 하나만 들어갈까?
        pageViewController.setViewControllers(viewController, direction: .reverse, animated: true, completion: nil)
        
        mainView.addSubview(pageViewController.view)
        self.addChild(pageViewController)
    }
}

extension ViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        print("before")

        if viewController as? FirstViewController != nil {
            return nil
        }
        
        return FirstViewController()
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        print("after")

        if viewController as? SecondViewController != nil {
            return nil
        }
        
        return SecondViewController()
    }
}

extension ViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            if let currentViewController = pageViewController.viewControllers?[0] as? FirstViewController {
                pageControl.currentPage = currentViewController.index
            } else if let currentViewController = pageViewController.viewControllers?[0] as? SecondViewController {
                pageControl.currentPage = currentViewController.index
            }
        }
    }
}
