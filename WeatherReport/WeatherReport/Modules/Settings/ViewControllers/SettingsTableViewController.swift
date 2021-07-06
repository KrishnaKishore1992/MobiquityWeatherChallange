//
//  SettingsTableViewController.swift
//  WeatherReport
//
//  Created by Kittu Lalli on 06/07/21.
//

import UIKit

class SettingsTableViewController: UITableViewController, AlertMessagesProtocol {

    @IBOutlet private var unitsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        unitsLabel.text = Units.type.rawValue.capitalized
        configureObservers()
    }
    
    private func configureObservers() {
        
        NotificationCenter.default.addObserver(forName: .unitsChanged, object: nil, queue: .main) { [weak self] (_) in
            self?.unitsLabel.text = Units.type.rawValue.capitalized
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard indexPath.row == 0 else { return }

        NotificationCenter.default.post(name: .clearBookMarkedLocations, object: nil)
        showAlertwithTitle(message: "Your Bookmarked locations are cleared.")
    }
}
