//
//  TableViewCell.swift
//  NetflixClone
//
//  Created by  Robin George  on 21/11/21.
//

import UIKit

//delegate for passing data to home vc
protocol CollectionViewData{
    func cellData(movieModelJson : Results, movieDetailObject : MovieDetailModel)
}
protocol MovieData{
    func movieData(movieModelJson : Results)
}


class TableViewCell: UITableViewCell{
    
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!

    var collectionViewDataDelegate : CollectionViewData?
    var movieDataDelegate : MovieData?
    
    var movieModelJson : MovieListModel?
    {
        //FIXME: DID SET AND RELOAD MAY NOT BE NECESSARY HERE AS AFTER GETTING KEYS DATA NEEDS TO RELOADED
        didSet{
            //after getting data a table needs to reload and ui elements needs to be used in main thread only
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                
            }
        }
    }
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
        
        collectionView.dataSource = self
        collectionView.delegate = self
        self.movieDataDelegate?.movieData(movieModelJson: (self.movieModelJson?.results?[0])!)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
}

extension TableViewCell: UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieModelJson?.results?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        
  
        
        //MARK: SETP 4 (PASS IMAGEDATA TO IMAGE TO DATA FUNCTION)
        let imageString =  movieModelJson?.results?[indexPath.row].poster_path
        ApiManager.shared.getImageData(imageUrl: imageString!) { imageData in
            //MARK: STEP 5 (PASS IMAGE DATA TO COLLECTON CELL)
            collectionCell.cellConfigWithData(imageData: imageData!)
        }
        
        return collectionCell
    }
}

extension TableViewCell: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
   
        //MARK: STEP 6 (GET THE MOVIE ID)
        if let id = movieModelJson?.results?[indexPath.row].id {
            
            ApiManager.shared.getMovieDetail(movieId: id) { json in

                //MARK: STEP 7 (delagte: PASS JSON TO MOVIE DETAIL VC)
                let movieList =  self.movieModelJson?.results?[indexPath.row]
                self.collectionViewDataDelegate?.cellData(movieModelJson: movieList!, movieDetailObject: json!)
                
                
            }
            
           
            
        }
    }
}



extension TableViewCell: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
 
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
