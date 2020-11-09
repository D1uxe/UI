//
//  FriendTableViewCell.swift
//  vkClient
//
//  Created by MacBook Pro on 01.11.2020.
//

import UIKit

class FriendTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet var friendAvatarImageView: UIImageView!
    @IBOutlet var friendNameLabel: UILabel!

    
    // MARK: - Public Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
