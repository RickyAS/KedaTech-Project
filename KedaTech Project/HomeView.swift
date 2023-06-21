//
//  HomeView.swift
//  KedaTech Project
//
//  Created by Ricky Austin on 20/06/23.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationView {
            List($viewModel.items, id: \.id){ item in
                HomeCell(viewModel: viewModel, item: item)
            }.listStyle(.plain)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    heartButton
                }
            }
            .navigationTitle("The A Catalog")
            .onAppear {
                viewModel.getItems()
            }
            .onChange(of: viewModel.searchText) { _ in
                withAnimation { viewModel.filterSearch() }
            }
            .onChange(of: viewModel.isFavourite) { _ in
                withAnimation { viewModel.filterFavourite() }
            }
        }.searchable(text: $viewModel.searchText)
    }
    
    var heartButton: some View {
        Button(action: {viewModel.isFavourite.toggle()}) {
            Text("Fav")
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(viewModel.isFavourite ? .white : .red)
                .padding(EdgeInsets(top: 3, leading: 12, bottom: 3, trailing: 12))
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(viewModel.isFavourite ? .red : .white)
                        .overlay( RoundedRectangle(cornerRadius: 8)
                            .stroke(.red, lineWidth: 2)))
        }
    }
}

struct HomeCell: View {
    var viewModel: HomeViewModel
    @Binding var item: HomeModel
    
    var body: some View {
        HStack{
            Text(item.icon).font(.system(size: 32)).padding(.trailing)
            Text(item.name)
            Spacer()
            Button(action: {
                item.isFavourite.toggle()
                viewModel.saveItems(item: item)}) {
                Image(systemName: item.isFavourite ? "heart.fill" : "heart")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20)
                    .foregroundColor(.red)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = HomeViewModel()
        vm.items = vm.generateModel()
        vm.baseItems = vm.items
        var view = HomeView()
        view.viewModel = vm
        return view
    }
}

