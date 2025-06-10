//
//  PlayersViewController.swift
//  TeamUp
//
//  Created by Quy Cao on 12/5/19.
//  Copyright © 2019 Quy Cao. All rights reserved.
//

import UIKit

class PlayersViewController: UIViewController {
    
    struct Settings {
        static let tintColor = UIColor(red: 0.000, green: 0.479, blue: 0.999, alpha: 1.00)
    }

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.reloadData()
        updateTitle()
    }
    
    private func updateTitle() {
        let count = DataCenter.shared.players.filter { $0.isIncluded }.count
        title = "Players (\(count) Selected)"
    }
}

extension PlayersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataCenter.shared.players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell") else { return UITableViewCell() }
        let player = DataCenter.shared.players[indexPath.row]
        cell.textLabel?.text = player.name
        cell.imageView?.image = UIImage(named: player.id)
        cell.imageView?.clipsToBounds = true
        cell.imageView?.layer.borderWidth = 1
        cell.imageView?.layer.borderColor = Settings.tintColor.cgColor
        cell.imageView?.layer.cornerRadius = PlayerView.Settings.defaultSize.height / 2
        cell.accessoryType = player.isIncluded ? .checkmark : .none
        return cell
    }
}

extension PlayersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        
        let player = DataCenter.shared.players[indexPath.row]
        
        let updatedPlayer = Player(id: player.id, name: player.name, isIncluded: !player.isIncluded)
        cell.accessoryType = updatedPlayer.isIncluded ? .checkmark : .none
        
        DataCenter.shared.players[indexPath.row] = updatedPlayer
        updateTitle()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return PlayerView.Settings.defaultSize.height
    }
}
