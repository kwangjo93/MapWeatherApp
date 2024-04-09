//
//  SearchBar.swift
//  MapWeatherApp
//
//  Created by 천광조 on 4/8/24.
//

import SwiftUI
import MapKit

struct SearchBar: View {
    @State var searchText: String = ""
    @State private var searchResults: [String] = []
    @Binding var isSearching: Bool
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Button {
                    isSearching = false
                } label: {
                    Image(systemName: "arrowshape.backward.fill")
                        .font(.system(size: 30))
                        .fontWeight(.semibold)
                        .foregroundStyle(.black)
                }
                
                TextField("Search",
                          text: $searchText,
                          onCommit: {
                    search()
                })
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal, 10)
                .onTapGesture {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
                
                Image(systemName: "magnifyingglass")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(width: 30, height: 30)
                    .background(Color.black.gradient, in: .circle)
                    .contentShape(.circle)
                    .padding(.horizontal, 10)
                    .onTapGesture {
                        search()
                    }
            }
            .padding(.horizontal, 10)
            .padding(.top, 10)
            
            List(searchResults, id: \.self) { city in
                if !searchText.isEmpty {
                    Text(city)
                }
            }
        }
        
    }
    func search() {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = searchText
        let search = MKLocalSearch(request: searchRequest)
        search.start { response, error in
            guard let response = response else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            DispatchQueue.main.async {
                self.searchResults = response.mapItems.map { $0.name ?? "" }
            }
        }
    }

}

#Preview {
    SearchBar( isSearching: .constant(false))
}
