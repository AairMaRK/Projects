//
//  TextCell.swift
//  TryAnimation
//
//  Created by Egor Gryadunov on 14.07.2022.
//

import UIKit

final class TextCell: UICollectionViewCell {
    static var identifier: String { "TextCell" }

    var text: String {
        get { textView.text ?? "" }
        set { textView.text = newValue }
    }

    private var textView: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(textView)
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            textView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            textView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            textView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
