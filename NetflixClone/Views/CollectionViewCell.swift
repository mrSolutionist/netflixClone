//
//  CollectionViewCell.swift
//  NetflixClone
//
//  Created by  Robin George  on 21/11/21.
//

import UIKit


class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var collectionCellImage: UIImageView!
    
   
    func cellConfigWithData(imageData:Data){
        
        collectionCellImage.image = UIImage(data: imageData)
        self.layer.cornerRadius = 25
    }
}
