//
//  object.swift
//  AItTestImageTWQ
//
//  Created by Sara Alhumidi on 19/11/1444 AH.
//

import Foundation
import Vision
import UIKit

class ObjectDetector: ObservableObject {
  struct PredictionInObject: Identifiable {
    let id = UUID()
    let label: String
    let confidence: Float
    let boundingBox: CGRect
  }
  
  private var model: Optional<VNCoreMLModel> = .none
  @Published var predictions: Array<PredictionInObject> = .init()
  
//  init() {
//    
//    guard let pureModel = try? SignLangModel01(configuration: MLModelConfiguration()) else {
//      return
//    }
//    guard let coreMLModel = try? VNCoreMLModel(for: pureModel.model) else {
//      return
//    }
//    
//    model = coreMLModel
//  }
  
    func predict(sampleBuffer: CVImageBuffer) {
        predictions = []
        
        guard let model = model else {
          return
        }
        
        let request = VNCoreMLRequest(model: model) { [self] request, error in
          if let error = error {
            return
          }
          
          guard let observations = request.results as? [VNRecognizedObjectObservation] else {
            return
          }
          
          for observation in observations {
            guard let label = observation.labels.first else { continue }
            let predication = PredictionInObject(
              label: label.identifier,
              confidence: label.confidence * 100,
              boundingBox: observation.boundingBox
            )
            predictions.append(predication)
          }
        }

        let requestHandler = VNImageRequestHandler(cvPixelBuffer: sampleBuffer)
        
        try? requestHandler.perform([request])
    }
}
