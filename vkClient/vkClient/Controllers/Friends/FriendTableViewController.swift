//
//  FriendTableViewController.swift
//  vkClient
//
//  Created by MacBook Pro on 01.11.2020.
//

import UIKit

class FriendTableViewController: UITableViewController {
    
    // MARK: - Private Properties

    private var friends: Friends = Friends()
    private var friendDictionary = [String: [Friend]]()
    private var sectionTitles: [String] {
        friendDictionary.keys.sorted()
    }
    

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // проинициализируем словарь где ключ - первая буква слова
        friendDictionary = Dictionary(grouping: friends.friendsList, by: { String($0.name.prefix(1)) })
    }
    

    // MARK: - Public Methods

    // передадим данные в FriendCollectionVewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard segue.identifier == "showFriendPhoto" else { return }
        guard let destinationController = segue.destination as? FriendCollectionViewController else { return }
        if let indexPath = tableView.indexPathForSelectedRow {
            if let friend = friendDictionary[sectionTitles[indexPath.section]] {
                destinationController.friendPhoto = friend[indexPath.row].photo
            }
        }
    }

    
    
    
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sectionTitles.count
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return friendDictionary[sectionTitles[section]]?.count ?? 0

        let letter = sectionTitles[section]
        if let friend = friendDictionary[letter] {
            return friend.count
        }

        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendTableCell", for: indexPath) as! FriendTableViewCell

        let letter = sectionTitles[indexPath.section]
        if let friend = friendDictionary[letter] {
            cell.friendAvatarImageView.image = UIImage(named: friend[indexPath.row].avatar)
            cell.friendNameLabel.text = friend[indexPath.row].name
        }

        return cell
    }

    //To display a header title in each section
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return sectionTitles[section]
    }

    
    //To add an indexed table view
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        
        return sectionTitles
    }

    
    
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
         // Return false if you do not want the specified item to be editable.
         return true
     }
     */

    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
         if editingStyle == .delete {
             // Delete the row from the data source
             tableView.deleteRows(at: [indexPath], with: .fade)
         } else if editingStyle == .insert {
             // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
         }
     }
     */

    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

     }
     */

    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
         // Return false if you do not want the item to be re-orderable.
         return true
     }
     */
}
