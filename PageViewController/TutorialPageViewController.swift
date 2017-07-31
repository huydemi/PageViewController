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

protocol TutorialPageViewControllerDelegate: class {
  
  /**
   Called when the number of pages is updated.
   
   - parameter tutorialPageViewController: the TutorialPageViewController instance
   - parameter count: the total number of pages.
   */
  func tutorialPageViewController(_ tutorialPageViewController: TutorialPageViewController,
                                  didUpdatePageCount count: Int)
  
  /**
   Called when the current index is updated.
   
   - parameter tutorialPageViewController: the TutorialPageViewController instance
   - parameter index: the index of the currently visible page.
   */
  func tutorialPageViewController(_ tutorialPageViewController: TutorialPageViewController,
                                  didUpdatePageIndex index: Int)
  
}

class TutorialPageViewController: UIPageViewController {
  private(set) lazy var orderedViewControllers: [UIViewController] = {
    return [self.newColoredViewController("1"),
            self.newColoredViewController("2"),
            self.newColoredViewController("3")]
  }()
  
  weak var tutorialDelegate: TutorialPageViewControllerDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    dataSource = self
    delegate = self
    
    // set background color to white
    self.view.backgroundColor = UIColor.white
    
    if let firstViewController = orderedViewControllers.first {
      setViewControllers([firstViewController],
                         direction: .forward,
                         animated: true,
                         completion: nil)
    }
    
    tutorialDelegate?.tutorialPageViewController(self, didUpdatePageCount: orderedViewControllers.count)
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
  
}

extension TutorialPageViewController: UIPageViewControllerDelegate {
  
  func pageViewController(_ pageViewController: UIPageViewController,
                          didFinishAnimating finished: Bool,
                          previousViewControllers: [UIViewController],
                          transitionCompleted completed: Bool) {
    if let firstViewController = viewControllers?.first,
      let index = orderedViewControllers.index(of: firstViewController) {
      tutorialDelegate?.tutorialPageViewController(self, didUpdatePageIndex: index)
    }
  }
  
}
