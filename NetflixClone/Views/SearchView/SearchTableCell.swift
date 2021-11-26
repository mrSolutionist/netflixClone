//
//  SearchTableCell.swift
//  NetflixClone
//
//  Created by  Robin George  on 26/11/21.
//

import UIKit

class SearchTableCell: UITableViewCell  {
    
 

    @IBOutlet weak var resultCollectionView: UICollectionView!
    
    var searchResult : [Results]?{
        didSet{
            DispatchQueue.main.async {
                self.resultCollectionView.reloadData()
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        resultCollectionView.dataSource = self
    }

 
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension SearchTableCell:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResult?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = resultCollectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionCell", for: indexPath) as! SearchCollectionCell
        cell.cellConfig(re: searchResult![indexPath.row])
        return cell
    }
}
