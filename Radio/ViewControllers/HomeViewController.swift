//
//  HomeViewController.swift
//  Radio
//
//  Created by Petko Tankov on 2.12.23.
//

import UIKit
import Kingfisher

class HomeViewController: UIViewController {
    
    @IBOutlet weak var stationTableView: UITableView!
    var stations: [Station]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.stations = loadJson(filename: "RadioStations")?.stations
        self.setupTableView()
    }
    
    func setupTableView() {
        self.stationTableView.delegate = self
        self.stationTableView.dataSource = self
        let tableCellNibName = UINib(nibName: "RadioStationTableViewCell", bundle: nil)
        stationTableView.register(tableCellNibName, forCellReuseIdentifier: "RadioStationTableViewCell")
    }
    
    func loadJson(filename fileName: String) -> RadioObject? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let jsonData = try Data(contentsOf: url)
                let radioObject = try? JSONDecoder().decode(RadioObject.self, from: jsonData)
                return radioObject
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.stations?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RadioStationTableViewCell") as? RadioStationTableViewCell
        let station = self.stations?[indexPath.row]
        cell?.stationTitle.text = station?.radioName
        cell?.stationLogo.kf.setImage(with: URL(string:station?.radioPic ?? ""), placeholder: UIImage())
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let station = self.stations?[indexPath.row]
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PlayerViewController") as! PlayerViewController
        vc.currentStation = station
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false, completion: nil)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
