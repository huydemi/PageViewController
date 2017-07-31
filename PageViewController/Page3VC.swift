//
//  Page3VC.swift
//  PageViewController
//
//  Created by Dang Quoc Huy on 7/31/17.
//  Copyright © 2017 Dang Quoc Huy. All rights reserved.
//

import UIKit

class Page3VC: UIViewController {
}

extension Page3VC: HangoutCreationPage {
  internal func notifyUI() {
    view.backgroundColor = UIColor.red
  }
  
  var isFilled: Bool {
    get {
      return true
    }
  }
}
