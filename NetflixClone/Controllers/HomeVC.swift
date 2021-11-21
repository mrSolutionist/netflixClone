//
//  HomeVC.swift
//  NetflixClone
//
//  Created by  Robin George  on 21/11/21.
//

import UIKit

class HomeVC: UIViewController {
    
    
    
    
    @IBOutlet weak var trendingImage: UIImageView!  //FIXME: why cant i place this image in table cell view>
    
    @IBOutlet weak var tableView: UITableView!
    
    //this contains keys for genre api call
    var genrelist : GenreListModel? {
        
        //FIXME: DID SET AND RELOAD MAY NOTY BE NECESSARY HERE AS AFTER GETTING KEYS DATA NEEDS TO RELOADED
        didSet{
            //after getting data a table needs to reload and ui elements needs to be used in main thread only
            DispatchQueue.main.async {
                self.tableView.reloadData()
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //MARK: STEP 1( GETTING KEYS )
        ApiManager.shared.getGenreKeys { genre in
            self.genrelist = genre
        }
    }
}




extension HomeVC : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genrelist?.genres?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        
        //checking for keys
        if let key = genrelist?.genres?[indexPath.row].id {
            
            //MARK: STEP : 2 (PASS KEY FROM GENRELIST)
            ApiManager.shared.loadDataWithGenreKey(genreKeyValue: key) { json in
                //json returns a movieModel that has results in it.
                cell.movieModelJson = json
                
              
            }
        }

        return cell
    }
    
  
}
