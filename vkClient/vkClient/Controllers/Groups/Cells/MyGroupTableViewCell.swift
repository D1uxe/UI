//
//  MyGroupTableViewCell.swift
//  vkClient
//
//  Created by MacBook Pro on 03.11.2020.
//

import UIKit

class MyGroupTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet var avatarGroupImageView: UIImageView!
    @IBOutlet var nameGroupLabel: UILabel!

    
    // MARK: - Public Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(groupName: String?, groupAvatar: UIImage?) {
        self.nameGroupLabel.text = groupName
        self.avatarGroupImageView.image = groupAvatar
    }

}
