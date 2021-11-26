//
//  ApiManager.swift
//  NetflixClone
//
//  Created by  Robin George  on 21/11/21.
//

import Foundation

struct ApiManager{
    
    static let shared = ApiManager()
    
    private  let imageBaseUrl = "https://image.tmdb.org/t/p/w500"
    
    private let baseUrl = "https://api.themoviedb.org/3/"
    
    private let apiKey = "?api_key=4aede8b2ecf032bef5691734ca5e1d5a"
    
    //main url for fetching the movies , add genre or any other to get the data
    private let mainListUrl = "discover/movie"
    
    private let genreUrl = "&with_genres="
    
    //use this for getting the list of ids of genre
    private let genreListUrl = "genre/movie/list"
    
    private let searchUrl = "search/movie"
    private init(){}
    
    //https://api.themoviedb.org/3/discover/movie?api_key=4aede8b2ecf032bef5691734ca5e1d5a&language=en-US
    
    //https://api.themoviedb.org/3/search/company?api_key=4aede8b2ecf032bef5691734ca5e1d5a&query=spider&page=1
    
    //URLSESSION function
    private func urlSessionManager<RespondsTypeName:Codable>(url:URL, toUseDataType:RespondsTypeName.Type,  complition: @escaping (Result<RespondsTypeName,Error>) -> () ){
        
        URLSession.shared.dataTask(with: url) { data, resp, error in
            guard let data = data else {
                return
            }
            do {
                let jsonObject = try JSONDecoder().decode(toUseDataType.self, from: data)
                
                //FIXME: should i pass the data  as clousure or as delegate?
                
                //passing as clousure :
                complition(.success(jsonObject))
                
                
            }
            
            catch {
                complition(.failure(error))
            }
            
        }.resume()
    }
    
    
    //MARK: STEP 1.1 : GENERATE GENRE KEYS
    func getGenreKeys(complition: @escaping (_ genre : GenreListModel?) -> ())
    {
        let genreUrl = URL(string: "\(baseUrl)\(genreListUrl)\(apiKey)")!
        
        urlSessionManager(url: genreUrl,toUseDataType: GenreListModel.self) { json in
            
            //json will contain genreList Object , which can be used to get keys
            switch json
            {
            case .success(let GenreListModel) :
                complition(GenreListModel)
                
            case .failure(let error) :
                print(error)
            }
        }
        
    }
    
    
    //MARK:  STEP 2.1 : LOAD WITH GENRE
    func loadDataWithGenreKey(genreKeyValue:Int, complition: @escaping (_ json : MovieListModel) -> ())
    {            // for loading the contet with genre key
        
        let moviesUrl = URL(string: "\(baseUrl)\(mainListUrl)\(apiKey)\(genreUrl)\(genreKeyValue)")!
        
        urlSessionManager(url:moviesUrl, toUseDataType: MovieListModel.self) { json in
            
            
            //MARK: completion json data for populating to Views
            
            switch json
            {
            case .success(let MovieListModel) :
                complition(MovieListModel)
                
            case .failure(let error) :
                print(error)
            }
        }
        
        //MARK: saving to coredata so once loaded data will be fetched from database
        //FIXME: save this json to coreData BUT NOT SAVED
        //            CoreDataManager.shared.saveObjectForOfflineLoading(jsonData: json!)
    }
    
    
    
    func getImageData(imageUrl : String , complition: @escaping (_ imageData : Data?) -> ())
    {
        let baseImageUrl = imageBaseUrl
        let url = URL(string: "\(baseImageUrl)\(imageUrl)")
        do {
            let imageData = try Data(contentsOf: url!)
            complition(imageData)
        }
        catch
        {
            print("image dsts not foUnt")
        }
       
    }
    
    //MARK: STEP 6.1 (GET MOVIE DETAIL MODEL)
    func getMovieDetail(movieId:Int, completion: @escaping (_ json : MovieDetailModel? ) -> ()){
        let url = URL(string: "\(baseUrl)/movie/\(movieId)/videos\(apiKey)")
        
        urlSessionManager(url: url!, toUseDataType: MovieDetailModel.self) { json in
            
            switch json
            {
            case .success(let MovieDetailModel) :
                completion(MovieDetailModel)
                
            case .failure(let error) :
                print(error)
            }
        }
      
    }
    
    func searchData(key:String, complition: @escaping(_ filteredData : MovieListModel) -> ()){
        guard let url = URL(string: "\(baseUrl)\(searchUrl)\(apiKey)&query=\(key)") else {
            return
        }
        urlSessionManager(url: url, toUseDataType: MovieListModel.self) { json in
            
            switch json
            {
            case .success(let SearchModel) :
                complition(SearchModel)
                
            case .failure(let error) :
                print(error)
            }
        }
    }
    
    
    
}




