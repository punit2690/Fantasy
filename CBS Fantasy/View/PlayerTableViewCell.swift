//
//  PlayerTableViewCell.swift
//  CBS Fantasy
//
//  Created by Punit Kulkarni on 6/25/17.
//  Copyright © 2017 Punit Kulkarni. All rights reserved.
//

import UIKit

class PlayerTableViewCell: UITableViewCell {

    @IBOutlet private weak var differenceLabel: UILabel!
    @IBOutlet private weak var playerNameLabel: UILabel!
    @IBOutlet private weak var playerPositionLabel: UILabel!
    @IBOutlet private weak var authorLabel: UILabel!
    @IBOutlet private weak var playerImageView: UIImageView!
    
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
    
    func setup(with update: PlayerUpdate) {
        playerImageView.image = UIImage(data: try! Data(contentsOf: URL(string: update.player.photoUrl)!, options: .alwaysMapped))
        differenceLabel.text = update.title
        playerNameLabel.text = update.player.fullName
        playerPositionLabel.text = "\(update.player.team) - \(update.player.position)"
        authorLabel.isHidden = false
        authorLabel.text = "By \(update.author.firstName) \(update.author.lastName) | \(update.timeStamp.timeAgoFromNow(numericDates: false))"
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
