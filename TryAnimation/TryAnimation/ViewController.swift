//
//  ViewController.swift
//  TryAnimation
//
//  Created by Egor Gryadunov on 13.07.2022.
//

import UIKit

final class ViewController: UIViewController {
    // MARK: - Private properties
    private var state = State.smallImage
    private var imageConstraints1 = [NSLayoutConstraint]()
    private var imageConstraints2 = [NSLayoutConstraint]()
    private var dataSource: UICollectionViewDiffableDataSource<String, String>!
    private var animator: TransitioningAnimator?

    // MARK: - Subviews
    private(set) var imageview: UIImageView = {
        let view = UIImageView(image: UIImage(named: "koi"))
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        return view
    }()

    private(set) var placeholderView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private(set) lazy var button1: UIButton = { // TODO: Rename
        let view = UIButton()
        view.setTitle("1", for: .normal)
        view.backgroundColor = .white
        view.setTitleColor(.blue, for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
        return view
    }()

    private(set) lazy var button2: UIButton = { // TODO: Rename
        let view = UIButton()
        view.setTitle("2", for: .normal)
        view.backgroundColor = .white
        view.setTitleColor(.blue, for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(menuButtonDidTap), for: .touchUpInside)
        return view
    }()

    private(set) var sideMenu: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .blue
        return view
    }()

    private lazy var descriptionCollectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: createLayoutForCollection())
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemMint
        view.register(TextCell.self, forCellWithReuseIdentifier: TextCell.identifier)
        view.dataSource = dataSource
        return view
    }()

    private(set) var titleLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        view.font = UIFont.boldSystemFont(ofSize: 16)
        view.text = "Заголовок \nНа 2 строки"
        return view
    }()

    // MARK: - Overrided methods
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGestore = UITapGestureRecognizer(target: self, action: #selector(presentImage(_:)))
        imageview.isUserInteractionEnabled = true
        imageview.addGestureRecognizer(tapGestore)
        createDataSource()
        addSubviews()
        makeConstraints()
    }

    // MARK: - Public Methods
    func getAnimations() -> () -> Void {
        return {
            if self.state == .smallImage {
                self.sideMenu.layer.opacity = 1
                self.titleLabel.textColor = .black
            } else {
                self.sideMenu.layer.opacity = 0.5
                self.titleLabel.textColor = .white
            }
            self.view.superview?.layoutIfNeeded()
        }
    }

    func getImageSnapshot() -> UIView? {
        imageview.snapshotView(afterScreenUpdates: true)
    }

    func getSideMenuSnapshot() -> UIView? {
        sideMenu.snapshotView(afterScreenUpdates: true)
    }

    func getLabelSnapshot() -> UIView? {
        titleLabel.snapshotView(afterScreenUpdates: true)
    }
}

// MARK: - Supporting methods
private extension ViewController {
    enum State {
        case smallImage
        case fullImage
    }

    func addSubviews() {
        view.addSubview(imageview)
        view.addSubview(placeholderView)
        view.addSubview(button1)
        view.addSubview(button2)
        view.addSubview(sideMenu)
        placeholderView.addSubview(descriptionCollectionView)
        placeholderView.addSubview(titleLabel)
    }

    func makeConstraints() {
        imageConstraints1 = [
            imageview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            imageview.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            imageview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            imageview.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 2 / 3),
            sideMenu.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            titleLabel.topAnchor.constraint(equalTo: placeholderView.topAnchor, constant: 20),
            descriptionCollectionView.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 60)
        ]

        imageConstraints2 = [
            imageview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -50),
            imageview.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            imageview.heightAnchor.constraint(equalTo: view.heightAnchor),
            imageview.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.25),
            sideMenu.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 40),
            titleLabel.topAnchor.constraint(equalTo: placeholderView.topAnchor, constant: -80),
            descriptionCollectionView.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 80)
        ]

        NSLayoutConstraint.activate([
            placeholderView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            placeholderView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            placeholderView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            placeholderView.topAnchor.constraint(equalTo: imageview.bottomAnchor, constant: 0),
            button1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            button1.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            button1.heightAnchor.constraint(equalToConstant: 40),
            button1.widthAnchor.constraint(equalTo: button1.heightAnchor),
            button2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            button2.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            button2.heightAnchor.constraint(equalToConstant: 40),
            button2.widthAnchor.constraint(equalTo: button2.heightAnchor),
            sideMenu.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            sideMenu.widthAnchor.constraint(equalToConstant: 40),
            sideMenu.heightAnchor.constraint(equalToConstant: 120),
            descriptionCollectionView.leadingAnchor.constraint(equalTo: placeholderView.leadingAnchor, constant: 20),
            descriptionCollectionView.trailingAnchor.constraint(equalTo: placeholderView.trailingAnchor, constant: -20),
            descriptionCollectionView.bottomAnchor.constraint(equalTo: placeholderView.bottomAnchor, constant: 0),
            titleLabel.leadingAnchor.constraint(equalTo: placeholderView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: placeholderView.trailingAnchor, constant: -20)
        ])
        descriptionCollectionView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        NSLayoutConstraint.activate(imageConstraints1)
    }

    func createLayoutForCollection() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(60)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }

    func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<
            String, String
        >(collectionView: descriptionCollectionView) { collectionView, indexPath, id in
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TextCell.identifier,
                for: indexPath
            ) as? TextCell else {
                fatalError("Can not dequed cell")
            }
            cell.text = self.dataSource.itemIdentifier(for: indexPath) ?? ""
            return cell
        }

        var snapshot = NSDiffableDataSourceSnapshot<String, String>()
        snapshot.appendSections(["Main"])
        snapshot.appendItems([
            "Строка это два слова",
            "Еще строка",
            "И еще строка",
            "Строк много не бывает"
        ], toSection: "Main")
        dataSource.apply(snapshot, animatingDifferences: false)
    }

    private func animateChanges() {
        let controller = ImageViewController()
        controller.transitioningDelegate = self
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true)
    }
}

// MARK: - ObjC methods
@objc private extension ViewController {
    func presentImage(_ tapGesture: UITapGestureRecognizer) {
//        NSLayoutConstraint.deactivate(imageConstraints1)
//        NSLayoutConstraint.activate(imageConstraints2)
        state = .fullImage
        animateChanges()
    }

    func backButtonDidTap() {
        if state != .smallImage {
//            NSLayoutConstraint.deactivate(imageConstraints2)
//            NSLayoutConstraint.activate(imageConstraints1)
            state = .smallImage
        }
    }

    func menuButtonDidTap() {
        print("menu did tap")
    }
}

// MARK: - Transiting Delegate
extension ViewController: UIViewControllerTransitioningDelegate {
    func animationController(
        forPresented presented: UIViewController,
        presenting: UIViewController,
        source: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        guard let sourceViewController = presenting as? ViewController,
              let destinationViewController = presented as? ImageViewController
        else { return nil }

        animator = TransitioningAnimator(
            type: .present,
            sourceViewController: sourceViewController,
            destinationViewController: destinationViewController
        )
        return animator
    }
    
    func animationController(
        forDismissed dismissed: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        guard let destinationViewController = dismissed as? ImageViewController
        else { return nil }

        animator = TransitioningAnimator(
            type: .dismiss,
            sourceViewController: self,
            destinationViewController: destinationViewController
        )
        return animator
    }
}
