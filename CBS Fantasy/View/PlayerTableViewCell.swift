//
//  PlayerTableViewCell.swift
//  CBS Fantasy
//
//  Created by Punit Kulkarni on 6/25/17.
//  Copyright © 2017 Punit Kulkarni. All rights reserved.
//

import UIKit

class PlayerTableViewCell: UITableViewCell {

    @IBOutlet weak var differenceLabel: UILabel!
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var playerPositionLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var playerImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        playerImageView.layer.cornerRadius = 18
        playerImageView.layer.masksToBounds = true
    }
    
    func setup(with player: Player) {
        playerImageView.image = UIImage(data: try! Data(contentsOf: URL(string: player.photoUrl)!, options: .alwaysMapped))
        if player.diff != nil {
            differenceLabel.text = "Adds up \(player.diff!)% since last week"
        } else {
            differenceLabel.text = nil
        }
        playerNameLabel.text = player.fullName
        playerPositionLabel.text = "\(player.team) - \(player.position)"
        authorLabel.isHidden = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        differenceLabel.text = nil
        playerNameLabel.text = nil
        playerPositionLabel.text = nil
        authorLabel.text = nil
        playerImageView.image = nil
    }
}
