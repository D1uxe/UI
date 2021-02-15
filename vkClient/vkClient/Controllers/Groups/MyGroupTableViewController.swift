//
//  MyGroupTableViewController.swift
//  vkClient
//
//  Created by MacBook Pro on 03.11.2020.
//

import UIKit
import RealmSwift

class MyGroupTableViewController: UITableViewController {

    //MARK: - Private Properties

    private let imageService = ImageService()
    private var token: NotificationToken?


    // MARK: - Public Properties

    var groups: Results<Group>?//[Group] = []

    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureRealmNotification()
        RealmService.updateGroupsInRealm()
    }


    //MARK: - Private Methods

    fileprivate func configureRealmNotification() {
        
        guard let realm = try? Realm() else { return }
        
        self.groups = realm.objects(Group.self)
        
        token = self.groups?.observe({ [weak self] (changes: RealmCollectionChange) in

            guard let tableView = self?.tableView else { return }
            
            switch changes {
                case .initial(_):
                    tableView.reloadData()
                case .update(_, deletions: let deletions,
                             insertions: let insertions,
                             modifications: let modifications):
                    tableView.beginUpdates()
                    
                    tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}), with: .automatic)
                    tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0)}), with: .automatic)
                    tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0)}), with: .automatic)
                    
                    tableView.endUpdates()
                    
                case .error(let error):
                    fatalError("Realm notification error \(error)")
            }
        })

    }
     
    
    // MARK: - Public Methods
    
    // Получим данные из контроллера AllGroupsTableViewController
    @IBAction func addGroupToMyGroups(unwindSegue: UIStoryboardSegue) {

        // проверим что переход произошел именно по клику из таблицы "все группы"
        if unwindSegue.identifier == "addGroup" {
            // запоминаем контроллер, который пришел
            guard let sourceController = unwindSegue.source as? AllGroupTableViewController else { return }
            // получаем индекс выделенной ячейки
            if let indexPath = sourceController.tableView.indexPathForSelectedRow {
                // Получаем группу из переменной groups источника по индексу
                let selectedGroup = sourceController.groups[indexPath.row]
                // отправим запрос на вступление в группу
                QueryGroups.join(groupId: selectedGroup.id, completion: { [weak self] result in
                    if result == 1 {
                        if selectedGroup.isClosed == 1 {
                            self?.showAlert(title: "Сообщение", message: "Заявка на вступление в группу отправлена")
                        }
                        RealmService.updateGroupsInRealm()

                        /* FireBase
                        Database.database().reference(withPath: "authorized_users").child(String(Session.shared.userId!)).child(String(selectedGroup.id)).setValue(["name" :selectedGroup.name])
                         */
                    }
                })
            }
        }

    }
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return groups?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyGroupTableCell", for: indexPath) as! MyGroupTableViewCell

        guard let group = groups?[indexPath.row] else { return cell }
        imageService.getPhoto(byURL: group.avatarURL, completion: {  avatar in
            cell.configure(groupName: group.name, groupAvatar: avatar)
        })

        return cell
    }

    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {
            if let selectedGroup = groups?[indexPath.row] {
                QueryGroups.leave(groupId: selectedGroup.id, completion: { [weak self] result in
                    if result == 1  {
                        RealmService.updateGroupsInRealm()
                    } else {
                        self?.showAlert(title: "Сообщение", message: "Ошибка запроса")
                    }
                })
            }
        }

    }

    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
         // Return false if you do not want the specified item to be editable.
         return true
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

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
     }
     */
    
}
