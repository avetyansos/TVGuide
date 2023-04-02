//
//  ChannelTableViewCell.swift
//  TVGuide
//
//  Created by Sos Avetyan on 4/2/23.
//

import UIKit

class ChannelTableViewCell: UITableViewCell {

    @IBOutlet private weak var channelNameLabel: UILabel!
    @IBOutlet private weak var programsCollectionView: UICollectionView!

    static let reuseIdentifier = "ChannelCell"
    
    private var programs: [ProgramItem] = [] {
        didSet {
            programsCollectionView.reloadData()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func configure(with channel: Channel, programs: [ProgramItem]) {
        channelNameLabel.text = channel.callSign
        self.programs = programs
    }
    
    private func setupView() {
        programsCollectionView.delegate = self
        programsCollectionView.dataSource = self
        programsCollectionView.register(UINib(nibName: "ProgramCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProgramCell")    }
}

extension ChannelTableViewCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return programs.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProgramCollectionViewCell.reuseIdentifier, for: indexPath) as! ProgramCollectionViewCell
        cell.configure(with: programs[indexPath.item])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 120)
    }
}
