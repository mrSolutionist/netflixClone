//
//  SearchVC.swift
//  NetflixClone
//
//  Created by  Robin George  on 25/11/21.
//

import UIKit

// MARK: THIS VC DEALS WITH THE SEARCH RESULT
class SearchVC: UIViewController, UISearchBarDelegate{
    
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTable: UITableView!
    

    
    var key : String!
    var searchData : MovieListModel?
    // FILTERED DATA IS STORED HERE
    var filteredData : [Results]?{
        didSet{
            DispatchQueue.main.async {   //ONCE DATA RECEVED, RELOADS TABLE
                self.searchTable.reloadData()
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        searchTable.dataSource = self
        searchBar.delegate = self
        
    }
    
    //THIS FUNC HANDLES THE CHANGES IN THE SEARCH FIELD
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        // ON EACH TYPE A SEARCH IS CALLED TO GET THE DATA FROM THE SERVER
       
            ApiManager.shared.searchData(key: searchText) { filteredData in
                self.filteredData = filteredData.results
      
            }
  
        
      
       
    
   
}
}

extension SearchVC: UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let  cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableCell") as! SearchTableCell

        cell.searchResult = filteredData
        
        return cell
    }
}
