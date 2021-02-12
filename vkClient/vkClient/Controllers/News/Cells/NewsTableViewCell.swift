//
//  NewsTableViewCell.swift
//  vkClient
//
//  Created by MacBook Pro on 15.11.2020.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    //MARK: - IBOutlets
    
    @IBOutlet weak var friendAvatarView: AvtarView!
    @IBOutlet weak var friendNameLabel: UILabel!
    @IBOutlet weak var newsTimeLabel: UILabel!
    @IBOutlet weak var newsTextLabel: UILabel!
    @IBOutlet weak var newsPhotoImageView: UIImageView!
    
    
    
    // MARK: - Public Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.friendNameLabel.text = nil
        self.friendAvatarView.image = nil
        
        self.newsTextLabel.text = nil
        self.newsPhotoImageView.image = nil
       // self.newsTimeLabel.text = nil
        
        
    }
    
        
    func configure(friendName: String, avatar: String, newsText: String, newsPhoto: String ) {
            
            self.friendNameLabel.text = friendName
            self.friendAvatarView.image = UIImage(named: avatar)
            self.newsTextLabel.text = newsText
            self.newsPhotoImageView.image = UIImage(named: newsPhoto)
        }
        

    

}
