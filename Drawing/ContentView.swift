//
//  ContentView.swift
//  Drawing
//
//  Created by Ryan on 20/3/23.
//

import SwiftUI

struct Arc : InsettableShape {
    let startAngle : Angle
    let endAngle : Angle
    let clockWise : Bool
    var insetAmount = 0.0
    
    func path(in rect: CGRect) -> Path {
        
        let angleRotation = Angle.degrees(90)
        let modifiedStart = startAngle - angleRotation
        let modifiedEnd = endAngle - angleRotation
        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2 -  insetAmount , startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: !clockWise)
        return path
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmount += amount
        return arc
    }
}

struct Flower : Shape {
    var patelOffset = -20.0
    var patelWidth = 100.0
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        for number in stride(from: 0, to: Double.pi * 2, by: Double.pi / 8) {
            let rotation = CGAffineTransform(rotationAngle: number)
            let position = rotation.concatenating(CGAffineTransform(translationX: rect.width/2, y: rect.height/2))
            
            let originalPatel = Path(ellipseIn: CGRect(x: patelOffset, y: 0, width: patelWidth, height: rect.width/2))
            let rotatedPatel = originalPatel.applying(position)
            
            path.addPath(rotatedPatel)
        }
        return path
    }
}

struct ContentView: View {
    
    @State private var patelOffset = -20.0
    @State private var patelWidth = 100.0
    
    var body: some View {
        VStack {
            Flower(patelOffset: patelOffset, patelWidth: patelWidth)
                .fill(.red, style: FillStyle(eoFill: true))
            
            Text("Offset")
            Slider(value: $patelOffset , in: -40...40)
                .padding([.horizontal,.vertical])
            
            Text("Width")
            Slider(value: $patelWidth , in: 0...200)
                .padding([.horizontal,.vertical])
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
