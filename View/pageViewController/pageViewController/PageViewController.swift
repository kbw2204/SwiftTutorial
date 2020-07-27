//
//  ViewController.swift
//  pageViewController
//
//  Created by 강병우 on 2020/07/01.
//  Copyright © 2020 강병우. All rights reserved.
//

import UIKit

class PageViewController: UIViewController {
    
    // MARK: - Property
    var pageView: PageView {
        guard let mainView = self.view as? PageView else {
            fatalError()
        }
        return mainView
    }
    
    // MARK: - View Life Cycle
    override func loadView() {
        let view = PageView()
        view.backgroundColor = .black
        self.view = view
        view.pageViewController.setViewControllers([FirstVC()], direction: .forward, animated: false)
        view.pageViewController.dataSource = self
        view.pageViewController.delegate = self
        self.addChild(view.pageViewController)
        view.pageViewController.didMove(toParent: self)
        
    }
}

// MARK: - Extension
extension PageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if viewController as? FirstVC != nil {
            return nil
        }
        
        return FirstVC()
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if viewController as? SecondVC != nil {
            return nil
        }
        
        return SecondVC()
    }
}

extension PageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            self.pageView.finishAnimation()
        }
    }
}
