//
//  ContentView.swift
//  DGStore
//
//  Created by Mercen on 2022/07/18.
//

import SwiftUI
import SVGView

extension View {
    @ViewBuilder func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
        if hidden {
            if !remove { self.hidden() }
        } else { self }
    }
}

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var showModal = false
    @State var itemList = [[String: String]]()
    @State private var searchText = ""
    var body: some View {
        NavigationView {
            List {
                ForEach(viewList, id: \.self) { value in
                    Button(action: { showModal = true }) {
                        VStack(spacing: 0) {
                            Image(value["image"]!)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(height: 190)
                                .clipped()
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(value["title"]!)
                                        .font(.system(size: 20, weight: .bold, design: .default))
                                    Text(value["developer"]!)
                                        .font(.system(size: 10))
                                }
                                Spacer()
                                SVGView(contentsOf: URL(string: "https://simpleicons.org/icons/\(value["framework"]!).svg")!)
                                    .frame(width: 30)
                                    .isHidden(colorScheme == .dark, remove: true)
                                SVGView(contentsOf: URL(string: "https://simpleicons.org/icons/\(value["framework"]!).svg")!)
                                    .frame(width: 30)
                                    .colorInvert()
                                    .isHidden(colorScheme != .dark, remove: true)
                            }
                            .foregroundColor(Color(.label))
                            .padding(EdgeInsets(top: 15, leading: 20, bottom: 17, trailing: 20))
                        }
                    }
                    .background(Color(.secondarySystemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                    .padding(EdgeInsets(top: 10, leading: 20, bottom: 15, trailing: 20))
                    .shadow(color: Color.black.opacity(0.2), radius: 15, x: 0, y: 10)
                    .listRowInsets(.init())
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                    .sheet(isPresented: self.$showModal) {
                        ScreenView(swTitle: "도담도담")
                    }
                }
            }
            .searchable(text: $searchText, prompt: "검색")
            .navigationBarTitle("스토어")
            .refreshable { print("refreshed") }
            .listStyle(PlainListStyle())
                .onAppear {
                    UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).title = "취소"
                    itemList.append([
                        "title": "Rolling Root",
                        "developer": "406SOFT",
                        "image": "Geunho",
                        "framework": "unity",
                    ])
                    itemList.append([
                        "title": "도담도담",
                        "developer": "B1ND",
                        "image": "Dodam",
                        "framework": "javascript",
                    ])
                    itemList.append([
                        "title": "이경태",
                        "developer": "None",
                        "image": "KT",
                        "framework": "android",
                    ])
            }
        }
    }
    
    var viewList: [[String: String]] {
        if searchText.isEmpty { return itemList }
        else {
            return itemList.filter {
                $0["title"]!.contains(searchText) ||
                $0["developer"]!.contains(searchText)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
