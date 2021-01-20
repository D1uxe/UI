//
//  FriendCollectionViewController.swift
//  vkClient
//
//  Created by MacBook Pro on 01.11.2020.
//

import UIKit

class FriendCollectionViewController: UICollectionViewController {

    //MARK: - Private Properties

    private let imageService = ImageService()


    //MARK: - Public Properties
    
    var friendPhotos = [Photo]() // сюда данные приходят из метода prepare(for segue:) класса FriendTableVewController
    var friendId: Int?

    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionFlowLayoutSettings()

        self.loadData()
        QueryPhotos.getAll(for: friendId, completion: { [weak self] photos in
            //self?.friendPhotos = photos
            self?.loadData()
            self?.collectionView.reloadData()
        })
    }


    //MARK: - Private Methods
    
    fileprivate func collectionFlowLayoutSettings() {
        //настройка collection flow layout
        let itemsPerRow: CGFloat = 2
        let inset: UIEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        let widthSpacing = inset.left * (itemsPerRow + 1)
        let availableWidth = collectionView.bounds.width - widthSpacing
        let itemSize = availableWidth / itemsPerRow
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = inset
        layout.minimumLineSpacing = inset.left
        layout.minimumInteritemSpacing = inset.left
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
    }
    
    fileprivate func loadData() {
        self.friendPhotos = RealmService.loadData(for: friendId, of: Photo.self)
        
    }
    
    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using [segue destinationViewController].
         // Pass the selected object to the new view controller.
     }
     */

    
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {

        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return friendPhotos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendCollectionCell", for: indexPath) as! FriendCollectionViewCell

        let photoObject = friendPhotos[indexPath.item]

        imageService.getPhoto(byURL: photoObject.sizes[0].url, completion: { photo in
            cell.friendPhotoImageView.image = photo
            cell.LikeControl.likeCounter = Float(photoObject.likes?.likesCount ?? 0)
            })

        return cell
    }



    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let friendPhotoBrowserVC = FriendPhotoBrowserViewController()

//        friendPhotoBrowserVC.friendPhotos = friendPhotoo
        friendPhotoBrowserVC.selectedPhoto = indexPath.item

        friendPhotoBrowserVC.modalPresentationStyle = .automatic
        friendPhotoBrowserVC.modalTransitionStyle = .coverVertical
       // self.navigationController?.pushViewController(friendPhotoBrowserVC, animated: true)
        //TODO: Сделать просмотр фотографий друга.
        // Закоментировал пояление контроллера, т.к. нужно заново получать все фотограйии по URL. Возможно, что когда доберемся до Realm, код контроллера придется еще раз переделать. Подожду уроков по Realm
    }


    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
         return true
     }
     */

    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
         return true
     }
     */

    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
         return false
     }

     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
         return false
     }

     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {

     }
     */
}
