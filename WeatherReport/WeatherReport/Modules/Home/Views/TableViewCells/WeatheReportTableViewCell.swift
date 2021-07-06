//
//  WeatherReportTableViewCell.swift
//  WeatherReport
//
//  Created by Kittu Lalli on 06/07/21.
//

import UIKit

class WeatherReportTableViewCell: UITableViewCell {

    func update(_ viewModel: WeatherViewModel.Report) {
        textLabel?.text = viewModel.title
        detailTextLabel?.text = viewModel.value
        imageView?.image = UIImage(systemName: viewModel.image)
    }
}
