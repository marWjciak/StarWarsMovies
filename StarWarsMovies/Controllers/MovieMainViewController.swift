//
//  MovieMainViewController.swift
//  StarWarsMovies
//
//  Created by Marcin Wójciak on 27/07/2020.
//

import UIKit

class MovieMainViewController: UIViewController {
    @IBOutlet var filmImage: UIImageView!
    @IBOutlet var subtitle: UILabel!
    @IBOutlet var episode_id: UILabel!
    @IBOutlet var director: UILabel!
    @IBOutlet var producer: UILabel!
    @IBOutlet var releaseDate: UILabel!
    @IBOutlet var opening: UITextView!

    private let film: Film

    init(for film: Film) {
        self.film = film
        super.init(nibName: "MovieMainViewController", bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        completeView()

        // Do any additional setup after loading the view.
    }

    func completeView() {
        filmImage.image = UIImage(imageLiteralResourceName: String(film.id))
        subtitle.text = film.title
        episode_id.text = String(film.id)
        director.text = film.director
        producer.text = film.producer
        releaseDate.text = film.releaseDate
        opening.text = film.openingCrawl
    }

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
     }
     */
}
