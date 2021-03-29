//
//  NewsFooterTableViewCell.swift
//  vkClient
//
//  Created by MacBook Pro on 07.03.2021.
//

import UIKit

class NewsFooterTableViewCell: UITableViewCell {
    
    //MARK: - IBOutlets

    @IBOutlet weak var LikeControl: LikeControl!
    @IBOutlet weak var commentCountLabel: UILabel!
    @IBOutlet weak var repostCountLabel: UILabel!
    @IBOutlet weak var viewsCountLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!


    // MARK: - Public Methods

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        LikeControl.likeCounter = 0
        LikeControl.isLike = false
        commentCountLabel.text = ""
        repostCountLabel.text = ""
        viewsCountLabel.text = ""
    }

    func configure(likeCount: Int, likeState: Int, commentCount: Int, repostCount: Int, viewsCount: Int) {

        LikeControl.likeCounter = Float(likeCount)
        LikeControl.isLike = likeState == 1 ? true : false
        commentCountLabel.text = String(commentCount)
        repostCountLabel.text = String(repostCount)
        viewsCountLabel.text = String(viewsCount)
    }

}
