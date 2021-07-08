//
//  SongListTableViewCell.swift
//  CrownStackCodeTask
//
//  Created by Prabhat on 08/07/21.
//

import UIKit

class SongListTableViewCell: UITableViewCell {

  @IBOutlet weak var songImageView: UIImageView! {
    didSet {
      self.songImageView.layer.borderWidth = 1.2
      self.songImageView.layer.borderColor = UIColor.lightGray.cgColor
      self.songImageView.layer.cornerRadius = self.songImageView.frame.size.height/2
    }
  }
  @IBOutlet weak var songName: UILabel!
  @IBOutlet weak var artistName: UILabel!
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
