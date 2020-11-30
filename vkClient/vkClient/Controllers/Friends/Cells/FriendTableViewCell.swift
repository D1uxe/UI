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
    @IBOutlet weak var friendAvatarShadowView: ShadowView!


    //MARK: - Private Properties
    
        lazy private var avatarTapGestureRecognizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(tapOnAvatar))
        return recognizer
    }()
    
    
    // MARK: - Public Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()

        friendAvatarImageView.isUserInteractionEnabled = true
        friendAvatarImageView.addGestureRecognizer(avatarTapGestureRecognizer)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    //MARK: - Private Methods
    
    @objc private func tapOnAvatar() {
        
        UIView.animate(withDuration: 0.2,
                       delay: 0,
                       usingSpringWithDamping: 0.3,
                       initialSpringVelocity: 1.0,
                       options: [],
                       animations: { [unowned self] in
                           let scale = CGAffineTransform(scaleX: 0.95, y: 0.95)
                           self.friendAvatarImageView.transform = scale
                           self.friendAvatarShadowView.transform = scale
                       },
                       completion: { [unowned self] _ in
                           self.friendAvatarImageView.transform = .identity
                           self.friendAvatarShadowView.transform = .identity
                       })
    }

    
    
    
}
