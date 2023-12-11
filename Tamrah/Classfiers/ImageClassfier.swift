//
//  ImageClassfier.swift
//  AItTestImageTWQ
//
//  Created by Sara Alhumidi on 09/11/1444 AH.
//

import Foundation
import Vision
import UIKit

struct Prediaction : Identifiable{
    let id = UUID()
    var label : String
    var confidece : Float
}
class ImageClassfier: ObservableObject {
    private var model: VNCoreMLModel?
    @Published var arrayOfPredictions: [Prediaction] = []

    init() {
        do {
            let datesClassifierModel = try imageDates(configuration: MLModelConfiguration())
            let coreMlModel = try VNCoreMLModel(for: datesClassifierModel.model)
            self.model = coreMlModel

            // Print model description
            print("Model Description:")
            print(coreMlModel)
            if let outputName = datesClassifierModel.model.modelDescription.outputDescriptionsByName.keys.first {
                            print("Model Output Name: \(outputName)")
                        }
            if let input = datesClassifierModel.model.modelDescription.inputDescriptionsByName.keys.first {
                            print("Model input Name: \(input)")
                        }
            
        } catch {
            print("Failed to load the Core ML model: \(error.localizedDescription)")
        }
    }

    func predict(image: UIImage) {
        arrayOfPredictions = []
        guard let image = image.cgImage else {
            return
        }
        guard let model = model else {
            print("No model available.")
            return
        }

        let request = VNCoreMLRequest(model: model) { requests, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }

            guard let observations = requests.results as? [VNClassificationObservation] else {
                print("No VNClassificationObservation in results.")
                return
            }

            print("Observations: \(observations)")
            for observation in observations {
                let prediction = Prediaction(
                    label: observation.description,
                    confidece: observation.confidence * 100
                )
                self.arrayOfPredictions.append(prediction)
            }
        }
        request.usesCPUOnly = true
        let requestHandler = VNImageRequestHandler(cgImage: image)
        try? requestHandler.perform([request])
    }
}
