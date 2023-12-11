//
//  ContentView.swift
//  AItTestImageTWQ
//
//  Created by Sara Alhumidi on 09/11/1444 AH.
//

import SwiftUI
extension Color {
    init(hex: String) {
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        if hexString.hasPrefix("#") {
            hexString.remove(at: hexString.startIndex)
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&rgbValue)
        
        let red = Double((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = Double((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgbValue & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue)
    }
}


struct ContentView: View {
    @State private var isAnimating = false
    @State private var showPicker: Bool = false
    @State private var showCamera: Bool = false
    @State private var selectedImage: UIImage?
    @StateObject private var imageClassifier: ImageClassfier = ImageClassfier()
    @State private var isCameraPresented: Bool = false
    @EnvironmentObject var vm: ViewModel
    @State private var gradientColors: [Color] = [.init(hex: "ab99fd"), .init(hex: "e59fff"), .init(hex: "87f1fb")]
    @State private var isImagePickerPresented = false
    @State private var selectedDates = ["Galaxy","Galaxy","Sokery", "Sokery"]
    @State private var conf = ["91%","90%","97%", "93%","95%"]


    var body: some View {
        NavigationView {
            ZStack {
                selectedImage == nil ?  Color.gray : Color.white
                VStack(spacing: 0) {
                    if let selectedImage = selectedImage {
                        Image(uiImage: selectedImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 500, height: 200)
                            .edgesIgnoringSafeArea(.top)
                        
//                        VStack {
//                            Text("this is a \(randomDate()) dates")
//                            Text("\(randomconf()) confidece")
//                      
//                        }
                        GeometryReader { geometry in
                            ScrollView {
                                LazyVStack(spacing: 10) {
                                    if let highestConfidencePrediction = imageClassifier.arrayOfPredictions.max(by: { $0.confidece < $1.confidece }) {
                                        HStack {
//                                            Text("Label: \(highestConfidencePrediction.label.description)")
                                            Text("Confidence: \(String(format: "%.2f", highestConfidencePrediction.confidece))%")
                                        }
                                        .frame(width: geometry.size.width)
                                        .padding(.horizontal, 10)
                                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.1)))
                                    }

//                                    ForEach(
//                                        imageClassifier.arrayOfPredictions) { prediction in
////                                            HStack {
////                                                Text("this is a Galaxy dates")
////                                                Text("91% confidece")
////                                          
////                                            }
//                                            Text(prediction.label.description)
//                                            Text(prediction.confidece.description)
////                                        }
//                                        .frame(width: geometry.size.width)
//                                        .padding(.horizontal, 10)
//                                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.1)))
//
//                                    }
                                }
                                .padding(10)
                                .listStyle(.plain)
                                .background(Color.white)
                            }
                        }
                    } else {
                        VStack {
                            Button(action: {
                                //                                vm.source = .lib
                                //                                vm.showImage = true
                                isImagePickerPresented.toggle()
                                
                            }) {
                                Image(systemName: "photo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 200, height: 200)
                                    .shadow(radius: 5)
                                
                            }
                            Text("+ Click here to add a photo")
                        }
                        .foregroundColor(.white)
                        .padding(.top, 40)
                        //
                        //                        Button(action: {
                        //                            vm.source = .camera
                        //                            vm.showImage = true
                        //                            isCameraPresented.toggle()
                        //                        }) {
                        //                            Image(systemName: "camera.viewfinder")
                        //                                .resizable()
                        //                                .foregroundColor(.white)
                        //                                .scaledToFit()
                        //                                .frame(width: 200, height: 200)
                        //                                .shadow(radius: 5)
                        //                        }
                        //                        Text("+ Or Click to open camera")
                        //                        .padding(.top, 40)
                    }
                }
                .ignoresSafeArea(.all)
                .sheet(isPresented: $vm.showImage) {
                    ImagePickerView(sourceType: vm.source == .lib ? .photoLibrary : .camera) { image in
                        selectedImage = image
                        let resizedImage = selectedImage?
                            .resize(to: CGSize(width: 300, height: 300))

                        imageClassifier.predict(image: resizedImage!)
                    }
                }.navigationBarTitle("Tamrah", displayMode: .inline)
                    .navigationBarItems(
                        trailing:
                            Button(action: {
                                // Show the menu to choose photo source
                                isImagePickerPresented.toggle()
                            }) {
                                Image(systemName: "plus")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                //                                .padding()
                                    .foregroundColor(.black)
                            })
                    .actionSheet(isPresented: $isImagePickerPresented) {
                        ActionSheet(
                            title: Text("Choose a Source"),
                            buttons: [
                                .default(Text("Photo Library")) {
                                    vm.source = .lib
                                    vm.showImage.toggle()
                                },
                                .default(Text("Camera")) {
                                    vm.source = .camera
                                    vm.showImage.toggle()
                                },
                                .cancel()
                            ]
                        )
                    }
            }
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
    
    func neonGradient() -> LinearGradient {
        let colors = [
            Color(hex: "#AB99FD"),
            Color(hex: "#87F1FB"),
            Color(hex: "#DBE2EB")
        ]
        return LinearGradient(gradient: Gradient(colors: colors), startPoint: .leading, endPoint: .trailing)
    }
    
    func updateGradientColors() {
        gradientColors.shuffle()
    }
    func randomDate() -> String {
        guard let randomDate = selectedDates.randomElement() else {
            return "Unknown"
        }
        return randomDate
    }
    func randomconf() -> String {
        guard let randomDate = conf.randomElement() else {
            return "Unknown"
        }
        return randomDate
    }
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
extension UIImage {
    func resize(to newSize: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
