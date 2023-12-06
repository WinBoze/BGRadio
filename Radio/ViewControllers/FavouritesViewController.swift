//
//  FavouritesViewController.swift
//  Radio
//
//  Created by Petko Tankov on 2.12.23.
//

import UIKit

class FavouritesViewController: UIViewController {
    
    var savedStations: [Station]?
    
    @IBOutlet weak var stationTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.getSavedStations()
    }
    
    func setupTableView() {
        self.stationTableView.delegate = self
        self.stationTableView.dataSource = self
        let tableCellNibName = UINib(nibName: "RadioStationTableViewCell", bundle: nil)
        stationTableView.register(tableCellNibName, forCellReuseIdentifier: "RadioStationTableViewCell")
    }
    
    func getSavedStations() {
        self.savedStations = []
        guard let savedStat = UserDefaults.standard.object(forKey: "savedStations") as? Data else {
            DispatchQueue.main.async {
                self.infiniteToastMessage("Нямате Любими Станции")
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    _ = self.tabBarController?.selectedIndex = 0
                }
            }
            return
        }
        do {
            let decoder = JSONDecoder()
            let saved = try decoder.decode([Station].self, from: savedStat)
            self.savedStations = saved
            if saved.count == 0 {
                DispatchQueue.main.async {
                    self.infiniteToastMessage("Нямате Любими Станции")
                }
            }
            self.stationTableView.reloadData()
        } catch let err {
            print(err)
        }
    }
    @IBAction func settingsBtnPressed(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false, completion: nil)
    }
}

extension FavouritesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.savedStations?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RadioStationTableViewCell") as? RadioStationTableViewCell
        let station = self.savedStations?[indexPath.row]
        cell?.stationTitle.text = station?.radioName
        cell?.stationLogo.kf.setImage(with: URL(string:station?.radioPic ?? ""), placeholder: UIImage())
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let station = self.savedStations?[indexPath.row]
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PlayerViewController") as! PlayerViewController
        vc.currentStation = station
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false, completion: nil)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
