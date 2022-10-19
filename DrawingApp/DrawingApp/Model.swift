//
//  Model.swift
//  DrawingApp
//
//  Created by Damir Aliyev on 19.10.2022.
//

import Foundation
import UIKit


protocol Drawable {
    func drawFigure(startPoint: CGPoint, lastPoint: CGPoint)
}

enum Figures {
    case circle
    case rectangle
    case triangle
    case line
    case pen
}

class Circle: Drawable {
    
    func drawFigure(startPoint: CGPoint, lastPoint: CGPoint) {
//        let radius = sqrt(pow(firstTouchCoordinates.x - lastTouchCoordinates.x, 2) + pow(firstTouchCoordinates.y - lastTouchCoordinates.y, 2)) / 2
//
//
//        context.addArc(center: CGPoint(x: (firstTouchCoordinates.x + lastTouchCoordinates.x) / 2, y:  (firstTouchCoordinates.y + lastTouchCoordinates.y) / 2), radius: radius, startAngle: 0, endAngle:6.28319, clockwise: true)
    }
}
class Canvas: UIView {
    
    let circle = Circle()
    
    var startPoint = CGPoint()
    var endPoint = CGPoint()
    
    var line = [CGPoint]()
    var lines = [[CGPoint]]()
    var circles = [[UIBezierPath]()]
    var firstTouchCoordinates = (x: CGFloat(),y: CGFloat())
    var lastTouchCoordinates = (x: CGFloat(),y: CGFloat())

    
    var touchEnded = false
    var x = CGFloat()
    var y = CGFloat()
    
    
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
        //        print(lines)
        //        for line in lines {
        //            for point in line {
        //
        //                    if line.firstIndex(of: point) == 0 {
        //                        context.move(to: point)
        //                    } else {
        //                        context.addLine(to: point)
        //                    }
        //
        //
        //            }
        //
        //        }
        
        //        var textPoint = CGPoint(x: 100, y: 100)
        //        var textAnotherPoint = CGPoint(x: 150, y: 150)
        
        
        //MARK: How to draw circle
        
        
//        let radius = sqrt(pow(firstTouchCoordinates.x - lastTouchCoordinates.x, 2) + pow(firstTouchCoordinates.y - lastTouchCoordinates.y, 2)) / 2
//
//
//        context.addArc(center: CGPoint(x: (firstTouchCoordinates.x + lastTouchCoordinates.x) / 2, y:  (firstTouchCoordinates.y + lastTouchCoordinates.y) / 2), radius: radius, startAngle: 0, endAngle:6.28319, clockwise: true)
        
        //MARK: How to draw trianglec
        
        let startCoordinates = CGPoint(x: firstTouchCoordinates.x, y: firstTouchCoordinates.y)
        let endCoordinates = CGPoint(x: lastTouchCoordinates.x, y: lastTouchCoordinates.y)
        
        context.move(to: startCoordinates)
        context.addLine(to: endCoordinates)
        //        context.addLine(to: CGPoint(x: endCoordinates.x, y: startCoordinates.y))
        //        context.addLines(between: [startCoordinates, endCoordinates])
        //        context.move(to: CGPoint(x: endCoordinates.x, y: startCoordinates.y))
        //        context.addLine(to: endCoordinates)
        context.addLines(between: [endCoordinates, CGPoint(x: endCoordinates.x, y: startCoordinates.y)])
        context.addLines(between: [startCoordinates, CGPoint(x: endCoordinates.x, y: startCoordinates.y)])
        
        
        //
        
        context.strokePath()
        print(firstTouchCoordinates.x, "first x")
        print(firstTouchCoordinates.y, "first y")
        print(lastTouchCoordinates.x, "last x")
        print(lastTouchCoordinates.y, "last x")
        print("redrawn")
        
        circle.drawFigure(context: context)
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let firstTouch = touches.first else { return }
        
        lastTouchCoordinates.x = 0
        lastTouchCoordinates.y = 0
        
        firstTouchCoordinates.0 = firstTouch.location(in: self).x
        firstTouchCoordinates.1 = firstTouch.location(in: self).y
        
        lines.append([CGPoint]())
//        setNeedsDisplay()
        
        
//        print(lastTouchX)
        
        
    }
    
   
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else{ return }
        
//        firstTouchCoordinates.x = touch.location(in: self).x
//        firstTouchCoordinates.y = touch.location(in: self).y
        
        guard var lastLine = lines.popLast() else { return }
        
       
        x = touch.location(in: self).x
        y = touch.location(in: self).y
        
        print(x)
        print(y)
       
//        circles.append(circle)
        
        lastLine.append(touch.location(in: self))
        lines.append(lastLine)

        
//        setNeedsDisplay()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        guard var touch = lines.popLast() else { return }
        lastTouchCoordinates.x =  x
        lastTouchCoordinates.y = y
        

        setNeedsDisplay()
    }
    
    func drawLine() {
        
    }
    
}
