//
//  TutorialViewController.swift
//  PageViewController
//
//  Created by Dang Quoc Huy on 7/31/17.
//  Copyright © 2017 Dang Quoc Huy. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController {
  @IBOutlet weak var pageControl: UIPageControl!
  @IBOutlet weak var containerView: UIView!
  
  override var prefersStatusBarHidden: Bool {
    return true
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let tutorialPageViewController = segue.destination as? TutorialPageViewController {
      tutorialPageViewController.tutorialDelegate = self
    }
  }
}

extension TutorialViewController: TutorialPageViewControllerDelegate {
  
  func tutorialPageViewController(_ tutorialPageViewController: TutorialPageViewController, didUpdatePageCount count: Int) {
    pageControl.numberOfPages = count
  }
  
  func tutorialPageViewController(_ tutorialPageViewController: TutorialPageViewController, didUpdatePageIndex index: Int) {
    pageControl.currentPage = index
  }
  
}
