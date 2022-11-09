//
//  SearchBar.swift
//  maevo
//
//  Created by Aaron Xavier on 10/25/22.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    @Binding var isEditing: Bool
    @Binding var predictions: Array<Prediction>
    
    init(text: Binding<String>, isEditing: Binding<Bool>, predictions: Binding<Array<Prediction>>) {
        self._text = text
        self._isEditing = isEditing
        self._predictions = predictions
    }
    
    var body: some View {
        HStack {
            TextField("Search City", text: $text)
                .padding(7.5)
                .padding(.horizontal, 20)
                .background(Color(.systemGray6))
                .cornerRadius(7.5)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.trailing, 7.5)
                        
                        if isEditing && text.count != 0 {
                            Button(action: {
                                self.text = ""
                                self.predictions = Array<Prediction>()
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 7.5)
                            }
                        }
                    }
                )
                .padding(.horizontal, 10)
                .onTapGesture {
                    withAnimation {
                        self.isEditing = true
                    }
                }
            
            if isEditing {
                Button(action: {
                    withAnimation {
                        self.isEditing = false
                        self.text = ""
                        self.predictions = Array<Prediction>()
                    }
                    // Dismiss the keyboard
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }) {
                    Text("Cancel")
                }
                .padding(.trailing, 10)
                .animation(.linear, value: 0.25)
            }
        }
    }
}
