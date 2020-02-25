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
}

final class ProfileViewController: UIViewController {
    var interactor: ProfileInteractorProtocol?
    
    @IBOutlet private var collectionView: UICollectionView! {
        didSet {
            configureCollectionView()
        }
    }
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!
    let dataSource = ProfileCollectionViewDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.viewDidLoad()
        registerCells()
        view.insetsLayoutMarginsFromSafeArea = false
//        collectionView.contentOffset = .init(x: 0, y: -view.safeAreaInsets.top)
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
        collectionView.delegate = self
        let flowLayout = UICollectionViewFlowLayout()
        collectionView.collectionViewLayout = flowLayout
        collectionView.insetsLayoutMarginsFromSafeArea = false
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
