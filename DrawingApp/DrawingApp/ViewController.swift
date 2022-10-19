//
//  ViewController.swift
//  DrawingApp
//
//  Created by Damir Aliyev on 19.10.2022.
//

import UIKit

//class Circle {
//    
//    func drawFigure(context: CGContext) {
////        guard let context = UIGraphicsGetCurrentContext() else {return}
//                
//        context.setFillColor(CGColor.init(red: 255, green: 128, blue: 123, alpha: 1))
//        context.move(to: CGPoint(x: 100, y: 100))
//        context.addLine(to: CGPoint(x: 200, y: 200))
//        
//        context.strokePath()
//        
//    }
//}

//class Canvas: UIView {
//
//    let circle = Circle()
//
//    var line = [CGPoint]()
//    var lines = [[CGPoint]]()
//    var circles = [[UIBezierPath]()]
//    var firstTouchCoordinates = (x: CGFloat(),y: CGFloat())
//    var lastTouchCoordinates = (x: CGFloat(),y: CGFloat())
//    var touchEnded = false
//    var x = CGFloat()
//    var y = CGFloat()
//
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        backgroundColor = .white
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    override func draw(_ rect: CGRect) {
//        super.draw(rect)
//
//
//
//        guard let context = UIGraphicsGetCurrentContext() else { return }
////        print(lines)
////        for line in lines {
////            for point in line {
////
////                    if line.firstIndex(of: point) == 0 {
////                        context.move(to: point)
////                    } else {
////                        context.addLine(to: point)
////                    }
////
////
////            }
////
////        }
//
////        var textPoint = CGPoint(x: 100, y: 100)
////        var textAnotherPoint = CGPoint(x: 150, y: 150)
//
//
//        //MARK: How to draw circle
//
////        let radius = sqrt(pow(firstTouchCoordinates.x - lastTouchCoordinates.x, 2) + pow(firstTouchCoordinates.y - lastTouchCoordinates.y, 2)) / 2
////
////
////        context.addArc(center: CGPoint(x: (firstTouchCoordinates.x + lastTouchCoordinates.x) / 2, y:  (firstTouchCoordinates.y + lastTouchCoordinates.y) / 2), radius: radius, startAngle: 0, endAngle:6.28319, clockwise: true)
//
//        //MARK: How to draw rectangle
//
//        let startCoordinates = CGPoint(x: firstTouchCoordinates.x, y: firstTouchCoordinates.y)
//        let endCoordinates = CGPoint(x: lastTouchCoordinates.x, y: lastTouchCoordinates.y)
//
//        context.move(to: startCoordinates)
//        context.addLine(to: endCoordinates)
////        context.addLine(to: CGPoint(x: endCoordinates.x, y: startCoordinates.y))
////        context.addLines(between: [startCoordinates, endCoordinates])
////        context.move(to: CGPoint(x: endCoordinates.x, y: startCoordinates.y))
////        context.addLine(to: endCoordinates)
//        context.addLines(between: [endCoordinates, CGPoint(x: endCoordinates.x, y: startCoordinates.y)])
//        context.addLines(between: [startCoordinates, CGPoint(x: endCoordinates.x, y: startCoordinates.y)])
//
//
////
//
//        context.strokePath()
//        print(firstTouchCoordinates.x, "first x")
//        print(firstTouchCoordinates.y, "first y")
//        print(lastTouchCoordinates.x, "last x")
//        print(lastTouchCoordinates.y, "last x")
//        print("redrawn")
//
//        circle.drawFigure(context: context)
//
//    }
//

//}

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

