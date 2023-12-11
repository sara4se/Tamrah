//
//  ImagePicker.swift
//  AItTestImageTWQ
//
//  Created by Sara Alhumidi on 09/11/1444 AH.
//

import Foundation
import SwiftUI
import UIKit
import PhotosUI
struct ImagePickerView: UIViewControllerRepresentable {
    
    private var sourceType: UIImagePickerController.SourceType
    private let onImagePicked: (UIImage) -> Void  // Change here
    
    @Environment(\.presentationMode) private var presentationMode
    
    public init(sourceType: UIImagePickerController.SourceType, onImagePicked: @escaping (UIImage) -> Void) {
        self.sourceType = sourceType
        self.onImagePicked = onImagePicked
    }
    
    public func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = self.sourceType
        picker.delegate = context.coordinator
        return picker
    }
    
    public func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(
            onDismiss: { self.presentationMode.wrappedValue.dismiss() },
            onImagePicked: self.onImagePicked
        )
    }
    
    final public class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        
        private let onDismiss: () -> Void
        private let onImagePicked: (UIImage) -> Void
        
        init(onDismiss: @escaping () -> Void, onImagePicked: @escaping (UIImage) -> Void) {
            self.onDismiss = onDismiss
            self.onImagePicked = onImagePicked
        }
        
        public func imagePickerController(_ picker: UIImagePickerController,
                                          didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let image = info[.originalImage] as? UIImage {
                self.onImagePicked(image)
            }
            self.onDismiss()
        }
        public func imagePickerControllerDidCancel(_: UIImagePickerController) {
            self.onDismiss()
        }
    }
}


struct imagePicker: UIViewControllerRepresentable {
     
    @Binding var selectedImage : UIImage?
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        
    }
    func makeUIViewController(context: Context) -> PHPickerViewController  {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 1
        configuration.filter = .images
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = context.coordinator
        return picker
    }
    
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    class Coordinator : PHPickerViewControllerDelegate{
        let parent : imagePicker
        init(_ parent: imagePicker) {
            self.parent = parent
        }
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            guard let item = results.first?.itemProvider else{
                return
            }
            guard item.canLoadObject(ofClass: UIImage.self) else{
                return
            }
            item.loadObject(ofClass: UIImage.self , completionHandler: { originalImage, error in
                if let error = error {
                    print(error.localizedDescription)
                }
           
            guard let uiImage = originalImage as? UIImage else {
                return
            }
            self.parent.selectedImage = uiImage
            })
            picker.dismiss(animated: true)
           
        }
        
    }
}
