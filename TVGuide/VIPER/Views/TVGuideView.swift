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

    @IBOutlet weak var channelsTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        configureChannelsTableView()
    }

    func configure(presenter: TVGuideViewOutput) {
        self.presenter = presenter
    }

    func reloadData() {
        channelsTableView.reloadData()
    }

    private func configureChannelsTableView() {
        channelsTableView.dataSource = self
        channelsTableView.delegate = self
        channelsTableView.register(UINib(nibName: "ChannelTableViewCell", bundle: nil), forCellReuseIdentifier: "ChannelCell")
    }
}

extension TVGuideView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.channels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChannelCell", for: indexPath) as! ChannelTableViewCell
        let chanel = presenter.channels[indexPath.row]
        let chanelPrograms = presenter.programs.filter({ $0.recentAirTime?.channelID == chanel.id })
        cell.configure(with: chanel, programs: chanelPrograms)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150.0
    }
}

extension TVGuideView: UITableViewDelegate {
    // Implement UITableViewDelegate methods if necessary
}
