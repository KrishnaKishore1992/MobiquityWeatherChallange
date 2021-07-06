//
//  UnitsSelectionTableViewController.swift
//  WeatherReport
//
//  Created by Kittu Lalli on 06/07/21.
//

import UIKit

class UnitsSelectionTableViewController: UITableViewController {

    @IBOutlet weak var imperialTableViewCell: UITableViewCell!
    @IBOutlet weak var metricTableViewCell: UITableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imperialTableViewCell.accessoryType = Units.type == .imperial ? .checkmark : .none
        metricTableViewCell.accessoryType = Units.type == .metrics ? .checkmark : .none
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let tableViewCell = tableView.cellForRow(at: indexPath)

        imperialTableViewCell.accessoryType = tableViewCell == imperialTableViewCell ? .checkmark : .none
        metricTableViewCell.accessoryType = tableViewCell == imperialTableViewCell ? .none : .checkmark
        Units.type = tableViewCell == imperialTableViewCell ? .imperial : .metrics
    }
}
