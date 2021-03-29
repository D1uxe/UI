//
//  NewsPhotoTableViewCell.swift
//  vkClient
//
//  Created by MacBook Pro on 07.03.2021.
//

import UIKit

class NewsPhotoTableViewCell: UITableViewCell {

    //MARK: - IBOutlets

    @IBOutlet weak var newsPhotoImageView: UIImageView!

    // MARK: - Public Methods

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        self.newsPhotoImageView.image = nil
    }

    func configure(newsPhoto: UIImage? ) {

        self.newsPhotoImageView.image = newsPhoto
    }
    
}
