//
//  Copyright © 2023 Vitalii Ivashchenko. All rights reserved.
//

import UIKit

class UserScoreRatingView: UIView {
    
    // MARK: - Private properties
    private let circleLayer = CAShapeLayer()
    private let circularBackgroundLayer = CAShapeLayer()
    private let circularForegroundLayer = CAShapeLayer()
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontForContentSizeCategory = true
        label.font = .preferredFont(forTextStyle: .headline)
        label.maximumContentSizeCategory = .medium
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    // MARK: - Public properties
    var value: Double = 0
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    // MARK: - Private methods
    private func configureView() {
        let circlePath = UIBezierPath(
            arcCenter: .init(x: frame.size.width / 2, y: frame.size.height / 2),
            radius: frame.size.width / 2,
            startAngle: -.pi / 2,
            endAngle: 3 * .pi / 2,
            clockwise: true
        )
        
        circleLayer.fillColor = UIColor.backgroundUserScore.cgColor
        circleLayer.path = circlePath.cgPath
        
        configureShapeLayer(circularBackgroundLayer, with: circlePath)
        configureShapeLayer(circularForegroundLayer, with: circlePath)
        
        layer.addSublayer(circleLayer)
        layer.addSublayer(circularBackgroundLayer)
        layer.addSublayer(circularForegroundLayer)
        addSubview(valueLabel)
        
        NSLayoutConstraint.activate([
            valueLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            valueLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func configureShapeLayer(_ layer: CAShapeLayer, with circlePath: UIBezierPath) {
        layer.fillColor = UIColor.clear.cgColor
        layer.lineCap = .round
        layer.lineWidth = 5
        layer.path = circlePath.cgPath
        layer.strokeEnd = 1
    }
}
