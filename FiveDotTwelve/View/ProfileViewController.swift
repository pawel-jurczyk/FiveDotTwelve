//
//  ProfileViewController.swift
//  FiveDotTwelve
//
//  Created by Pawel on 25/02/2020.
//  Copyright (c) 2020 Pawel Jurczyk. All rights reserved.
//

import UIKit

protocol ProfileViewControllerProtocol: AnyObject {
    func presentUserProfile(_ profile: Profile)
    func showLoader()
    func hideLoader()
    func showError(message: String)
}

final class ProfileViewController: UIViewController {
    var interactor: ProfileInteractorProtocol?
    
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private var collectionView: UICollectionView! {
        didSet {
            configureCollectionView()
        }
    }
    @IBOutlet var titleLabel: UILabel! {
        didSet {
            titleLabel.attributedText = "PHOBOS".attributedString(withKern: 0.55, color: .white)
        }
    }
    let dataSource = ProfileCollectionViewDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.viewDidLoad()
        registerCells()
        view.insetsLayoutMarginsFromSafeArea = false
        modalPresentationCapturesStatusBarAppearance = false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func registerCells() {
        [PhotoCollectionViewCell.self,
         ProfileInfoCollectionViewCell.self,
         SegmentsCollectionViewCell.self].forEach { cell in
            let name = String(describing: cell)
            collectionView.register(UINib(nibName: name, bundle: nil), forCellWithReuseIdentifier: name)
        }
    }
    
    private func configureCollectionView() {
        collectionView.dataSource = dataSource
        collectionView.prefetchDataSource = dataSource
        collectionView.delegate = self
        collectionView.refreshControl = UIRefreshControl()
        collectionView.refreshControl?.addTarget(interactor, action: #selector(ProfileInteractor.refresh), for: .valueChanged)
        collectionView.collectionViewLayout = flowLayout()
        collectionView.insetsLayoutMarginsFromSafeArea = false
    }
    
    private func flowLayout() -> UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        flowLayout.sectionInset = .zero
        return flowLayout
    }
}

extension ProfileViewController: ProfileViewControllerProtocol {
    func presentUserProfile(_ profile: Profile) {
        dataSource.profile = profile
        collectionView.reloadData()
    }
    
    func showLoader() {
        activityIndicator.startAnimating()
    }
    
    func hideLoader() {
        activityIndicator.stopAnimating()
        collectionView.refreshControl?.endRefreshing()
    }
    
    func showError(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            return .init(width: collectionView.bounds.width, height: 447)
        case 1:
            return .init(width: collectionView.bounds.width, height: 47)
        case 2:
            let dimension = collectionView.bounds.width / 2
            return .init(width: dimension, height: dimension)
        default:
            return .zero
        }
    }
}
