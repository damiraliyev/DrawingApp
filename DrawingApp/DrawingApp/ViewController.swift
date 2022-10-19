//
//  ViewController.swift
//  DrawingApp
//
//  Created by Damir Aliyev on 19.10.2022.
//

import UIKit

class Canvas: UIView {
    
    var line = [CGPoint]()
    var lines = [[CGPoint]]()
    var firstTouchCoordinates = (x: CGFloat(),y: CGFloat())
    var lastTouchCoordinates = (x: CGFloat(),y: CGFloat())
    var touchEnded = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        print(lines)
        for line in lines {
            for point in line {
                
                    if line.firstIndex(of: point) == 0 {
                        context.move(to: point)
                    } else {
                        context.addLine(to: point)
                    }
                
                
            }
            
        }
        
        context.strokePath()
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let firstTouch = touches.first else { return }
        
        firstTouchCoordinates.0 = firstTouch.location(in: self).x
        firstTouchCoordinates.1 = firstTouch.location(in: self).y
        
        lines.append([CGPoint]())
//        setNeedsDisplay()
        
        
//        print(lastTouchX)
        
        
    }
    
   
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else{ return }
        
        firstTouchCoordinates.x = touch.location(in: self).x
        firstTouchCoordinates.y = touch.location(in: self).y
        
        guard var lastLine = lines.popLast() else { return }
        lastLine.append(touch.location(in: self))
        lines.append(lastLine)

        
        setNeedsDisplay()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        firstTouchCoordinates.x = 0
        firstTouchCoordinates.y = 0

        setNeedsLayout()
    }
    
    func drawLine() {
        
    }
    
}

class ViewController: UIViewController {
    
    override func viewWillLayoutSubviews() {
        canvas.frame = view.frame
    }
    let canvas = Canvas()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
    }
    
    func setup() {
        view.addSubview(canvas)
        canvas.backgroundColor = .white
        canvas.frame = view.frame
    }


}

