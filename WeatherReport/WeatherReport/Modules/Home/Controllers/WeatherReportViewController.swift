//
//  WeatherReportViewController.swift
//  WeatherReport
//
//  Created by Kittu Lalli on 06/07/21.
//

import UIKit

class WeatherReportViewController: UIViewController, AlertMessagesProtocol {

    @IBOutlet private weak var tableView: UITableView!
    
    let viewModel: WeatherReportViewModel = WeatherReportViewModel<NetworkManger>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        observeOnUnitsAndBookMarksChange()
        viewModel.startObserveOnUnitsChange()
        configureAndFetchWeatherReport()
    }
    
    private func observeOnUnitsAndBookMarksChange() {
        NotificationCenter.default.addObserver(forName: .clearBookMarkedLocations, object: nil, queue: .main) { [weak self] (_) in
            self?.navigationController?.popViewController(animated: false)
        }

        NotificationCenter.default.addObserver(forName: .unitsChanged, object: nil, queue: .main) { [weak self] (_) in
            self?.navigationController?.popViewController(animated: false)
        }
    }
    
    private func configureAndFetchWeatherReport() {

        viewModel.onViewModelUpdated = { [self] in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        viewModel.fetchWeatherDetails { [self] (error) in
            DispatchQueue.main.async {
                guard error == nil else {
                    self.showAlertwithTitle(message: error?.localizedDescription ?? "Unable to reach our servers. Please try again.")
                    return
                }
            }
        }
    }
    
    @IBAction private func segmentControlChanged(_ sender: UISegmentedControl) {
        viewModel.reportType = sender.selectedSegmentIndex == 0 ? .weather : .forecast
    }
}

extension WeatherReportViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.weatherViewModel?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.weatherViewModel?[section].reports.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        viewModel.weatherViewModel?[section].date
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "\(WeatherReportTableViewCell.self)") as? WeatherReportTableViewCell, let report = viewModel.weatherViewModel?[indexPath.section].reports[indexPath.row] else {
            return UITableViewCell()
        }
        
        tableViewCell.update(report)
        return tableViewCell
    }
}
