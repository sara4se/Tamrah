//
//  CameraViewController.swift
//  AItTestImageTWQ
//
//  Created by Sara Alhumidi on 19/11/1444 AH.
//

import Foundation
import AVFoundation
import SwiftUI
import UIKit


protocol CameraControllerDelegate: AnyObject {
    func didCaptureImage(_ image: UIImage)
}

class CameraController: UIViewController, AVCapturePhotoCaptureDelegate {
    weak var delegate: CameraControllerDelegate?

    private var captureSession: AVCaptureSession?
    private var stillImageOutput: AVCapturePhotoOutput?
    private var previewLayer: AVCaptureVideoPreviewLayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCaptureSession()
        setupPreviewLayer()
        setupCaptureButton()
    }

    private func setupCaptureSession() {
        captureSession = AVCaptureSession()

        guard let captureSession = captureSession else { return }

        guard let backCamera = AVCaptureDevice.default(for: .video) else {
            print("Unable to access back camera.")
            return
        }

        do {
            let input = try AVCaptureDeviceInput(device: backCamera)
            stillImageOutput = AVCapturePhotoOutput()

            if captureSession.canAddInput(input) && captureSession.canAddOutput(stillImageOutput!) {
                captureSession.addInput(input)
                captureSession.addOutput(stillImageOutput!)

                captureSession.startRunning()
            }
        } catch let error {
            print("Error setting up capture session: \(error.localizedDescription)")
        }
    }

    private func setupPreviewLayer() {
        guard let captureSession = captureSession else { return }

        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        if let previewLayer = previewLayer {
            previewLayer.videoGravity = .resizeAspectFill
            previewLayer.connection?.videoOrientation = .portrait
            view.layer.addSublayer(previewLayer)
            previewLayer.frame = view.frame
        }
    }

    private func setupCaptureButton() {
        let captureButton = UIButton(type: .system)
        captureButton.setTitle("Capture", for: .normal)
        captureButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        captureButton.addTarget(self, action: #selector(captureButtonPressed), for: .touchUpInside)
        captureButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(captureButton)

        NSLayoutConstraint.activate([
            captureButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            captureButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30)
        ])
    }

    @objc private func captureButtonPressed() {
        guard let photoOutput = stillImageOutput else { return }

        let photoSettings = AVCapturePhotoSettings()
        photoSettings.isHighResolutionPhotoEnabled = true
        photoOutput.capturePhoto(with: photoSettings, delegate: self)
    }

    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let imageData = photo.fileDataRepresentation(), let capturedImage = UIImage(data: imageData) {
            delegate?.didCaptureImage(capturedImage)
        }
    }
}

extension UIImage {
    func toPixelBuffer() -> CVPixelBuffer? {
        var pixelBuffer: CVPixelBuffer?
        let attrs = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue, kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue]
        let status = CVPixelBufferCreate(kCFAllocatorDefault, Int(size.width), Int(size.height), kCVPixelFormatType_32ARGB, attrs as CFDictionary, &pixelBuffer)

        guard status == kCVReturnSuccess, let unwrappedPixelBuffer = pixelBuffer else {
            return nil
        }

        CVPixelBufferLockBaseAddress(unwrappedPixelBuffer, CVPixelBufferLockFlags(rawValue: 0))
        let pixelData = CVPixelBufferGetBaseAddress(unwrappedPixelBuffer)

        guard let context = CGContext(data: pixelData, width: Int(size.width), height: Int(size.height), bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(unwrappedPixelBuffer), space: CGColorSpaceCreateDeviceRGB(), bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue) else {
            return nil
        }

        context.translateBy(x: 0, y: size.height)
        context.scaleBy(x: 1.0, y: -1.0)

        UIGraphicsPushContext(context)
        draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        UIGraphicsPopContext()

        CVPixelBufferUnlockBaseAddress(unwrappedPixelBuffer, CVPixelBufferLockFlags(rawValue: 0))
        return unwrappedPixelBuffer
    }
}
