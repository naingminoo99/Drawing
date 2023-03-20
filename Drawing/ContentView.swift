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
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2 , startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: !clockWise)
        return path
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmount += amount
        return arc
    }
}

struct ContentView: View {
    var body: some View {
        Arc(startAngle: .degrees(-90), endAngle: .degrees(90), clockWise: false)
            .frame(width:300,height: 300)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
