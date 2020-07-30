//
//  PageViewController.swift
//  StarWarsMovies
//
//  Created by Marcin Wójciak on 27/07/2020.
//

import UIKit

class PageViewController: UIPageViewController {
    var film: Film
    var myControllers = [UIViewController]()

    init(for film: Film) {
        self.film = film
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.preparePageController()
        UIPageControl.appearance().pageIndicatorTintColor = .darkGray
        UIPageControl.appearance().currentPageIndicatorTintColor = .systemYellow
    }

    func preparePageController() {
        self.delegate = self
        self.dataSource = self

        let filmVC = MovieMainViewController(for: film)
        let charactersVC = DetailsViewController(for: film.characters, of: Character.self)
        let vehiclesVC = DetailsViewController(for: film.vehicles, of: Vehicle.self)
        let starshipsVC = DetailsViewController(for: film.starships, of: Starship.self)

        myControllers.append(filmVC)
        myControllers.append(charactersVC)
        myControllers.append(vehiclesVC)
        myControllers.append(starshipsVC)

        guard let first = myControllers.first else { return }
        self.setViewControllers([first], direction: .forward, animated: true, completion: nil)
    }
}

extension PageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = myControllers.firstIndex(of: viewController), index > 0 else { return nil }

        let before = index - 1

        return self.myControllers[before]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = myControllers.firstIndex(of: viewController), index < (myControllers.count - 1) else { return nil }

        let after = index + 1

        return self.myControllers[after]
    }

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.myControllers.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
}
