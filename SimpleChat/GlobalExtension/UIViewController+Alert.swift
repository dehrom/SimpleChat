//
//  UIViewController+Alert.swift
//  SimpleChat
//
//  Created by Valery Kokanov on 12.12.16.
//  Copyright © 2016 dehrom. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {

    func showAlertViewController(WithTitle title: String, Message text: String, andBlock handler: (() -> Void)? = nil) {
        let alertVC = UIAlertController(title: title, message: text, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { _ in
            guard handler != nil else { return }
            handler!()
        }))
        show(alertVC, sender: self)
    }

}
