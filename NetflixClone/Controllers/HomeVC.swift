//
//  HomeVC.swift
//  NetflixClone
//
//  Created by  Robin George  on 21/11/21.
//

import UIKit


class HomeVC: UIViewController {
    
    
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
    
    var coreGenre : [GenreList]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
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
        
        return coreGenre?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeadCell", for: indexPath) as! HeadCell
            cell.btnDelegate = self
            //checking for keys
            if let key = genrelist?.genres?[indexPath.row].id {
                
                //MARK: STEP : 2 (PASS KEY FROM GENRELIST)
                ApiManager.shared.loadDataWithGenreKey(genreKeyValue: key) { json in
                    //json returns a movieModel that has results in it.
                    cell.movieModelJson = json
                   
                }
                return cell
            }
        }
        else{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
            //setting delegate
            cell.collectionViewDataDelegate = self
            
            cell.genreLabel.text = genrelist?.genres?[indexPath.row].name
            //checking for keys
            if let key = genrelist?.genres?[indexPath.row].id {
                
                //MARK: STEP : 2 (PASS KEY FROM GENRELIST)
                ApiManager.shared.loadDataWithGenreKey(genreKeyValue: key) { json in
                    //json returns a movieModel that has results in it.
                    cell.movieModelJson = json
                    
                }
                return cell
            }
        }
        return UITableViewCell()
    }
}                              

//MARK: STEP 8: CONFORM COLLECTIONDELEGAYE TO HOME
extension HomeVC : MovieDetailPageDelegate{
    func cellData(movieModelJson: Results?, movieDetailObject: MovieDetailModel?) {
        
        
        DispatchQueue.main.async {
            //MARK: SETP 9: INSTANTISATE NEW VC ONCE CLICKED
            let movieDetailVCObject = self.storyboard?.instantiateViewController(withIdentifier: "MovieDetailVC") as! MovieDetailVC
            
            movieDetailVCObject.movieDetailObject = movieDetailObject
            movieDetailVCObject.movieObject = movieModelJson
          
            self.present(movieDetailVCObject, animated: true, completion: nil)
        }
    }
  
}


extension HomeVC: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 520
        }
        return 200
    }
}




extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
