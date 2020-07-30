//
//  DetailsTableViewCell.swift
//  StarWarsMovies
//
//  Created by Marcin Wójciak on 28/07/2020.
//

import Alamofire
import SwiftyJSON
import UIKit

class DetailsTableViewCell: UITableViewCell {
    var titleLabel = UILabel()
    var text1LeftLabel = UILabel()
    var text2LeftLabel = UILabel()
    var text1RightLabel = UILabel()
    var text2RightLabel = UILabel()
    var listTitleLabel = UILabel()
    var listView = UITableView()
    var items: [String] = []

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .black
        contentView.backgroundColor = .black
        clipsToBounds = true
        selectionStyle = .none

        addSubview(titleLabel)
        addSubview(text1LeftLabel)
        addSubview(text1RightLabel)
        addSubview(text2LeftLabel)
        addSubview(text2RightLabel)
        addSubview(listTitleLabel)
        addSubview(listView)

        configureLabel(for: titleLabel, fontName: "Hoefler Text", size: 20)
        configureLabel(for: text1LeftLabel, fontName: "Papyrus", size: 15)
        configureLabel(for: text2LeftLabel, fontName: "Papyrus", size: 15)
        configureLabel(for: text1RightLabel, fontName: "Papyrus", size: 15)
        configureLabel(for: text2RightLabel, fontName: "Papyrus", size: 15)
        configureLabel(for: listTitleLabel, fontName: "Papyrus", size: 15)
        configureListView()

        setTitleLabelConstraints()
        setText1LeftLabelConstraints()
        setText2LeftLabelConstraints()
        setText1RightLabelConstraints()
        setText2RightLabelConstraints()
        setListTitleLabelConstraints()
        setListViewConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has never been implemented...")
    }

    func set(with character: Displayable) {
        titleLabel.text = character.title
        text1LeftLabel.text = "\(character.text1Left.label) \(character.text1Left.value)"
        text2LeftLabel.text = "\(character.text2Left.label) \(character.text2Left.value)"
        text1RightLabel.text = "\(character.text1Right.label) \(character.text1Right.value)"
        text2RightLabel.text = "\(character.text2Right.label) \(character.text2Right.value)"
        listTitleLabel.text = "\(character.itemListTitle)"

        listView.dataSource = self
        listView.register(UITableViewCell.self, forCellReuseIdentifier: "characterFilmCell")
        let fetchGroup = DispatchGroup()
        var items: [String] = []
        character.itemList.forEach { url in
            fetchGroup.enter()
            AF.request(url)
                .validate()
                .responseJSON { response in
                    guard let data = response.data else { return }
                    let jsonData = JSON(data)
                    if let title = jsonData[character.itemListTitleKeyword].string {
                        items.append(title)
                    }
                    fetchGroup.leave()
                }
        }
        fetchGroup.notify(queue: .main) {
            self.items = items
            self.listView.reloadData()
        }
    }

    func configureLabel(for label: UILabel, fontName: String, size: CGFloat) {
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        label.textColor = .systemYellow
        label.font = UIFont(name: fontName, size: size)
    }

    func configureListView() {
        listView.allowsSelection = false
        listView.backgroundColor = .black
        listView.separatorColor = .systemYellow
    }

    func setTitleLabelConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }

    func setText1LeftLabelConstraints() {
        text1LeftLabel.translatesAutoresizingMaskIntoConstraints = false
        text1LeftLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        text1LeftLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        text1LeftLabel.trailingAnchor.constraint(lessThanOrEqualTo: centerXAnchor, constant: 10).isActive = true
    }

    func setText2LeftLabelConstraints() {
        text2LeftLabel.translatesAutoresizingMaskIntoConstraints = false
        text2LeftLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        text2LeftLabel.topAnchor.constraint(equalTo: text1LeftLabel.bottomAnchor).isActive = true
        text2LeftLabel.trailingAnchor.constraint(lessThanOrEqualTo: centerXAnchor, constant: 10).isActive = true
    }

    func setText1RightLabelConstraints() {
        text1RightLabel.translatesAutoresizingMaskIntoConstraints = false
        text1RightLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        text1RightLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        text1RightLabel.leadingAnchor.constraint(greaterThanOrEqualTo: centerXAnchor, constant: 10).isActive = true
    }

    func setText2RightLabelConstraints() {
        text2RightLabel.translatesAutoresizingMaskIntoConstraints = false
        text2RightLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        text2RightLabel.topAnchor.constraint(equalTo: text1RightLabel.bottomAnchor).isActive = true
        text2RightLabel.leadingAnchor.constraint(greaterThanOrEqualTo: centerXAnchor, constant: 10).isActive = true
    }

    func setListTitleLabelConstraints() {
        listTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        listTitleLabel.topAnchor.constraint(equalTo: text2LeftLabel.bottomAnchor, constant: 15).isActive = true
        listTitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }

    func setListViewConstraints() {
        listView.translatesAutoresizingMaskIntoConstraints = false
        listView.topAnchor.constraint(equalTo: listTitleLabel.bottomAnchor).isActive = true
        listView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        listView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        listView.bottomAnchor.constraint(greaterThanOrEqualTo: bottomAnchor, constant: -5).isActive = true
    }
}

extension DetailsTableViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "characterFilmCell")!
        cell.textLabel?.text = items[indexPath.row]
        cell.backgroundColor = .black
        if let textLabel = cell.textLabel {
            configureLabel(for: textLabel, fontName: "Papyrus", size: 15)
            textLabel.textAlignment = .center
        }

        return cell
    }
}
