//
//  MovieDetailVC.swift
//  NetflixClone
//
//  Created by  Robin George  on 22/11/21.
//

import UIKit
import AVFoundation

class MovieDetailVC: UIViewController {


    @IBOutlet weak var movieDescription: UITextView!
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var imdb: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var mediaView: UIView!
    
    var movieDetailObject : MovieDetailModel? {
        didSet {
            showVideo()
        }
    }
   
    var movieObject : Results?{
        didSet {
            movieDetails()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
       
    }
    
    func showVideo(){
        
//        mediaView.backgroundColor = .red
        
        let key = movieDetailObject?.results?[0].key
        let videoUrl = URL(string:"https://www.youtube.com/watch?v=\(key!)")
        let player = AVPlayer(url: videoUrl!)
        let playerLayer = AVPlayerLayer(player: player)
        
//        mediaView.layer.addSublayer(playerLayer)
//        playerLayer.frame = mediaView.frame
        player.play()
        
    }
    func movieDetails(){
        let test =  movieObject?.original_title // vlaue present
        movieTitle?.text =  movieObject?.original_title // cant assign value 
        
    }
    
}
