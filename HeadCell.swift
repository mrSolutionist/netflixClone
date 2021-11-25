//
//  HeadCell.swift
//  NetflixClone
//
//  Created by  Robin George  on 24/11/21.
//

import UIKit

protocol TableViewReloadFromTableCell{
    func reloadTableViewCell()
}

class HeadCell: UITableViewCell {

    @IBOutlet weak var trendingImage: UIImageView!
    
    var reloadDelegate: TableViewReloadFromTableCell?
    
    var movieModelJson : MovieListModel?{
        didSet{
            self.reloadDelegate?.reloadTableViewCell()
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        if let imageUrl = movieModelJson?.results![0].poster_path {
            
            ApiManager.shared.getImageData(imageUrl: imageUrl) { imageData in
                self.trendingImage.image = UIImage(data: imageData!)
               
        }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
