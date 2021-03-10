//
//  NewsTableViewCell.swift
//  vkClient
//
//  Created by MacBook Pro on 15.11.2020.
//

import UIKit

protocol NewsHeaderCellDelegate: class {
    func showMoreTapped(section: Int)
}


class NewsHeaderTableViewCell: UITableViewCell {

    //MARK: - IBOutlets
    
    @IBOutlet weak var friendAvatarView: AvtarView!
    @IBOutlet weak var friendNameLabel: UILabel!
    @IBOutlet weak var newsTimeLabel: UILabel!
    @IBOutlet weak var newsTextLabel: UILabel!
    @IBOutlet weak var showMorebutton: UIButton!

    
    //MARK: - Private Properties

   // private var isExpanded: Bool = false
    private var section: Int = -1

    //MARK: - Public Properties

    weak var delegate: NewsHeaderCellDelegate?
    
    
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
        self.newsTimeLabel.text = nil
        self.newsTextLabel.text = nil
        self.section = -1
    }

    func configure(postAuthor: String, avatar: UIImage?, newsTime: String, newsText: String, section: Int, isExpanded: Bool) {

        self.section = section

        self.showMorebutton.addTarget(self, action: #selector(showMoreButtonTap), for: .touchUpInside)

        self.friendNameLabel.text = postAuthor
        self.friendAvatarView.image = avatar
        self.newsTimeLabel.text = newsTime
        
        self.newsTextLabel.text = newsText

        // получаем размеры блока под надпись.И используем максимальную ширину и максимально возможную высоту
        let textBlock = CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude)

        let font = UIFont.systemFont(ofSize: 15)

        // получаем прямоугольник под текст в этом блоке с заданным шрифтом
        let rect = newsText.boundingRect(with: textBlock, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

        // если высота требуемого текста превышает высоту, занимаемой двумя строчками заданного шрифта
        if ceil(rect.height) > ceil(font.lineHeight * 2), !isExpanded {
            self.showMorebutton.isHidden = false
            self.newsTextLabel.numberOfLines = 2
        } else {
            self.showMorebutton.isHidden = true
            self.newsTextLabel.numberOfLines = 0
        }
    }

    //MARK: - Private Methods

    @objc private func showMoreButtonTap() {

        self.showMorebutton.isHidden = true
        self.newsTextLabel.numberOfLines = 0

        self.delegate?.showMoreTapped(section: self.section)

    }

}


