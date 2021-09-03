//
//  ContentView.swift
//  LearnSwift
//
//  Created by arche1 on 2021/09/03.
//

import SwiftUI

struct ContentView: View {
    @State var i: Int = 0
    var body: some View {
        HStack{
            ZStack{
                Circle()
                    .fill(Color.green)
                Button(action: {
                    i += 1
                }, label: {
                    Text("Increment")
                })
            }
            .frame(width: 100, height: 100)
            VStack(alignment:.leading, spacing:4){
                Text("Count \(i)")
                    .font(.largeTitle)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.gray)
                Text("Dmitry, 2021")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
//            .previewDevice("Iphone SE")
//            .previewDisplayName("Iphone SE")
    }
}

//extension View {
//    func print(_ value: Any) -> Self {
//        Swift.print(value)
//        return self
//    }
//}
