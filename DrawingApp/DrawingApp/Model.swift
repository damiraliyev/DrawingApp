//
//  Model.swift
//  DrawingApp
//
//  Created by Damir Aliyev on 19.10.2022.
//

import Foundation
import UIKit


protocol Drawable {
    func drawFigure(context: CGContext, startPoint: CGPoint, endPoint: CGPoint)
}


enum Figures {
    case circle
    case rectangle
    case triangle
    case line
    case pen
}


struct Model {
    var shape: Figures
    var isNeedToFill: Bool
    var color: UIColor
}

class Circle: Drawable {
    
    func drawFigure(context:CGContext, startPoint: CGPoint, endPoint: CGPoint) {
        var startPoint = startPoint
        var endPoint = endPoint
        let radius = sqrt(pow(startPoint.x - endPoint.x, 2) + pow(startPoint.y - endPoint.y, 2)) / 2

        let center = CGPoint(x: (startPoint.x + endPoint.x) / 2, y: (startPoint.y + endPoint.y) / 2)
        context.addArc(center: center, radius: radius, startAngle: 0, endAngle:6.28319, clockwise: true)
        context.strokePath()
        startPoint.x = 0
        startPoint.y = 0
        endPoint.x = 0
        endPoint.y = 0
    }
}

class Rectangle: Drawable {
    func drawFigure(context: CGContext, startPoint: CGPoint, endPoint: CGPoint) {
        
    }
    
    
}

class Triangle: Drawable {
    func drawFigure(context: CGContext, startPoint: CGPoint, endPoint: CGPoint) {
        var startPoint = startPoint
        var endPoint = endPoint
        context.move(to: startPoint)
        context.addLine(to: endPoint)
        context.addLines(between: [endPoint, CGPoint(x: endPoint.x, y: startPoint.y)])
        context.addLines(between: [startPoint, CGPoint(x: endPoint.x, y: startPoint.y)])
        
        startPoint.x = 0
        startPoint.y = 0
        endPoint.x = 0
        endPoint.y = 0
//        UIColor.yellow.setStroke()
        context.strokePath()
    }
    
    
}

class Canvas: UIView {
    var model = Model(shape: .circle, isNeedToFill: false, color: .black)
    var shape = Figures.triangle
    let circle = Circle()
    let rectangle = Rectangle()
    let triangle = Triangle()
    
    var startPoint = CGPoint()
    var endPoint = CGPoint()
    
    var line = [CGPoint]()
    var lines = [[CGPoint]]()

    var x = CGFloat()
    var y = CGFloat()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
//        shape = model.shape
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
        
//        context.move(to: startPoint)
//        context.addLine(to: endPoint)
//        //        context.addLine(to: CGPoint(x: endCoordinates.x, y: startCoordinates.y))
//        //        context.addLines(between: [startCoordinates, endCoordinates])
//        //        context.move(to: CGPoint(x: endCoordinates.x, y: startCoordinates.y))
//        //        context.addLine(to: endCoordinates)
//        context.addLines(between: [endPoint, CGPoint(x: endPoint.x, y: startPoint.y)])
//        context.addLines(between: [startPoint, CGPoint(x: endPoint.x, y: startPoint.y)])
        
        
        //
        
//        context.strokePath()
        
    
        model.color.setStroke()
        shape = model.shape
        print(shape)
        print(model.shape)
        if shape == .triangle {
//            print(shape)
            triangle.drawFigure(context: context , startPoint: startPoint, endPoint: endPoint)
        } else if shape == .circle {
            print("here")
            circle.drawFigure(context: context , startPoint: startPoint, endPoint: endPoint)
        } else if shape == .rectangle {
            rectangle.drawFigure(context: context, startPoint: startPoint, endPoint: endPoint)
        }
       
//        startPoint.x = 0
//        startPoint.y = 0
//
//        endPoint.x = 0
//        endPoint.y = 0
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let firstTouch = touches.first else { return }
        
        startPoint.x = 0
        startPoint.y = 0

        
        endPoint.x = 0
        endPoint.y = 0
        
        startPoint.x = firstTouch.location(in: self).x
        startPoint.y = firstTouch.location(in: self).y
        
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
//        guard var touch = lines.popLast() else { return }
        
        endPoint.x = x
        endPoint.y = y
       
        

        setNeedsDisplay()
    }
    
    func drawLine() {
        
    }
    
}
