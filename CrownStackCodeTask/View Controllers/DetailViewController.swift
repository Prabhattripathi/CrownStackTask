//
//  DetailViewController.swift
//  CrownStackCodeTask
//
//  Created by Prabhat on 08/07/21.
//

import UIKit
import AVFoundation
import AVKit
import SDWebImage

class DetailViewController: UIViewController {
  var detailResult: Result? = nil

  @IBOutlet weak var songImage: UIImageView!
  @IBOutlet weak var audioPlayerView: UIView!
  @IBOutlet weak var trackName: UILabel!
  @IBOutlet weak var artistName: UILabel!
  @IBOutlet weak var collectionName: UILabel!
  @IBOutlet weak var releaseDate: UILabel!
  @IBOutlet weak var gener: UILabel!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
      self.title = "\(detailResult?.trackName ?? "NA") - \(detailResult?.artistName ?? "NA")"
    }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    self.songImage.sd_setImage(with: URL(string: detailResult?.artworkUrl100 ?? ""), placeholderImage: UIImage(named: "no_image"))
    self.artistName.text = detailResult?.artistName ?? "NA"
    self.trackName.text = detailResult?.trackName ?? "NA"
    self.collectionName.text = detailResult?.collectionName ?? "NA"
    self.gener.text = detailResult?.primaryGenreName ?? "NA"

    let dateFormatter = DateFormatter()
    guard let date = detailResult?.releaseDate else { return }
    dateFormatter.dateFormat = "dd-MMM-yyyy"
    self.releaseDate.text = dateFormatter.string(from: date)


    guard let url = URL(string: detailResult?.previewURL ?? "") else { return }

    let audioPlayer = AVPlayer(url: url)
    let audioPlayerViewController = AVPlayerViewController()
//    let playerLayer = AVPlayerLayer(player: audioPlayer)
//    playerLayer.frame = audioPlayerViewController.view.bounds
//    self.view.layer.addSublayer(playerLayer)
    audioPlayerViewController.player = audioPlayer
    audioPlayerViewController.view.frame = self.audioPlayerView.bounds
    self.addChild(audioPlayerViewController)
    self.audioPlayerView.addSubview(audioPlayerViewController.view)
    audioPlayerViewController.didMove(toParent: self)
    //audioPlayer.play()
  }

  override func viewWillLayoutSubviews() {

  }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
