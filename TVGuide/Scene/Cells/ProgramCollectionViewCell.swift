//
//  ProgramCollectionViewCell.swift
//  TVGuide
//
//  Created by Sos Avetyan on 4/2/23.
//

import UIKit

class ProgramCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var programNameLabel: UILabel!
    static let reuseIdentifier = "ProgramCell"

    func configure(with program: ProgramItem) {
        programNameLabel.text = program.name
    }
}

