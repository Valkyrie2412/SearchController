//
//  TableViewController.swift
//  SearchController
//
//  Created by Hiếu Nguyễn on 8/1/18.
//  Copyright © 2018 Hiếu Nguyễn. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, UISearchResultsUpdating {
    
    
    var arrayCity = ["Hà Nội", "Sài Gòn", "Đà Nẵng", "Đà Lạt", "Ninh Bình"]
    var filteredDataCity = [String]()
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Thiết lập bộ điều khiển tìm kiếm
        navigationItem.searchController = searchController
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailViewController = segue.destination as? ViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            if let index = arrayCity.index(of: filteredDataCity[indexPath.row]) {
                detailViewController?.data = arrayCity[index]
            }
        }
    }
    
    @IBAction func unwind(for unwindSegue: UIStoryboardSegue) {
        if let sourceViewController = unwindSegue.source as? ViewController {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                if let index = arrayCity.index(of: filteredDataCity[selectedIndexPath.row]) {
                    arrayCity[index] = sourceViewController.data!
                    filteredDataCity = arrayCity
                }
            } else {
                // Add a new hero
                arrayCity.append(sourceViewController.data!)
                filteredDataCity = arrayCity
            }
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            if let index = arrayCity.index(of: filteredDataCity[indexPath.row]) {
                arrayCity.remove(at: index)
            }
            filteredDataCity.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        default:
            print("Something")
        }
    }
}
