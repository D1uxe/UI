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


    // MARK: - Public Properties

    var groups: [Group] = []

    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.loadData()
        self.updateGroups()
    }


    //MARK: - Private Methods

    fileprivate func updateGroups() {
        QueryGroups.get(completion: { [weak self] groups in
            //self?.groups = groups
            self?.loadData()
            self?.tableView.reloadData()
        })
    }

    fileprivate func loadData() {

        self.groups = RealmService.loadData(of: Group.self)
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
                    guard result == 1 else {
                        self?.showAlert(title: "Сообщение", message: "Запрос на вступление в группу отклонен")
                        return
                    }
                    self?.updateGroups()
                })
            }
        }

    }
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return groups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyGroupTableCell", for: indexPath) as! MyGroupTableViewCell

        let group = groups[indexPath.row]
        imageService.getPhoto(byURL: group.avatarURL, completion: {  avatar in
            cell.configure(groupName: group.name, groupAvatar: avatar)
        })

        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {
            let selectedGroup = groups[indexPath.row]
            QueryGroups.leave(groupId: selectedGroup.id, completion: { [weak self] result in
                guard result == 1 else {
                    self?.showAlert(title: "Сообщение", message: "Ошибка запроса")
                    return
                }
            })
            groups.remove(at: indexPath.row)
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
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
