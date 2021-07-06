//
//  HomeViewModel.swift
//  WeatherReport
//
//  Created by Kittu Lalli on 05/07/21.
//

import Foundation

class HomeViewModel {
    
    enum ScreenMode {
        case search, `default`
    }
    
    private var _bookMarkedLocations: [BookMarkedModel] = []
    private var _searchedLocations: [BookMarkedModel] = []
    
    var bookMarkedLocations: [BookMarkedModel] {
        switch mode {
        case .search:
            return _searchedLocations
        case .default:
            return _bookMarkedLocations
        }
    }
    
    var onBookMarksUpdated: (() -> Void)?
    var mode: ScreenMode = .default
    
    func addObservers() {
        NotificationCenter.default.addObserver(forName: .clearBookMarkedLocations, object: nil, queue: .main) { [weak self] (_) in
            self?._bookMarkedLocations.removeAll()
            self?.onBookMarksUpdated?()
        }
    }
    
    func addNew(bookMark: BookMarkedModel) {
        _bookMarkedLocations.append(bookMark)
        onBookMarksUpdated?()
    }
    
    func delete(at indexPath: IndexPath) {
        _bookMarkedLocations.remove(at: indexPath.row)
        onBookMarksUpdated?()
    }
    
    func filter(_ searchText: String) {
        _searchedLocations = _bookMarkedLocations.filter { $0.name?.localizedCaseInsensitiveContains(searchText) ?? false }
        onBookMarksUpdated?()
    }
}
