//
//  CameraView.swift
//  AItTestImageTWQ
//
//  Created by Sara Alhumidi on 19/11/1444 AH.
//

import Foundation
import AVFoundation
import SwiftUI
import UIKit
import SwiftUI

struct CameraViewControllerWrapper: UIViewControllerRepresentable {
    @Binding var isCameraPresented: Bool
    @Binding var isCaptureButtonHidden: Bool
    @Binding var capturedImage: UIImage?

    func makeUIViewController(context: Context) -> CameraViewController {
        let viewController = CameraViewController()
        viewController.delegate = context.coordinator
        return viewController
    }

    func updateUIViewController(_ uiViewController: CameraViewController, context: Context) {
        // Update any properties of the view controller here
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    class Coordinator: NSObject, CameraControllerDelegate {
        var parent: CameraViewControllerWrapper

        init(_ parent: CameraViewControllerWrapper) {
            self.parent = parent
        }

        func didCaptureImage(_ image: UIImage) {
            parent.capturedImage = image
        }
    }
}


class CameraViewController: UIViewController, CameraControllerDelegate {
    private let cameraController = CameraController()
    weak var delegate: CameraControllerDelegate?

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        cameraController.delegate = self
        addChild(cameraController)
        view.addSubview(cameraController.view)
        cameraController.didMove(toParent: self)

        setupImageView()
    }

    private func setupImageView() {
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    func didCaptureImage(_ image: UIImage) {
        imageView.image = image
    }
}
