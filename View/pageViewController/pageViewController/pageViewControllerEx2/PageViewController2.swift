//
//  PageViewController2.swift
//  pageViewController
//
//  Created by 강병우 on 2020/08/11.
//  Copyright © 2020 강병우. All rights reserved.
//

import UIKit

import SnapKit
import Then

class PageViewController2: UIViewController {

    // MARK: View
    let mainView = UIView().then {
        $0.backgroundColor = .red
    }
    
    let titleLabel = UILabel().then {
        $0.text = "PageViewController"
        $0.numberOfLines = 2
        $0.font = .systemFont(ofSize: 30, weight: .bold)
        $0.textAlignment = .center
    }
    
    let pageControl = UIPageControl().then {
        $0.currentPage = 0
        $0.numberOfPages = 3
    }
    
    let selectButton = UIButton().then {
        $0.setTitle("다음", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .systemPink
        $0.layer.cornerRadius = 28
    }
    
    // MARK: - Property
    var curIndex = 1
    
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
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.width.lessThanOrEqualToSuperview()
        }
        
        mainView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(30)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-200)
        }
        
        pageControl.snp.makeConstraints {
            $0.top.equalTo(mainView.snp.bottom).offset(30)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        selectButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-16)
            $0.centerX.equalTo(view)
            $0.width.equalTo(view).offset(-40)
            $0.height.equalTo(56)
        }
    }
    
    // MARK: - func
    func initPageViewController() {
        let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        pageViewController.dataSource = self
        
        pageViewController.view.frame = mainView.frame
        
        let viewController = [FirstVC()] // 이부분에 왜 하나만 들어갈까? 
        pageViewController.setViewControllers(viewController, direction: .reverse, animated: true, completion: nil)
        
        mainView.addSubview(pageViewController.view)
        self.addChild(pageViewController)
    }
}

extension PageViewController2: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        print("before")
        if viewController as? FirstVC != nil {
            return nil
        }
        
        return FirstVC()
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        print("after")
        if viewController as? SecondVC != nil {
            return nil
        }
        return SecondVC()
    }
}
