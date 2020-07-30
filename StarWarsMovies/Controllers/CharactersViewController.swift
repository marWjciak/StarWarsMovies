//
//  CharactersViewController.swift
//  StarWarsMovies
//
//  Created by Marcin Wójciak on 27/07/2020.
//

import Alamofire
import Spinners
import UIKit

class CharactersViewController: UITableViewController {
    var film: Film
    var characters: [Character] = []
    var loadingIndicator = Spinners()
    var expandedIndexPath: IndexPath?

    init(for film: Film) {
        self.film = film
        super.init(style: .plain)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()

        loadingIndicator = Spinners(type: .cube, with: self)
        view.center = CGPoint(x: UIScreen.main.bounds.size.width * 0.5, y: UIScreen.main.bounds.size.height * 0.5)

        fetchCharacters()
    }

    func configureTableView() {
        tableView.backgroundColor = .black
        tableView.separatorStyle = .none
        tableView.separatorColor = .systemYellow
        tableView.register(DetailsTableViewCell.self, forCellReuseIdentifier: "characterCell")
    }

    func fetchCharacters() {
        var items: [Character] = []
        let fetchGroup = DispatchGroup()

        loadingIndicator.present()
        film.characters.forEach { characterUrl in
            fetchGroup.enter()
            AF.request(characterUrl)
                .validate()
                .responseDecodable(of: Character.self) { response in
                    guard let data = response.value else { return }

                    items.append(data)
                    fetchGroup.leave()
                }
        }
        fetchGroup.notify(queue: .main) {
            self.characters = items
            self.tableView.reloadData()
            self.loadingIndicator.dismiss()
            self.tableView.separatorStyle = .singleLine
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell") as! DetailsTableViewCell
        cell.set(with: characters[indexPath.row])

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.beginUpdates()

        if indexPath == expandedIndexPath {
            expandedIndexPath = nil
        } else {
            expandedIndexPath = indexPath
        }

        tableView.endUpdates()
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath == expandedIndexPath {
            return 300
        }

        return 100
    }
}
