//
//  TableViewController.swift
//  SearchController
//
//  Created by Hiếu Nguyễn on 8/1/18.
//  Copyright © 2018 Hiếu Nguyễn. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, UISearchResultsUpdating {
    
    let arrayCity = ["Hà Nội", "Sài Gòn", "Đà Nẵng", "Đà Lạt", "Ninh Bình"]
    var filteredDataCity = [String]()
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Thiết lập bộ điều khiển tìm kiếm
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search something"
        definesPresentationContext = true
        filteredDataCity = arrayCity
    }
    
    
    // MARK: - Private instance methods
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        filteredDataCity = searchText.isEmpty ? (arrayCity) : (arrayCity.filter({ (city) -> Bool in
            return city.lowercased().contains(searchText.lowercased())
        }))
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredDataCity.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = filteredDataCity[indexPath.row]
        return cell
    }
    
}
