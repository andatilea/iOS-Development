//
//  UIViewController+ErrorHandling.swift
//  Pandemify
//
//  Created by Anda Tilea on 24.08.2021.
//

import UIKit

extension UIViewController {
    func showErrorAlert(for error: Error?, spinner: UIActivityIndicatorView!) {
        let alertController = UIAlertController(title: "Error",
                                                message: error?.localizedDescription,
                                                preferredStyle: .alert)
        DispatchQueue.main.async {
            self.present(alertController, animated: true)
            spinner.stopAnimating()
            spinner.hidesWhenStopped = true
        }
    }
}
