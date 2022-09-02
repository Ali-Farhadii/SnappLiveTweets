//
//  UIViewController+Alert.swift
//  Snapp-iOS-HomeTask
//
//  Created by Ali Farhadi on 6/9/1401 AP.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
}
