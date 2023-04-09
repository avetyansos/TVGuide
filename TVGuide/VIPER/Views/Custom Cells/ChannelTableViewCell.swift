//
//  ChannelTableViewCell.swift
//  TVGuide
//
//  Created by Sos Avetyan on 4/2/23.
//

import UIKit

class ChannelTableViewCell: UITableViewCell, UIScrollViewDelegate {
    @IBOutlet private weak var channelNameLabel: UILabel!
    @IBOutlet weak var programsCollectionView: UICollectionView!
    static let reuseIdentifier = "ChannelCell"
    private var programs: [ProgramItem] = []
    weak var scrollDelegate: UIScrollViewDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()

        let synchronizedFlowLayout = SynchronizedScrollFlowLayout()
        synchronizedFlowLayout.scrollDirection = .horizontal
        programsCollectionView.setCollectionViewLayout(synchronizedFlowLayout, animated: false)
        setupView()
    }


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func configure(with channel: Channel, programs: [ProgramItem], startTime: Date, timelineCollectionView: UICollectionView) {
        channelNameLabel.text = channel.callSign
        self.programs = programs
        programsCollectionView.delegate = self

        programsCollectionView.contentOffset.x = timelineCollectionView.contentOffset.x
        programsCollectionView.reloadData()
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollDelegate?.scrollViewDidScroll?(scrollView)
    }


    private func setupView() {
        programsCollectionView.register(UINib(nibName: "ProgramCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: ProgramCollectionViewCell.reuseIdentifier)
        programsCollectionView.dataSource = self
        programsCollectionView.delegate = self
        programsCollectionView.reloadData()
    }

    private func configureDataSource(programs: [ProgramItem]) {
        self.programs = programs
        programsCollectionView.reloadData()
    }

    private func widthForProgram(_ program: ProgramItem, baseWidth: CGFloat, secondsInBaseWidth: TimeInterval) -> CGFloat {
        guard let duration = program.duration else {
            return baseWidth
        }
        let programDurationSeconds = Double(duration) * 4
        let widthMultiplier = programDurationSeconds / secondsInBaseWidth
        return baseWidth * CGFloat(widthMultiplier)
    }

    private func positionForProgram(_ program: ProgramItem, baseWidth: CGFloat, secondsInBaseWidth: TimeInterval) -> CGFloat {
        guard let startDate = program.startTime else {
            return 0
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        let now = Date()

        let timeIntervalSinceNow = startDate.timeIntervalSince(now)
        let positionMultiplier = timeIntervalSinceNow / secondsInBaseWidth
        return baseWidth * CGFloat(positionMultiplier)
    }

}

extension ChannelTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let program = programs[indexPath.row]
        let baseWidth: CGFloat = 75
        let secondsInBaseWidth: TimeInterval = 30 * 60
        let width = widthForProgram(program, baseWidth: baseWidth, secondsInBaseWidth: secondsInBaseWidth)

        let position = positionForProgram(program, baseWidth: baseWidth, secondsInBaseWidth: secondsInBaseWidth)
        let attributes = collectionViewLayout.layoutAttributesForItem(at: indexPath)?.frame.origin.x ?? 0
        if attributes != position {
            collectionViewLayout.invalidateLayout()
        }

        return CGSize(width: width, height: 120)
    }
}

extension ChannelTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return programs.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProgramCollectionViewCell.reuseIdentifier, for: indexPath) as! ProgramCollectionViewCell
        let program = programs[indexPath.item]
        cell.configure(with: program)
        return cell
    }
}

