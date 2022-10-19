//
//  HeaderView.swift
//  DrawingApp
//
//  Created by Damir Aliyev on 19.10.2022.
//

import Foundation
import UIKit

class HeaderView: UIView {
    
    var buttonsStack = makeStack(axis: .horizontal)

    let circleButton = makeImageButton(image: "circle")
    let rectangleButton = makeImageButton(image: "rectangle")
    let triangleButton = makeImageButton(image: "triangle")
    let lineButton = makeImageButton(image: "line")
    let penButton = makeImageButton(image: "pen")
    
    let switchStack = makeStack(axis: .horizontal)
    let fillLabel = makeLabel(withText: "Fill")
    let isFill = UISwitch()
    
    let undoButton = makeImageButton(image: "undo")
    
    
    var colorsStack = makeStack(axis: .horizontal)
    var orangeColorButton = UIButton()
    var cyanColorButton = UIButton()
    var purpleColorButton = UIButton()
    let pinkColorButton = UIButton()
    let redColorButton = UIButton()
    let greenColorButton = UIButton()
    let yellowColorButton = UIButton()
    let brownColorButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        
        setup()
        layout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        colorsStack.spacing = 3
        orangeColorButton.backgroundColor = .orange
        cyanColorButton.backgroundColor = .cyan
        purpleColorButton.backgroundColor = .purple
        pinkColorButton.backgroundColor = .systemPink
        redColorButton.backgroundColor = .red
        greenColorButton.backgroundColor = .green
        yellowColorButton.backgroundColor = .yellow
        brownColorButton.backgroundColor = .brown
        
    }
    
    func layout() {
        addSubview(buttonsStack)
        buttonsStack.addArrangedSubview(circleButton)
        buttonsStack.addArrangedSubview(rectangleButton)
        buttonsStack.addArrangedSubview(triangleButton)
        buttonsStack.addArrangedSubview(lineButton)
        buttonsStack.addArrangedSubview(penButton)
        
        addSubview(switchStack)
        switchStack.addArrangedSubview(fillLabel)
        switchStack.addArrangedSubview(isFill)
        
        addSubview(colorsStack)
        colorsStack.addArrangedSubview(orangeColorButton)
        colorsStack.addArrangedSubview(cyanColorButton)
        colorsStack.addArrangedSubview(purpleColorButton)
        colorsStack.addArrangedSubview(pinkColorButton)
        colorsStack.addArrangedSubview(redColorButton)
        colorsStack.addArrangedSubview(greenColorButton)
        colorsStack.addArrangedSubview(yellowColorButton)
        colorsStack.addArrangedSubview(brownColorButton)
        
        addSubview(undoButton)
        
        
        NSLayoutConstraint.activate([
            buttonsStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            buttonsStack.topAnchor.constraint(equalTo: topAnchor),
        ])
        
        NSLayoutConstraint.activate([
            switchStack.leadingAnchor.constraint(equalTo: buttonsStack.trailingAnchor, constant: 32),
            switchStack.centerYAnchor.constraint(equalTo: buttonsStack.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            colorsStack.trailingAnchor.constraint(equalTo: undoButton.leadingAnchor, constant: -16),
            colorsStack.centerYAnchor.constraint(equalTo: buttonsStack.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            undoButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            undoButton.centerYAnchor.constraint(equalTo: buttonsStack.centerYAnchor)
        ])
        
    }
//
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 150, height: 50)
    }

   
    
}
func makeStack(axis: NSLayoutConstraint.Axis) -> UIStackView {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = axis
    stackView.spacing = 15
    
    return stackView
}

func makeImageButton(image: String) -> UIButton {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setImage(UIImage(named: image), for: .normal)
    
    button.heightAnchor.constraint(equalToConstant: 45).isActive = true
    button.widthAnchor.constraint(equalToConstant: 45).isActive = true
    
    return button
}


func makeLabel(withText text: String) -> UILabel {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = text
    label.font = UIFont.systemFont(ofSize: 16)
    
    return label
}
