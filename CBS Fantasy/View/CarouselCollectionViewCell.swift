//
//  CarouselCollectionViewCell.swift
//  CBS Fantasy
//
//  Created by Punit Kulkarni on 6/25/17.
//  Copyright © 2017 Punit Kulkarni. All rights reserved.
//

import UIKit

protocol CarouselCollectionViewCellDelegate {
    
}

protocol CarouselTableViewCellProtocol {
    var title: String { get }
    var timestamp: Date { get }
    var source: String { get }
    var imageURL: String { get}
}

class CarouselCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    var delegate: CarouselTableViewCellDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(for delegate: CarouselTableViewCellDelegate, title: String, timestamp: Date, source: String?, imageURL: String) {
        
        self.delegate = delegate
        imageView.image = UIImage(data: try! Data(contentsOf: URL(string: imageURL)!, options: .alwaysMapped))
        titleLabel.text = title
        timestampLabel.text = timestamp.timeAgoFromNow(numericDates: false)
        if source != nil {
            sourceLabel.text = source
        } else {
            sourceLabel.text = ""
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        titleLabel.text = ""
        timestampLabel.text = ""
        sourceLabel.text = ""
    }
}
