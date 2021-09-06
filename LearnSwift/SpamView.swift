//
//  SpamView.swift
//  LearnSwift
//
//  Created by arche1 on 2021/09/06.
//

import SwiftUI
import Foundation
import CoreML
import NaturalLanguage

class SpamIdentifier:ObservableObject{
    @Published var prediction: String = ""
    @Published var confidence: Double = 0.0
    
    var model = MLModel()
    var spamPredictor = NLModel()

    init() {
        do{
            self.spamPredictor = try NLModel(mlModel: SpamClassifier(configuration: MLModelConfiguration()).model)
        } catch{
            print(error)
        }
    }
       
    func predict(_ text:String){
        self.prediction = spamPredictor.predictedLabel(for: text) ?? ""
        let predictionSet = spamPredictor.predictedLabelHypotheses(for: text, maximumCount: 1)
        self.confidence = predictionSet[prediction] ?? 0.0
    }
}

struct SpamView: View {
    @ObservedObject var identifier = SpamIdentifier()
    @State private var input = "Enter message"
    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/){
            Spacer()
            Text(self.identifier.prediction == "spam" ? "SPAM":"NOT SPAM")
                .font(.system(size: 60))
            
            Text("Confidence:\(self.identifier.confidence)")
            
            TextEditor(text: $input)
                .font(.title)
                .onChange(of: input) { _ in
                    if input.last == " " {
                        self.identifier.predict(input)
                }
            }
            Spacer()
        }
    }
}

struct SpamView_Previews: PreviewProvider {
    static var previews: some View {
        SpamView()
    }
}
