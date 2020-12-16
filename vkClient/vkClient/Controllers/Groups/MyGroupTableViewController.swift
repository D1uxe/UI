//
//  MyGroupTableViewController.swift
//  vkClient
//
//  Created by MacBook Pro on 03.11.2020.
//

import UIKit

class MyGroupTableViewController: UITableViewController {
    
    // MARK: - Public Properties
    
    var groups: Groups = Groups(groupList: [])

    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
                let selectedGroup = sourceController.groups.groupList[indexPath.row]
                // если такой группы нет в списке
                if !groups.groupList.contains(where: { $0.name == selectedGroup.name }) {
                    // Добавляем группу в список (в переменную groups этого класса)
                    groups.groupList.append(selectedGroup)
                    // Обновляем таблицу
                    tableView.reloadData()
                }
            }
        }
    }
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return groups.groupList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyGroupTableCell", for: indexPath) as! MyGroupTableViewCell

        let group = groups.groupList[indexPath.row]
        cell.avatarGroupImageView.image = UIImage(named: group.avatar)
        cell.nameGroupLabel.text = group.name

        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            groups.groupList.remove(at: indexPath.row)
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
