//
//  TimelineCell.swift
//  TVGuide
//
//  Created by Sos Avetyan on 4/9/23.
//

import UIKit

class TimelineCell: UICollectionViewCell {

    static let reuseIdentifier = "TimelineCell"

    @IBOutlet private weak var timeLabel: UILabel!

    func configure(with time: String) {
        timeLabel.text = time
    }

}
