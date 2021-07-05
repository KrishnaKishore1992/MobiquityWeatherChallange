//
//  AlertManagerProtocol.swift
//  WeatherReport
//
//  Created by Kittu Lalli on 05/07/21.
//

import UIKit

protocol AlertMessagesProtocol { }

extension AlertMessagesProtocol where Self: UIViewController {
    
    func showAlertwithTitle(title: String = "Warning..!", message: String, actions: [UIAlertAction]? = nil) {
        let alerController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if let actions = actions {
            actions.forEach { alerController.addAction($0) }
        } else {
            let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alerController.addAction(cancelAction)
        }
        present(alerController, animated: true, completion: nil)
    }
}
