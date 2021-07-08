//
//  ViewController.swift
//  CrownStackCodeTask
//
//  Created by Prabhat on 08/07/21.
//

import UIKit
import SVProgressHUD
import SDWebImage

class SongListViewController: UIViewController {
//  let songM: SongModel

  @IBOutlet weak var songListTableView: UITableView!
  let songVM = SongViewModel()
  var songResult = [Result]()

  // Refresh Control for UITableView
  lazy var refreshControl: UIRefreshControl = {
          let refreshControl = UIRefreshControl()
          refreshControl.addTarget(self, action:
                       #selector(SongListViewController.handleRefresh(_:)),
                                   for: UIControl.Event.valueChanged)
          refreshControl.tintColor = UIColor.darkGray

          return refreshControl
      }()

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    self.title = "Songs"
    songListTableView.isHidden = true
    self.songListTableView.addSubview(refreshControl)
    fetchSongs() //Fetching Song list from server...
  }

  func fetchSongs () {
    SVProgressHUD.show(withStatus: "Loading your songs...")
    SVProgressHUD.dismiss(withDelay: 2) {
      DispatchQueue.global(qos: .default).async(execute: {
        self.songVM.fetchSongData { (sm, error) in
          DispatchQueue.main.async {
            self.songResult = sm.results?.filter({ (result) -> Bool in
              result.kind?.rawValue == "song"
            }) ?? []
            self.songListTableView.isHidden = false
            self.songListTableView.reloadData()
          }
        }
      })
    }
  }

  @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
    fetchSongs()
    refreshControl.endRefreshing()
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    switch segue.identifier {
      case "songDetail":
        guard let indexPath =  self.songListTableView.indexPathForSelectedRow else {return}
        let detailsVS = segue.destination as! DetailViewController
        detailsVS.detailResult = self.songResult[indexPath.row]
      default:
        break
    }

  }
}

extension SongListViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    self.songResult.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = self.songListTableView.dequeueReusableCell(withIdentifier: "songListCell", for: indexPath) as! SongListTableViewCell

    cell.songImageView?.sd_setImage(with: URL(string: self.songResult[indexPath.row].artworkUrl100 ?? ""), placeholderImage: UIImage(named: "no_image"))
    
    cell.songName.text = self.songResult[indexPath.row].trackName ?? "NA"

    cell.artistName.text = "Artist name: \(self.songResult[indexPath.row].artistName ?? "NA")"
    return cell
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }

}

extension SongListViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    self.performSegue(withIdentifier: "songDetail", sender: self)
  }
}
