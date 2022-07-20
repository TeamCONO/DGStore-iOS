//
//  ContentView.swift
//  DGStore
//
//  Created by Mercen on 2022/07/18.
//

import SwiftUI
import Alamofire
import SVGView

extension UIImage {

    public var base64: String {
        return self.jpegData(compressionQuality: 1.0)!.base64EncodedString()
    }

    convenience init?(base64: String, withPrefix: Bool) {
        var finalData: Data?

        if withPrefix {
            guard let url = URL(string: base64) else { return nil }
            finalData = try? Data(contentsOf: url)
        } else {
            finalData = Data(base64Encoded: base64)
        }

        guard let data = finalData else { return nil }
        self.init(data: data)
    }

}

extension View {
    @ViewBuilder func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
        if hidden {
            if !remove { self.hidden() }
        } else { self }
    }
}

public var selectedIndex: dataArray?
struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var showModal = false
    @State private var searchText = ""
    @State var itemList = [dataArray]()
    let decoder: JSONDecoder = JSONDecoder()
    var viewList: [dataArray] {
        if searchText.isEmpty { return itemList }
        else {
            return itemList.filter {
                $0.title.contains(searchText) ||
                $0.developer.contains(searchText)
            }
        }
    }
    var body: some View {
        NavigationView {
            List {
                ForEach(0..<viewList.count, id: \.self) { i in
                    Button(action: {
                        selectedIndex = itemList[i]
                        showModal = true
                    }) {
                        VStack(spacing: 0) {
                            Image(uiImage: UIImage(base64: viewList[i].thumb, withPrefix: true)!)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(height: 190)
                                .clipped()
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(viewList[i].title)
                                        .font(.system(size: 20, weight: .bold, design: .default))
                                    Text(viewList[i].developer)
                                        .font(.system(size: 10))
                                }
                                Spacer()
                                SVGView(contentsOf: URL(string: "https://simpleicons.org/icons/\(viewList[i].framework).svg")!)
                                    .frame(width: 30)
                                    .isHidden(colorScheme == .dark, remove: true)
                                SVGView(contentsOf: URL(string: "https://simpleicons.org/icons/\(viewList[i].framework).svg")!)
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
                        ScreenView()
                    }
                }
            }
            .searchable(text: $searchText, prompt: "검색")
            .navigationBarTitle("스토어")
            .refreshable {
                try? AF.request("http://192.168.0.21:5877/items/", method: .get, encoding: URLEncoding.default).responseData {
                    guard let value = $0.value else { return }
                    guard let result = try? decoder.decode(serverData.self, from: value) else { return }
                    self.itemList = result.list
                }
            }
            .listStyle(PlainListStyle())
            .onAppear {
                UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).title = "취소"
                try? AF.request("http://192.168.0.21:5877/items/", method: .get, encoding: URLEncoding.default).responseData {
                    guard let value = $0.value else { return }
                    guard let result = try? decoder.decode(serverData.self, from: value) else { return }
                    self.itemList = result.list
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
