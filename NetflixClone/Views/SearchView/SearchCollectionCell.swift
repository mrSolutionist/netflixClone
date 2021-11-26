//
//  SearchCollectionCell.swift
//  NetflixClone
//
//  Created by  Robin George  on 26/11/21.
//

import UIKit

class SearchCollectionCell: UICollectionViewCell {
    
   
    @IBOutlet weak var searchImage: UIImageView!
    

    
    func cellConfig(re:Results){
        guard  let imageUrl = re.poster_path else {return}
        
        ApiManager.shared.getImageData(imageUrl: imageUrl) { imageData in
            self.searchImage.image = UIImage(data: imageData!)
        }
       
    }
}
