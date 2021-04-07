//
//  FriendTableViewController.swift
//  vkClient
//
//  Created by MacBook Pro on 01.11.2020.
//

import UIKit
import RealmSwift

class FriendTableViewController: UITableViewController {
    

    // MARK: - Private Properties

    private var token: NotificationToken?
    private var friends: Results<Friend>?//[Friend] = []
    private var friendDictionary = [String: [Friend]]()
    private var sectionTitles: [String] {
        friendDictionary.keys.sorted()
    }
    private var originFriendDictionary: [String: [Friend]] = [:]
    private lazy var imageService = ImageService(container: self.tableView)


    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureRealmNotification()
        RealmService.updateFriendsInRealmByPromise()
    }


    //MARK: - Private Methods

    fileprivate func configureRealmNotification() {

        guard let realm = try? Realm() else { return }

        self.friends = realm.objects(Friend.self)

        self.token = friends?.observe({ [weak self] (changes: RealmCollectionChange) in

            switch changes {
                case .initial,.update:
                    self?.friendDictionary = Dictionary(grouping: (self?.friends)!, by: { String($0.firstName.prefix(1)) })
                    self?.originFriendDictionary = self?.friendDictionary ?? [:]
                    self?.tableView.reloadData()
                case .error(let error):
                    fatalError("Realm notification error \(error)")
            }
        })

    }


    // MARK: - Public Methods

    // передадим данные в FriendCollectionVewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard segue.identifier == "showFriendPhoto" else { return }
        guard let destinationController = segue.destination as? FriendCollectionViewController else { return }
        if let indexPath = tableView.indexPathForSelectedRow {
            if let friend = friendDictionary[sectionTitles[indexPath.section]] {
                destinationController.friendId = friend[indexPath.row].id
            }
        }
    }

    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

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

        let friendsByFirstLetter = friendDictionary[letter]

        if let friends = friendsByFirstLetter?[indexPath.row] {

                let fullName = friends.firstName + " " + friends.lastName
                let avatar = imageService.getPhoto(atIndexpath: indexPath, byUrl: friends.avatarURL)

                cell.configure(friendName: fullName, friendAvatar: avatar)
        }

        return cell
    }


    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = UILabel()
        header.layer.backgroundColor = ColorFlyWeight.tableViewColor.cgColor
        header.font = UIFont.boldSystemFont(ofSize: 17)

        header.text = "    " + String(sectionTitles[section].uppercased())
        return header
    }
    
    
    //To display a header title in each section
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return sectionTitles[section]
    }

    
    //To add an indexed table view
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        
        return sectionTitles
    }

    /* didHighlightRowAt
    override func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {

        /* работает
        let cell = tableView.cellForRow(at: indexPath) as! FriendTableViewCell

        UIView.animate(withDuration: 0.2,
                       delay: 0,
                       usingSpringWithDamping: 0.3,
                       initialSpringVelocity: 1.0,
                       options: [],
                       animations: { () -> Void in
                           let scale = CGAffineTransform(scaleX: 0.95, y: 0.95)
                           cell.friendAvatarImageView.transform = scale
                           cell.friendAvatarShadowView.transform = scale
                       },
                       completion: { _ in
                           cell.friendAvatarImageView.transform = .identity
                           cell.friendAvatarShadowView.transform = .identity
                       })
         */
    }
 */

    /* didSelect
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let cell = tableView.cellForRow(at: indexPath) as! FriendTableViewCell

        print(cell.friendNameLabel!.text!)

    }
   */

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


// MARK: - Search Bar Delegate

extension FriendTableViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       
        friendDictionary = searchText.isEmpty ? originFriendDictionary : originFriendDictionary
            .mapValues({ $0.lazy.filter({ $0.firstName
                    .lowercased()
                    .contains(searchText.lowercased()) }) })
            .filter({ !$0.value.isEmpty })
        tableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        friendDictionary = originFriendDictionary
        tableView.reloadData()
        
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
        
        
    }
    
}
