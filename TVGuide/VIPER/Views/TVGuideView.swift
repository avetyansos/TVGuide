//
//  TVGuideView.swift
//  TVGuide
//
//  Created by Sos Avetyan on 4/2/23.
//

import UIKit

class TVGuideView: UIViewController, TVGuideViewInput, Storyboardable {

    static var storyboardName: StringConvertible {
        return StoryboardType.main
    }

    private var presenter: TVGuideViewOutput!
    private var dataSource: UITableViewDiffableDataSource<Int, Channel>?
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var timelineCollectionView: UICollectionView!
    private var timelineDataSource: UICollectionViewDiffableDataSource<Int, String>?
    @IBOutlet weak var channelsTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        configureChannelsTableView()
        configureDataSource()
        configureTimelineCollectionView()
    }

    func configure(presenter: TVGuideViewOutput) {
        self.presenter = presenter
    }

    func reloadData() {
        applySnapshot()
    }

    func applySnapshot(animated: Bool = true) {
        guard let dataSource = dataSource else { return }
        var snapshot = NSDiffableDataSourceSnapshot<Int, Channel>()
        snapshot.appendSections([0])
        snapshot.appendItems(presenter.channels)
        dataSource.apply(snapshot, animatingDifferences: animated)
    }

    private func configureChannelsTableView() {
        channelsTableView.register(UINib(nibName: "ChannelTableViewCell", bundle: nil), forCellReuseIdentifier: "ChannelCell")
        channelsTableView.rowHeight = 150
        channelsTableView.estimatedRowHeight = 150
    }
    private func configureDataSource() {
        dataSource = UITableViewDiffableDataSource<Int, Channel>(tableView: channelsTableView) { (tableView, indexPath, channel) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: ChannelTableViewCell.reuseIdentifier, for: indexPath) as! ChannelTableViewCell
            let channelPrograms = self.presenter.programs.filter { $0.recentAirTime?.channelID == channel.id }
            let startTime = channelPrograms.first?.startTime ?? Date()
            if let localStartTime = startTime.convertToLocalTime() {
                cell.configure(with: channel, programs: channelPrograms, startTime: localStartTime, timelineCollectionView: self.timelineCollectionView)
            }
            cell.scrollDelegate = self
            return cell
        }
    }

    private func configureTimelineCollectionView() {
        timelineCollectionView.register(UINib(nibName: "TimelineCell", bundle: nil), forCellWithReuseIdentifier: TimelineCell.reuseIdentifier)
        timelineCollectionView.delegate = self

        timelineDataSource = UICollectionViewDiffableDataSource<Int, String>(collectionView: timelineCollectionView) { (collectionView, indexPath, time) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TimelineCell.reuseIdentifier, for: indexPath) as! TimelineCell
            cell.configure(with: time)
            return cell
        }
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        timelineCollectionView.setCollectionViewLayout(layout, animated: false)
        updateTimelineData()
    }

    private func updateTimelineData() {
        let currentTime = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        dateLabel.text = dateFormatter.string(from: currentTime)
        let timeLabels = generateTimeLabels(from: currentTime, every: 30 * 60, count: 24 * 2) // 24 hours, 30-minute intervals
        var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
        snapshot.appendSections([0])
        snapshot.appendItems(timeLabels)
        timelineDataSource?.apply(snapshot, animatingDifferences: false)
    }

    func generateTimeLabels(from startTime: Date, every interval: TimeInterval, count: Int) -> [String] {
        var labels: [String] = []
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"

        for i in 0..<count {
            let time = startTime.addingTimeInterval(TimeInterval(i) * interval)
            labels.append(dateFormatter.string(from: time))
        }

        return labels
    }
}

extension TVGuideView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == timelineCollectionView {
            return CGSize(width: 250, height: collectionView.bounds.height)
        }
        return CGSize.zero
    }
}

extension TVGuideView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == timelineCollectionView {
            for cell in channelsTableView.visibleCells {
                if let cell = cell as? ChannelTableViewCell {
                    cell.programsCollectionView.contentOffset.x = scrollView.contentOffset.x
                }
            }
        } else {
            timelineCollectionView.contentOffset.x = scrollView.contentOffset.x
        }
    }
}
