//
//  MovieDetailVC.swift
//  NetflixClone
//
//  Created by  Robin George  on 22/11/21.
//

import UIKit
import WebKit
import youtube_ios_player_helper

class MovieDetailVC: UIViewController, YTPlayerViewDelegate {


  
    @IBOutlet weak var movieDescription: UITextView!
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var imdb: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var mediaView: YTPlayerView!
    
    var movieDetailObject : MovieDetailModel?
    var movieObject : Results?
    


  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let value =  movieObject {
           
            movieTitle?.text =  value.original_title
            movieDescription.text = value.overview
            year.text = value.release_date
  
        }
  
        if let key = movieDetailObject?.results?[0].key{
            mediaView.load(withVideoId: key)
        }

    }
    
   
    func movieDetails(){
        if let value =  movieObject {
            
            movieTitle?.text =  value.original_title // cant assign value
        }
       
        
    }
    
}
