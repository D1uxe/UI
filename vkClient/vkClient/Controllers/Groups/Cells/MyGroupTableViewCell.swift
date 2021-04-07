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

    func configure(groupName: String?, groupAvatar: UIImage?) {
        self.nameGroupLabel.text = groupName
        self.avatarGroupImageView.image = groupAvatar
    }


    func configure(with viewModel: GroupViewModel, groupAvatar: UIImage?) {

        self.nameGroupLabel.text = viewModel.groupName
        self.avatarGroupImageView.image = groupAvatar

    }



    override func prepareForReuse() {
        super.prepareForReuse()

        self.nameGroupLabel.text = nil
        self.avatarGroupImageView.image = nil
    }
}
