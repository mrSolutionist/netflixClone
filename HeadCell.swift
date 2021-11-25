//
//  HeadCell.swift
//  NetflixClone
//
//  Created by  Robin George  on 24/11/21.
//

import UIKit


class HeadCell: UITableViewCell {

    @IBOutlet weak var trendingImage: UIImageView!
    

    
    var movieModelJson : MovieListModel?{
        didSet{
            imageTrending()
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
   
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func imageTrending(){
        if let imageUrl = movieModelJson?.results![5].poster_path {
            
            ApiManager.shared.getImageData(imageUrl: imageUrl) { imageData in
                DispatchQueue.main.async {
                    self.trendingImage.image = UIImage(data: imageData!)
                }
             
               
        }
        }
    }

}
