//
//  BookMarkedTableViewCell.swift
//  WeatherReport
//
//  Created by Kittu Lalli on 05/07/21.
//

import UIKit

class BookMarkedTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    func update(_ viewModel: BookMarkedViewModel) {
        titleLabel.text = viewModel.name
        descLabel.text = viewModel.description
    }
}
