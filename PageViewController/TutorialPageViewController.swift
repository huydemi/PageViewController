//
//  TutorialPageViewController.swift
//  PageViewController
//
//  Created by Dang Quoc Huy on 7/31/17.
//  Copyright © 2017 Dang Quoc Huy. All rights reserved.
//

import UIKit

protocol HangoutCreationPage {
  var isFilled: Bool { get }
  func notifyUI()
}

class TutorialPageViewController: UIPageViewController {
  private(set) lazy var orderedViewControllers: [UIViewController] = {
    return [self.newColoredViewController("1"),
            self.newColoredViewController("2"),
            self.newColoredViewController("3")]
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    dataSource = self
    // set background color to white
    self.view.backgroundColor = UIColor.white
    
    if let firstViewController = orderedViewControllers.first {
      setViewControllers([firstViewController],
                         direction: .forward,
                         animated: true,
                         completion: nil)
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  private func newColoredViewController(_ index: String) -> UIViewController {
    return UIStoryboard(name: "Main", bundle: nil) .
      instantiateViewController(withIdentifier: "Page\(index)VC")
  }

}

// MARK: - UIPageViewControllerDataSource

extension TutorialPageViewController: UIPageViewControllerDataSource {
  
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
    guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
      return nil
    }
    
    let previousIndex = viewControllerIndex - 1
    
    guard previousIndex >= 0 else {
      return nil
    }
    
    guard orderedViewControllers.count > previousIndex else {
      return nil
    }
    
    return orderedViewControllers[previousIndex]
  }
  
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
    guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
      return nil
    }
    
    // check is it OK to move to next page
    if let currentVC = orderedViewControllers[viewControllerIndex] as? HangoutCreationPage {
      if currentVC.isFilled == false {
        currentVC.notifyUI()
        return nil
      }
    }
    
    let nextIndex = viewControllerIndex + 1
    let orderedViewControllersCount = orderedViewControllers.count
    
    guard orderedViewControllersCount != nextIndex else {
      return nil
    }
    
    guard orderedViewControllersCount > nextIndex else {
      return nil
    }
    
    return orderedViewControllers[nextIndex]
  }
  
  func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
    return orderedViewControllers.count
  }
  
  func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
    guard let firstViewController = viewControllers?.first,
      let firstViewControllerIndex = orderedViewControllers.index(of: firstViewController) else {
        return 0
    }
    
    return firstViewControllerIndex
  }
  
}
