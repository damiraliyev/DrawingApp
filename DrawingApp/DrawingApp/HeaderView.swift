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
    var shapes = [UIButton]()
    
    let switchStack = makeStack(axis: .horizontal)
    let fillLabel = makeLabel(withText: "Fill")
    let isFill = UISwitch()
    
    let undoButton = makeImageButton(image: "undo")
    
    var colorsStack = makeStack(axis: .horizontal)
    var orangeColorButton = makeColorButton(color: .orange)
    var cyanColorButton = makeColorButton(color: .cyan)
    var purpleColorButton = makeColorButton(color: .purple)
    let pinkColorButton = makeColorButton(color: .systemPink)
    let redColorButton = makeColorButton(color: .red)
    let greenColorButton = makeColorButton(color: .green)
    let yellowColorButton = makeColorButton(color: .yellow)
    let brownColorButton = makeColorButton(color: .brown)
    let blackColorButton = makeColorButton(color: .black)
    var colors = [UIButton]()
    
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
        
        shapes = [circleButton, rectangleButton, triangleButton, lineButton, penButton]
        
        colors = [orangeColorButton, cyanColorButton, purpleColorButton, pinkColorButton,
        redColorButton, greenColorButton, yellowColorButton, brownColorButton, blackColorButton]
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
        colorsStack.addArrangedSubview(blackColorButton)
        
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
    button.setTitle(image, for: .normal)
    button.titleLabel?.isHidden = true
    button.heightAnchor.constraint(equalToConstant: 45).isActive = true
    button.widthAnchor.constraint(equalToConstant: 45).isActive = true
    
    return button
}

func makeColorButton(color: UIColor) -> UIButton{
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.backgroundColor = color
//    button.setTitle(color.name, for: .normal)

    
    return button
}

func makeLabel(withText text: String) -> UILabel {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = text
    label.font = UIFont.systemFont(ofSize: 16)
    
    return label
}



extension UIColor {
    var name: String? {
        switch self {
        case UIColor.black: return "black"
        case UIColor.darkGray: return "darkGray"
        case UIColor.lightGray: return "lightGray"
        case UIColor.white: return "white"
        case UIColor.gray: return "gray"
        case UIColor.red: return "red"
        case UIColor.green: return "green"
        case UIColor.blue: return "blue"
        case UIColor.cyan: return "cyan"
        case UIColor.yellow: return "yellow"
        case UIColor.magenta: return "magenta"
        case UIColor.orange: return "orange"
        case UIColor.purple: return "purple"
        case UIColor.brown: return "brown"
        case UIColor.systemPink: return "pink"
        default: return nil
        }
    }
}
