//
//  HolidayTableViewController.swift
//  Holidays
//
//  Created by Анастасия Улитина on 28.11.2020.
//

import UIKit

class HolidayTableViewController: UITableViewController {
    
    var listOfHolidays = [HolidayDetail]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.navigationItem.title = "\(self.listOfHolidays.count) Holidays found"
            }
        }
    }
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        
    }
    
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfHolidays.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "holiCell", for: indexPath)
        let holiday = listOfHolidays[indexPath.row]
        print(holiday)
        cell.textLabel?.text = holiday.name
        cell.detailTextLabel?.text = holiday.date.iso
        return cell
    }
    
}

//MARK: - Searchbar method
extension HolidayTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchBarText = searchBar.text else { return }
        let holidayRequest = HolidayManager(countryCode: searchBarText)
        holidayRequest.getHolidays { [weak self] result in
            switch result {
            case .success(let holidays):
                self?.listOfHolidays = holidays
            case .failure(let error):
                print(error)
            }
        }
    }
}
