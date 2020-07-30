//
//  SimpleTableViewCell.swift
//  StarWarsMovies
//
//  Created by Marcin Wójciak on 25/07/2020.
//

import UIKit

class SimpleTableViewCell: UITableViewCell {
    var titleLabel = UILabel()
    var subtitleLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .black
        contentView.backgroundColor = .black
        selectionStyle = .none
        addSubview(titleLabel)
        addSubview(subtitleLabel)

        configureTitle()
        configureSubtitle()
        setTitleLabelConstraints()
        setSubtitleLabelConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has never been implemented...")
    }

    func set(film: Film) {
        titleLabel.text = film.title
        subtitleLabel.text = "Episode \(film.id)"
    }

    func configureTitle() {
        titleLabel.numberOfLines = 0
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.textColor = .systemYellow
        titleLabel.font = UIFont(name: "Hoefler Text", size: 25)
    }

    func configureSubtitle() {
        subtitleLabel.numberOfLines = 0
        subtitleLabel.adjustsFontSizeToFitWidth = true
        subtitleLabel.textColor = .systemYellow
        subtitleLabel.font = UIFont(name: "Papyrus", size: 15)
    }

    func setTitleLabelConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 20).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }

    func setSubtitleLabelConstraints() {
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        subtitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 5).isActive = true
        subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
    }
}
