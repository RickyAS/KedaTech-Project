//
//  HomeViewModel.swift
//  KedaTech Project
//
//  Created by Ricky Austin on 20/06/23.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var items = [HomeModel]()
    @Published var baseItems = [HomeModel]()
    @Published var searchText = ""
    @Published var isFavourite = false
    
    func getItems() {
        if let data = UserDefaults.standard.data(forKey: "SavedData"),
           let model = try? JSONDecoder().decode([HomeModel].self, from: data),
           !model.isEmpty {
            items = model
        } else {
            items = generateModel()
        }
        baseItems = items
    }
    
    func saveItems(item: HomeModel) {
        if let index = baseItems.firstIndex(where: {$0.id == item.id}) {
            baseItems[index].isFavourite = item.isFavourite
        }
        if let data = try? JSONEncoder().encode(baseItems) {
            UserDefaults.standard.set(data, forKey: "SavedData")
        }
    }
    
    func filterSearch() {
        isFavourite = false
        items = baseItems
        if !searchText.isEmpty {
            items = items.filter({ $0.name.range(of: searchText.lowercased(), options: .caseInsensitive) != nil})
        }
    }
    
    func filterFavourite() {
        items = baseItems
        if isFavourite {
            items = items.filter({ $0.isFavourite })
        }
    }
    
    func generateModel() -> [HomeModel] {
        let model = [HomeModel(id: 1, name: "Devices", icon: "📱"),
                     HomeModel(id: 2, name: "Personal Computers", icon: "🖥️"),
                     HomeModel(id: 3, name: "Stationeries", icon: "📏"),
                     HomeModel(id: 4, name: "Chairs", icon: "🪑"),
                     HomeModel(id: 5, name: "Light Bulps", icon: "💡"),
                     HomeModel(id: 6, name: "Sound Systems", icon: "🔈"),
                     HomeModel(id: 7, name: "Toolboxes", icon: "🧰"),
                     HomeModel(id: 8, name: "Kitchen Utils", icon: "🍽️"),
                     HomeModel(id: 9, name: "Work Boots", icon: "🥾"),
                     HomeModel(id: 10, name: "Office Cars", icon: "🚗")
        ]
        return model
    }
}
