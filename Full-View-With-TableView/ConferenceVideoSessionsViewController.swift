//
//  ConferenceVideoSessionsViewController.swift
//  Full-View-With-TableView
//
//  Created by Muhammad Rajab on 30-07-2024.
//

import UIKit

class ConferenceVideoController {

    struct Video: Hashable {
        let title: String
        let category: String
        let identifier = UUID()
    }

    struct VideoCollection: Hashable {
        let title: String
        let videos: [Video]
        let identifier = UUID()
    }

    var collections: [VideoCollection] {
        return _collections
    }

    init() {
        generateCollections()
    }
    fileprivate var _collections = [VideoCollection]()
}

extension ConferenceVideoController {
    func generateCollections() {
        _collections = [
            VideoCollection(title: "The New iPad Pro",
                            videos: [Video(title: "Bringing Your Apps to the New iPad Pro", category: "Tech Talks"),
                                     Video(title: "Designing for iPad Pro and Apple Pencil", category: "Tech Talks")]),

            VideoCollection(title: "iPhone and Apple Watch",
                            videos: [Video(title: "Building Apps for iPhone XS, iPhone XS Max, and iPhone XR",
                                            category: "Tech Talks"),
                                      Video(title: "Designing for Apple Watch Series 4",
                                            category: "Tech Talks"),
                                      Video(title: "Developing Complications for Apple Watch Series 4",
                                            category: "Tech Talks"),
                                      Video(title: "What's New in Core NFC",
                                            category: "Tech Talks")]),

            VideoCollection(title: "App Store Connect",
                            videos: [Video(title: "App Store Connect Basics", category: "App Store Connect"),
                                      Video(title: "App Analytics Retention", category: "App Store Connect"),
                                      Video(title: "App Analytics Metrics", category: "App Store Connect"),
                                      Video(title: "App Analytics Overview", category: "App Store Connect"),
                                      Video(title: "TestFlight", category: "App Store Connect")]),

            VideoCollection(title: "Apps on Your Wrist",
                            videos: [Video(title: "What's new in watchOS", category: "Conference 2018"),
                                      Video(title: "Updating for Apple Watch Series 3", category: "Tech Talks"),
                                      Video(title: "Planning a Great Apple Watch Experience",
                                            category: "Conference 2017"),
                                      Video(title: "News Ways to Work with Workouts", category: "Conference 2018"),
                                      Video(title: "Siri Shortcuts on the Siri Watch Face",
                                            category: "Conference 2018"),
                                      Video(title: "Creating Audio Apps for watchOS", category: "Conference 2018"),
                                      Video(title: "Designing Notifications", category: "Conference 2018")]),

            VideoCollection(title: "Speaking with Siri",
                            videos: [Video(title: "Introduction to Siri Shortcuts", category: "Conference 2018"),
                                     Video(title: "Building for Voice with Siri Shortcuts",
                                           category: "Conference 2018"),
                                     Video(title: "What's New in SiriKit", category: "Conference 2017"),
                                     Video(title: "Making Great SiriKit Experiences", category: "Conference 2017"),
                                     Video(title: "Increase Usage of You App With Proactive Suggestions",
                                           category: "Conference 2018")])
        ]
    }
}

class ConferenceVideoSessionsViewController: UIViewController {

    let videosController = ConferenceVideoController()
    var collectionView: UICollectionView! = nil
    var dataSource: UICollectionViewDiffableDataSource
        <ConferenceVideoController.VideoCollection, ConferenceVideoController.Video>! = nil
    var currentSnapshot: NSDiffableDataSourceSnapshot
        <ConferenceVideoController.VideoCollection, ConferenceVideoController.Video>! = nil
    static let titleElementKind = "title-element-kind"

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Conference Videos"
        configureHierarchy()
        configureDataSource()
    }
}

extension ConferenceVideoSessionsViewController {
    func createLayout() -> UICollectionViewLayout {
        let sectionProvider = { (sectionIndex: Int,
            layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                 heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)

            // if we have the space, adapt and go 2-up + peeking 3rd item
            let groupFractionalWidth = CGFloat(layoutEnvironment.container.effectiveContentSize.width > 500 ?
                0.425 : 0.85)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(groupFractionalWidth),
                                                  heightDimension: .absolute(250))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            section.interGroupSpacing = 20
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)

            let titleSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .estimated(44))
            let titleSupplementary = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: titleSize,
                elementKind: ConferenceVideoSessionsViewController.titleElementKind,
                alignment: .top)
            section.boundarySupplementaryItems = [titleSupplementary]
            return section
        }

        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20

        let layout = UICollectionViewCompositionalLayout(
            sectionProvider: sectionProvider, configuration: config)
        return layout
    }
}

extension ConferenceVideoSessionsViewController {
    func configureHierarchy() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
    func configureDataSource() {
        
        let cellRegistration = UICollectionView.CellRegistration
        <ConferenceVideoCell, ConferenceVideoController.Video> { (cell, indexPath, video) in
            // Populate the cell with our item description.
            cell.titleLabel.text = video.title
            cell.categoryLabel.text = video.category
        }
        
        dataSource = UICollectionViewDiffableDataSource
        <ConferenceVideoController.VideoCollection, ConferenceVideoController.Video>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, video: ConferenceVideoController.Video) -> UICollectionViewCell? in
            // Return the cell.
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: video)
        }
        
        let supplementaryRegistration = UICollectionView.SupplementaryRegistration
        <TitleSupplementaryView>(elementKind: ConferenceVideoSessionsViewController.titleElementKind) {
            (supplementaryView, string, indexPath) in
            if let snapshot = self.currentSnapshot {
                // Populate the view with our section's description.
                let videoCategory = snapshot.sectionIdentifiers[indexPath.section]
                supplementaryView.label.text = videoCategory.title
            }
        }
        
        dataSource.supplementaryViewProvider = { (view, kind, index) in
            return self.collectionView.dequeueConfiguredReusableSupplementary(
                using: supplementaryRegistration, for: index)
        }
        
        currentSnapshot = NSDiffableDataSourceSnapshot
            <ConferenceVideoController.VideoCollection, ConferenceVideoController.Video>()
        videosController.collections.forEach {
            let collection = $0
            currentSnapshot.appendSections([collection])
            currentSnapshot.appendItems(collection.videos)
        }
        dataSource.apply(currentSnapshot, animatingDifferences: false)
    }
}

class ConferenceVideoCell: UICollectionViewCell {

    static let reuseIdentifier = "video-cell-reuse-identifier"
    let imageView = UIImageView()
    let titleLabel = UILabel()
    let categoryLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension ConferenceVideoCell {
    func configure() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(categoryLabel)

        titleLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        titleLabel.adjustsFontForContentSizeCategory = true
        categoryLabel.font = UIFont.preferredFont(forTextStyle: .caption2)
        categoryLabel.adjustsFontForContentSizeCategory = true
        categoryLabel.textColor = .placeholderText

        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 1
        imageView.layer.cornerRadius = 4
        imageView.backgroundColor = .systemYellow

        let spacing = CGFloat(10)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),

            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: spacing),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            categoryLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            categoryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            categoryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            categoryLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ])
    }
}

class TitleSupplementaryView: UICollectionReusableView {
    let label = UILabel()
    static let reuseIdentifier = "title-supplementary-reuse-identifier"

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension TitleSupplementaryView {
    func configure() {
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        let inset = CGFloat(10)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -inset),
            label.topAnchor.constraint(equalTo: topAnchor, constant: inset),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -inset)
        ])
        label.font = UIFont.preferredFont(forTextStyle: .title3)
    }
}
