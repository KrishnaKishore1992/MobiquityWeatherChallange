//
//  HomeViewController.swift
//  WeatherReport
//
//  Created by Kittu Lalli on 05/07/21.
//

import UIKit

class HomeViewController: BaseViewController {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var searchBar: UISearchBar!

    let viewModel: HomeViewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCallBacks()
    }
    
    private func configureCallBacks() {
        
        viewModel.onBookMarksUpdated = { [self] in
            self.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "LocationControllerIdentifier", let locationController = (segue.destination as? UINavigationController)?.children.first as? LocationPickUpViewController {
            locationController.viewModel.onLocationPicked = { [self] in
                self.viewModel.addNew(bookMark: $0)
            }
        }
    }
    
    @IBAction func unwindToHome(_ sender: UIStoryboardSegue) { }
    
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.bookMarkedLocations.count
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        guard editingStyle == .delete else { return }
        
        viewModel.delete(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "\(BookMarkedTableViewCell.self)") as? BookMarkedTableViewCell else {
            return UITableViewCell()
        }
        
        tableViewCell.update(BookMarkedViewModel(model: viewModel.bookMarkedLocations[indexPath.row]))
        
        return tableViewCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "LocationControllerIdentifier", sender: viewModel.bookMarkedLocations[indexPath.row])
    }
}

extension HomeViewController: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        viewModel.mode = .search
        return true
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filter(searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        viewModel.mode = .default
        searchBar.text = ""
        searchBar.endEditing(true)
        tableView.reloadData()
    }
}
