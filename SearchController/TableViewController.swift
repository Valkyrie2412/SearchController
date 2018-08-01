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
        
    }
    
    
    // MARK: - Private instance methods
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filteredDataCity = arrayCity.filter({ (arrayCity: String) -> Bool in
            if arrayCity.contains(searchController.searchBar.text!) {
                return true
            } else {
                return false
            }
        })
        tableView.reloadData()
    }
    
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        if searchController.isActive {
        if isFiltering() {
            return filteredDataCity.count
        } else {
            return arrayCity.count
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        //        if searchController.isActive {
        if isFiltering() {
            cell.textLabel?.text = filteredDataCity[indexPath.row]
        } else {
            cell.textLabel?.text = arrayCity[indexPath.row]
        }
        return cell
    }
    
}
