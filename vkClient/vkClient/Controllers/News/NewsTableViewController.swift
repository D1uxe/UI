//
//  NewsTableViewController.swift
//  vkClient
//
//  Created by MacBook Pro on 15.11.2020.
//

import UIKit

class NewsTableViewController: UITableViewController {

    
    var news = [(authorName: "Брюс Hulk Бэннер", authorAvatar: "Hulk", newsPhoto: "Hulk_news", newsText: """
                    Я расклеился. Не знал куда деться и вот пустил себе пулю в рот, но другой я тут же сплюнул её. Потом я двинулся дальше, стал помогать людям и был хорош... Пока вы не затащили меня в этот цирк уродцев. Хотите узнать мой секрет агент Романофф, как я остаюсь спокойным?
                    """),
                (authorName: "Тони Старк", authorAvatar: "IronMan", newsPhoto: "IronMan_news", newsText: """
                                Скучали по мне? Я тоже по вам скучал. Я не говорю, что мы уже годы живем в атмосфере надежного мира благодаря мне. Я не говорю, что после плена, восстав из пепла, я подтвердил миф о фениксе, как никто прежде в истории человечества. Я не говорю, что дядя Сэм может расслабиться в шезлонге, попивая холодный чай, потому что на этой планете нет ни одного соперника, у которого хватило бы сил со мной потягаться. Но речь не обо мне. И не о вас. И даже не о нас всех. Речь идет о наследии. О том, что мы оставим будущим поколениям. И потому в течение следующего года, впервые с 1974-го, самые светлые умы разных государств и корпораций со всего мира объединят усилия и покажут нам свое видение того, как построить лучшее будущее. Речь идет не о нас. Поэтому то, что я говорю, если я вообще что-то говорю, это - с возвращением на "Старк Экспо".
                                """)
    ]
    
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    
    
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return news.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableCell", for: indexPath) as! NewsTableViewCell

        let mynews = news[indexPath.row]
        
        cell.configure(friendName: mynews.authorName,
                       avatar: mynews.authorAvatar,
                       newsText: mynews.newsText,
                       newsPhoto: mynews.newsPhoto)

        return cell
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
