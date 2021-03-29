//
//  AllGroupTableViewController.swift
//  vkClient
//
//  Created by MacBook Pro on 03.11.2020.
//

import UIKit

class AllGroupTableViewController: UITableViewController {

    //MARK: - Private Properties

    private lazy var imageService = ImageService(container: self.tableView)


    // MARK: - Public Properties

    var groups = [Group]()
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

        
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return groups.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AvailableGroupTableCell", for: indexPath) as! AllGroupTableViewCell

        let group = groups[indexPath.row]

        let avatar = imageService.getPhoto(atIndexpath: indexPath, byUrl: group.avatarURL)

        cell.configure(groupName: group.name, groupAvatar: avatar)

        return cell
    }

}


//MARK: - Search Bar

extension AllGroupTableViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.searchTextField.text else { return }

        QueryGroups.search(group: searchText, completion: { [weak self] groups in
            self?.groups = groups
            self?.tableView.reloadData()
        })

    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        groups.removeAll()
        tableView.reloadData()
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
}
