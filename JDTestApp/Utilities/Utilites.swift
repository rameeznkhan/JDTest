//
//  Utilites.swift
//  JDTestApp
//
//  Created by Rameez khan  on 15/06/19.
//  Copyright © 2019 Rameez khan . All rights reserved.
//

import UIKit
extension UIViewController {
  
  func presentAlert(title: String, message: String, completion: (()->())? = nil) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let cancelAction = UIAlertAction(title: "Ok", style: .default)
    alertController.addAction(cancelAction)
    self.present(alertController, animated: true, completion: nil)
  }
}

enum FileError: Error {
  case fileNotFound
}

extension FileError: LocalizedError {
  var errorDescription: String? {
    switch self {
    case .fileNotFound:
      return NSLocalizedString("File not Found", comment: "")
    }
  }
}

