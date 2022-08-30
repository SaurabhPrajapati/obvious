//
//  PhotoDetailViewController.swift
//  NASAGalleryApp
//
//  Created by Saurabh on 30/08/22.
//

import UIKit
import Hero
import Kingfisher
import Combine

class PhotoDetailViewController: UIViewController {

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var indicatorView: UIActivityIndicatorView!
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var explanationLabel: UILabel!
    
    private let viewModel: PhotoDetailViewModel
    private var photoCancellable: AnyCancellable?
    
    init(viewModel: PhotoDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "PhotoDetailViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let vm = viewModel.photoModel {
            updateUI(vm)
        }
        
        animations()
        setupListener()
        addSwipeGestures()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.backButtonDisplayMode = .minimal
    }
    
    private func animations() {
        hero.isEnabled = true
        imageView.hero.isEnabled = true
        imageView.hero.modifiers = [.fade, .scale()]
        
        titleLabel.hero.isEnabled = true
        titleLabel.heroModifiers = [.translate(), .fade, .useGlobalCoordinateSpace]
        
        explanationLabel.hero.isEnabled = true
        explanationLabel.heroModifiers = [.translate(), .fade, .useGlobalCoordinateSpace]
    }
    
    private func setupListener() {
        photoCancellable = viewModel.$photoModel
            .receive(on: DispatchQueue.main)
            .compactMap({ $0 })
            .sink(receiveValue: { [weak self] viewModel in
                self?.updateUI(viewModel)
            })
    }
    
    private func updateUI(_ viewModel: PhotoViewModel) {
        imageView.hero.id = viewModel.getTitle()
        if let url = viewModel.getImageURL() {
            indicatorView.startAnimating()
            imageView.kf.setImage(with: url, placeholder: UIImage(systemName: "photo")) { [weak self] result in
                performOnMainThread {
                    self?.indicatorView.stopAnimating()
                }
            }
        }
        
        titleLabel.text = viewModel.getTitle()
        explanationLabel.text = viewModel.getExplanationText()
    }
    
    private func addSwipeGestures() {
        imageView.isUserInteractionEnabled = true
        
        let leftSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        leftSwipeGesture.direction = .left
        imageView.addGestureRecognizer(leftSwipeGesture)
        
        let rightSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        rightSwipeGesture.direction = .right
        imageView.addGestureRecognizer(rightSwipeGesture)
    }
    
    @objc private func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
        viewModel.swipe(gesture.direction)
    }
}
