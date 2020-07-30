//
//  MoviesDetailsTableViewController.swift
//  StarWarsMovies
//
//  Created by Marcin Wójciak on 24/07/2020.
//

import Alamofire
import UIKit

class MoviesDetailsTableViewController: UITableViewController {
    var films: [Film] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .black
        tableView.register(SimpleTableViewCell.self, forCellReuseIdentifier: K.shared.cellIdentifier)
        fetchFilms()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return films.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.shared.cellIdentifier, for: indexPath) as! SimpleTableViewCell
        let film = films[indexPath.row]

        cell.set(film: film)

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.present(PageViewController(for: films[indexPath.row]), animated: true, completion: nil)
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.height / CGFloat(films.count)
    }
}

extension MoviesDetailsTableViewController {
    func fetchFilms() {
        AF.request(K.shared.filmsUrl)
            .validate()
            .responseDecodable(of: Films.self) { response in
                guard let data = response.value else { return }

                self.films = data.all
                self.films.sort()
                self.tableView.reloadData()
            }
    }
}
