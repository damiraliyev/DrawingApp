//
//  ViewController.swift
//  DrawingApp
//
//  Created by Damir Aliyev on 19.10.2022.
//

import UIKit



class ViewController: UIViewController {
    let drawingVC = DrawingViewController()
    var model = Model(shape: .pen, isNeedToFill: false, color: .black)
    let undoIsPressing = false
    
    override func viewWillLayoutSubviews() {
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
    }
    
    func setup() {
        addChild(drawingVC)
        drawingVC.view.frame = view.frame
        view.addSubview(drawingVC.view)
        drawingVC.didMove(toParent: self)

        for colorButton in drawingVC.headerView.colors {
            colorButton.addTarget(self, action: #selector(changeColor), for: .primaryActionTriggered)
        }
        
        for shapeButton in drawingVC.headerView.shapes {
            shapeButton.addTarget(self, action: #selector(changeShape), for: .primaryActionTriggered)
        }
        
        drawingVC.headerView.isFill.addTarget(self, action: #selector(fillSwitchToggled), for: .primaryActionTriggered)
        
        drawingVC.headerView.undoButton.addTarget(self, action: #selector(undoPressed), for: .primaryActionTriggered)
    }
    
    @objc func changeShape(_ sender: UIButton) {
        let shapes = drawingVC.headerView.shapes
        if shapes.firstIndex(of: sender) == 0 {
            print("circle")
            drawingVC.canvas.model.shape = .circle
        } else if shapes.firstIndex(of: sender) == 1 {
            drawingVC.canvas.model.shape = .rectangle
        } else if shapes.firstIndex(of: sender) == 2 {
            print("Triangle")
            drawingVC.canvas.model.shape = .triangle
        } else if shapes.firstIndex(of: sender) == 3 {
            drawingVC.canvas.model.shape = .line
        } else if shapes.firstIndex(of: sender) == 4 {
            drawingVC.canvas.model.shape = .pen
        }
    }
    
    @objc func changeColor(_ sender: UIButton) {
        print("pressed")
        let colors = drawingVC.headerView.colors
        if colors.firstIndex(of: sender) == 0 {
            drawingVC.canvas.model.color = .orange
        } else if colors.firstIndex(of: sender) == 1 {
            drawingVC.canvas.model.color = .cyan
        } else if colors.firstIndex(of: sender) == 2 {
            drawingVC.canvas.model.color = .purple
        } else if colors.firstIndex(of: sender) == 3 {
            drawingVC.canvas.model.color = .systemPink
        } else if colors.firstIndex(of: sender) == 4 {
            drawingVC.canvas.model.color = .red
        } else if colors.firstIndex(of: sender) == 5 {
            drawingVC.canvas.model.color = .green
        } else if colors.firstIndex(of: sender) == 6 {
            drawingVC.canvas.model.color = .yellow
        } else if colors.firstIndex(of: sender) == 7 {
            drawingVC.canvas.model.color = .brown
        } else if colors.firstIndex(of: sender) == 8 {
            drawingVC.canvas.model.color = .black
        }

    }
    
    @objc func fillSwitchToggled(_ sender: UIButton) {
        print(drawingVC.headerView.isFill.isOn)
        drawingVC.canvas.model.isNeedToFill = drawingVC.headerView.isFill.isOn
    }
    
    @objc func undoPressed(_ sender: UIButton) {
        let previousFigure = drawingVC.canvas.figures.popLast()
        drawingVC.canvas.undoIsPressing = true
        drawingVC.canvas.setNeedsDisplay()
    }

}

