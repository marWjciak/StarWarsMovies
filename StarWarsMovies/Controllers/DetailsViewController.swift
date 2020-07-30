//
//  DetailsViewController.swift
//  StarWarsMovies
//
//  Created by Marcin Wójciak on 27/07/2020.
//

import Alamofire
import Spinners
import UIKit

class DetailsViewController: UITableViewController {
    var items: [String]
    var type: Displayable.Type
    var fetchedItems: [Displayable] = []
    var loadingIndicator = Spinners()
    var expandedIndexPath: IndexPath?

    init(for items: [String], of type: Displayable.Type) {
        self.items = items
        self.type = type
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

        fetchList()
    }

    func configureTableView() {
        title = ""
        tableView.backgroundColor = .black
        tableView.separatorStyle = .none
        tableView.separatorColor = .systemYellow
        tableView.register(DetailsTableViewCell.self, forCellReuseIdentifier: "characterCell")
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell") as! DetailsTableViewCell
        cell.set(with: fetchedItems[indexPath.row])

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

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        return title
    }

    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = .black
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = .systemYellow
        header.textLabel?.font = UIFont(name: "Hoefler Text", size: 25)
    }
}

extension DetailsViewController {
    func fetch<T: Decodable & Displayable>(_ list: [String], of: T.Type) {
        var items: [T] = []
        let fetchGroup = DispatchGroup()

        loadingIndicator.present()
        list.forEach { url in
            fetchGroup.enter()
            AF.request(url)
                .validate()
                .responseDecodable(of: T.self) { response in
                    guard let data = response.value else { return }

                    items.append(data)
                    fetchGroup.leave()
                }
        }
        fetchGroup.notify(queue: .main) {
            self.fetchedItems = items
            self.title = items[0].headTitle
            self.tableView.reloadData()
            self.tableView.separatorStyle = .singleLine
            self.loadingIndicator.dismiss()
        }
    }

    func fetchList() {
        switch type {
            case is Character.Type:
                fetch(items, of: Character.self)
            case is Vehicle.Type:
                fetch(items, of: Vehicle.self)
            case is Starship.Type:
                fetch(items, of: Starship.self)
            default:
                print("Unknow type: ", String(describing: type))
        }
    }
}
