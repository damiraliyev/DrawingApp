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
        addTapGestures()
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
        
        drawingVC.headerView.undoButton.addTarget(self, action: #selector(shortUndoPressed), for: .primaryActionTriggered)
    }
    
    func addTapGestures() {
        let shortPress = UITapGestureRecognizer(target: self, action: #selector(shortUndoPressed))
        shortPress.addTarget(self, action: #selector(handleTap))
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longUndoPressed))
        longPress.addTarget(self, action: #selector(handleLongPress))
        drawingVC.headerView.undoButton.addGestureRecognizer(shortPress)
        drawingVC.headerView.undoButton.addGestureRecognizer(longPress)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        
        sender.view?.alpha = 0.5
        
        UIView.animate(withDuration: 0.2, delay: 0) {
            sender.view?.alpha = 1
        }
    }
    
    @objc func handleLongPress(_ sender: UILongPressGestureRecognizer) {
        
        sender.view?.alpha = 0.3
        
        UIView.animate(withDuration: 1, delay: 0) {
            sender.view?.alpha = 1
        }
       
    }
    
    @objc func changeShape(_ sender: UIButton) {
        
        sender.animatePress()
        
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
        
        sender.animatePress()
        
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
    
    @objc func shortUndoPressed(_ sender: UIButton) {
        
        if drawingVC.canvas.figures.count != 0{
           
            let _ = drawingVC.canvas.figures.popLast()
            print(drawingVC.canvas.strokesArray.count)
            drawingVC.canvas.strokesArray.removeLast()
            
            guard drawingVC.canvas.strokesArray.last != nil else { return }
            
            drawingVC.canvas.model.color = drawingVC.canvas.strokesArray.last!
            drawingVC.canvas.undoIsPressing = true
            drawingVC.canvas.setNeedsDisplay()
        }
    }
    
    @objc func longUndoPressed(_ sender: UIButton) {
        drawingVC.canvas.undoIsPressing = true
        drawingVC.canvas.figures.removeAll()
        drawingVC.canvas.filledFigures.removeAll()
        drawingVC.canvas.strokesArray.removeAll()
        drawingVC.canvas.setNeedsDisplay()
        drawingVC.canvas.model.color.setStroke()
    }

}



extension UIButton {
    func animatePress() {
        alpha = 0.3
        
        UIView.animate(withDuration: 0.5, delay: 0) { [weak self] in
            self?.alpha = 1
        }
    }
}
