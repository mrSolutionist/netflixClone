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
        setNavigationBarImage()
//        self.navigationController?.hidesBarsOnSwipe = true
      
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //MARK: STEP 1( GETTING KEYS )
        ApiManager.shared.getGenreKeys { genre in
            self.genrelist = genre
        }
    }
    
    private func  setNavigationBarImage(){
        let logo = UIImage(named: "NetflixLogo")
        let imageView = UIImageView(image: logo)
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
        
        
    }
}




extension HomeVC : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genrelist?.genres?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        
        //setting delegate 
        cell.collectionViewDataDelegate = self
        cell.movieDataDelegate = self
        cell.genreLabel.text = genrelist?.genres?[indexPath.row].name
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


//MARK: STEP 8: CONFORM COLLECTIONDELEGAYE TO HOME

extension HomeVC : CollectionViewData{
    func cellData(movieModelJson: Results, movieDetailObject: MovieDetailModel) {
       
        
        DispatchQueue.main.async {
            
            let movieDetailVCObject = self.storyboard?.instantiateViewController(withIdentifier: "MovieDetailVC") as! MovieDetailVC
          
            movieDetailVCObject.movieDetailObject = movieDetailObject
            movieDetailVCObject.movieObject = movieModelJson
            
            self.navigationController?.pushViewController(movieDetailVCObject, animated: true)
        }
    }
    
    
    
}


extension HomeVC : MovieData{
    func movieData(movieModelJson: Results) {
        
        DispatchQueue.main.async {
            let imageUrl = movieModelJson.poster_path
            ApiManager.shared.getImageData(imageUrl: imageUrl!) { imageData in
                self.trendingImage.image = UIImage(data: imageData!)
        }
       
        }
      
    }
    
    
}
