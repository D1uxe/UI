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

    private lazy var imageService = ImageService(container: self.tableView)
    private var token: NotificationToken?

    private let factory = GroupViewModelFactory()
    private var viewModels: [GroupViewModel] = []

    // MARK: - Public Properties

    var groups: Results<Group>?

    
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

        self.viewModels = self.factory.constructViewModels(from: Array(self.groups!))

        token = self.groups?.observe({ [weak self] (changes: RealmCollectionChange) in

            guard let tableView = self?.tableView else { return }
            
            switch changes {
                case .initial(_):

                    self?.viewModels = (self?.factory.constructViewModels(from: Array((self?.groups!)!)))!

                    tableView.reloadData()
                case .update(_, deletions: let deletions,
                             insertions: let insertions,
                             modifications: let modifications):

                    self?.viewModels = (self?.factory.constructViewModels(from: Array((self?.groups!)!)))!

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
     
    
    //MARK: - IBAction
    
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

        let vm = self.viewModels[indexPath.row]

        let avatar = imageService.getPhoto(atIndexpath: indexPath, byUrl: vm.groupAvatarURL)
        
        cell.configure(with: vm, groupAvatar: avatar)

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
    
}
