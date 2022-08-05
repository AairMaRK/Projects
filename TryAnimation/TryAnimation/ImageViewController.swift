//
//  ImageViewController.swift
//  TryAnimation
//
//  Created by Egor Gryadunov on 14.07.2022.
//

import UIKit

class ImageViewController: UIViewController {
    private(set) var imageview: UIImageView = {
        let view = UIImageView(image: UIImage(named: "koi"))
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        return view
    }()

    private(set) var titleLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        view.textColor = .white
        view.font = UIFont.boldSystemFont(ofSize: 16)
        view.text = "Заголовок \nНа 2 строки"
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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageview)
        view.addSubview(button1)
        view.addSubview(button2)
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            imageview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -50),
            imageview.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            imageview.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.25),
            imageview.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            button1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            button1.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            button1.heightAnchor.constraint(equalToConstant: 40),
            button1.widthAnchor.constraint(equalTo: button1.heightAnchor),
            button2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            button2.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            button2.heightAnchor.constraint(equalToConstant: 40),
            button2.widthAnchor.constraint(equalTo: button2.heightAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            titleLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40)
        ])
    }

    func getImageSnapshot() -> UIView? {
        imageview.snapshotView(afterScreenUpdates: true)
    }
    
    func convert(for view: UIView, _ rect: CGRect, to coordinateSpace: UICoordinateSpace) -> CGRect {
        return view.convert(rect, to: coordinateSpace)
    }
    
    @objc private func backButtonDidTap() {
        self.dismiss(animated: true)
    }

    @objc private func menuButtonDidTap() {
        print("menu did tap")
    }
}
