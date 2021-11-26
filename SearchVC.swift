//
//  SearchVC.swift
//  NetflixClone
//
//  Created by  Robin George  on 25/11/21.
//

import UIKit

class SearchVC: UIViewController, UISearchBarDelegate{
    
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTable: UITableView!
    
    var filteredData : [SearchResult]?{
        didSet{
            DispatchQueue.main.async {
                self.searchTable.reloadData()
            }
            
        }
    }
    var key : String!
    var searchData : SearchModel?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        searchTable.dataSource = self
        searchBar.delegate = self
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        ApiManager.shared.searchData(key: searchText) { filteredData in
            self.filteredData = filteredData.results
        }
        
    }

}

extension SearchVC: UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let  cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableCell") as! SearchTableCell
//        cell.textLabel?.text = filteredData?DX[indexPath.row].name
        
        return cell
    }
}
