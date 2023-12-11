//
//  File.swift
//  Tamrah
//
//  Created by Sara Alhumidi on 19/05/1445 AH.
//

import SwiftUI
class ViewModel : ObservableObject {
    @Published var image : UIImage?
    @Published var showImage = false
    @Published var source : Picker.Source = .lib
}
