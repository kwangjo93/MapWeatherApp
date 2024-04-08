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
    
    var body: some View {
        HStack {
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
        
        List(searchResults, id: \.self) { city in
            if !searchText.isEmpty {
                Text(city)
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
    SearchBar()
}
