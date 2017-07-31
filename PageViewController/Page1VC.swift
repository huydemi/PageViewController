//
//  Page1VC.swift
//  PageViewController
//
//  Created by Dang Quoc Huy on 7/31/17.
//  Copyright © 2017 Dang Quoc Huy. All rights reserved.
//

import UIKit

class Page1VC: UIViewController {
}

extension Page1VC: HangoutCreationPage {
  internal func notifyUI() {
    view.backgroundColor = UIColor.red
  }

  var isFilled: Bool {
    get {
      return true
    }
  }
}
