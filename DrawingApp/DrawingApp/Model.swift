//
//  Model.swift
//  DrawingApp
//
//  Created by Damir Aliyev on 19.10.2022.
//

import Foundation
import UIKit


protocol Drawable {
    func drawFigure(context: CGContext, startPoint: CGPoint, endPoint: CGPoint, isNeedToFill: Bool) -> UIBezierPath
}


enum Figures {
    case circle
    case rectangle
    case triangle
    case line
    case pen
}


struct Model {
    var shape: Figures?
    var isNeedToFill: Bool
    var color: UIColor
}

class Circle: Drawable {
    
    func drawFigure(context:CGContext, startPoint: CGPoint, endPoint: CGPoint, isNeedToFill: Bool) -> UIBezierPath {
        
        let radius = sqrt(pow(startPoint.x - endPoint.x, 2) + pow(startPoint.y - endPoint.y, 2)) / 2
        let center = CGPoint(x: (startPoint.x + endPoint.x) / 2, y: (startPoint.y + endPoint.y) / 2)
        let path = UIBezierPath()
        path.addArc(withCenter: center, radius: radius, startAngle: 0, endAngle: 6.28319, clockwise: true)
        if isNeedToFill == true {
            path.fill()
        }
       
        path.stroke()
        print(path)
        return path
    }
}

class Rectangle: Drawable {
    func drawFigure(context: CGContext, startPoint: CGPoint, endPoint: CGPoint, isNeedToFill: Bool) -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: startPoint)
        path.addLine(to: CGPoint(x: endPoint.x, y: startPoint.y))
        path.addLine(to: endPoint)
        path.addLine(to: CGPoint(x: startPoint.x, y: endPoint.y))
        path.addLine(to: startPoint)
        
        if isNeedToFill == true {
            path.fill()
        }
       
        path.stroke()

        return path
    }
    
    
}

class Line: Drawable {
    func drawFigure(context: CGContext, startPoint: CGPoint, endPoint: CGPoint, isNeedToFill: Bool) -> UIBezierPath{
        let path = UIBezierPath()
        path.move(to: startPoint)
        path.addLine(to: endPoint)
        if isNeedToFill == true {
            path.fill()
        }
        path.stroke()
        context.strokePath()
        
        return path
    }
}

class Pen: Drawable {
    func drawFigure(context: CGContext, startPoint: CGPoint, endPoint: CGPoint, isNeedToFill: Bool) -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: startPoint)
        path.addLine(to: endPoint)
//        UIColor.yellow.setStroke()
        path.stroke()
        
        return path
    }
    
    
}

class Triangle: Drawable {
    func drawFigure(context: CGContext, startPoint: CGPoint, endPoint: CGPoint, isNeedToFill: Bool) -> UIBezierPath{
        
        let path = UIBezierPath()
        path.move(to: startPoint)
        path.addLine(to: endPoint)
        path.addLine(to: CGPoint(x: startPoint.x, y: endPoint.y))
        path.addLine(to: startPoint)
        
        if isNeedToFill == true {
            path.fill()
        }
        path.stroke()
        context.strokePath()
        
        return path
    }
    
    
}

class Canvas: UIView {
    var model = Model(shape: .circle, isNeedToFill: false, color: .black)
    var shape = Figures.triangle
    let circle = Circle()
    let rectangle = Rectangle()
    let triangle = Triangle()
    let line = Line()
    let pen = Pen()
    var shapes = [Drawable]()
    var startPoint = CGPoint()
    var endPoint = CGPoint()
    
    var penLine = [CGPoint]()
    var figures = [UIBezierPath]()
    var undoIsPressing = false
    var x = CGFloat()
    var y = CGFloat()
    
    var filledArray = [UIColor]()
    
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
       
        if model.isNeedToFill == true {
            print("FFIIILLLL")
            context.setFillColor(model.color.cgColor)
//            filledArray.append(model.color)
        } else {
//            filledArray.append(UIColor.systemFill)
        }
        filledArray.append(model.color)
        model.color.setStroke()

        guard let shape = model.shape else { print("deletedr");setNeedsDisplay(); return }
        if undoIsPressing == false {
            if shape == .triangle {
                figures.append(triangle.drawFigure(context: context , startPoint: startPoint, endPoint: endPoint, isNeedToFill: model.isNeedToFill))
                shapes.append(triangle)
                
            } else if shape == .circle {
                figures.append(circle.drawFigure(context: context , startPoint: startPoint, endPoint: endPoint, isNeedToFill: model.isNeedToFill))
            } else if shape == .rectangle {
                figures.append(rectangle.drawFigure(context: context, startPoint: startPoint, endPoint: endPoint, isNeedToFill: model.isNeedToFill))
            } else if shape == .line {
                figures.append(line.drawFigure(context: context, startPoint: startPoint, endPoint: endPoint, isNeedToFill: model.isNeedToFill))
            } else if shape == .pen {
                let path = UIBezierPath()
                for (i,p) in penLine.enumerated() {
                    if i == 0 {
                        path.move(to: p)
                    } else {
                        path.addLine(to: p)
                    }
                    path.stroke()
                }
                figures.append(path)
//                filledArray.append(model.color)
                
            }
        }
        
        var needToChange = false
//        for figure in figures {
//            if figures.firstIndex(of: figure) == figures.count - 1 {
//                needToChange = true
//            }
//            figure.stroke()
//        }
        if figures.count != 0{
            for i in 0...figures.count - 1 {
                if i == figures.count - 1 {
                    needToChange = true
                }
                print(filledArray[i])
                filledArray[i].setStroke()
//                figures[i].fill()
//                filledArray[i].setFill()
                figures[i].stroke()
            }
            if needToChange {
                undoIsPressing = false
            }
        }
        
        
        if figures.count == 0 {
            undoIsPressing = false
        }
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let firstTouch = touches.first else { return }
        
        startPoint.x = 0
        startPoint.y = 0

        
        endPoint.x = 0
        endPoint.y = 0
        
        startPoint.x = firstTouch.location(in: self).x
        startPoint.y = firstTouch.location(in: self).y
    }
    
   
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else{ return }

        print(penLine, "penLine")
        if model.shape == .pen {
            penLine.append(touch.location(in: self))
            setNeedsDisplay()
        }

       
        x = touch.location(in: self).x
        y = touch.location(in: self).y
        
        print(x)
        print(y)

    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        endPoint.x = x
        endPoint.y = y
        
        penLine.removeAll()
        setNeedsDisplay()
    }
    
    func drawLine() {
        
    }
    
}
