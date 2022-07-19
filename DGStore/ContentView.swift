//
//  ContentView.swift
//  DGStore
//
//  Created by Mercen on 2022/07/18.
//

import SwiftUI

extension UIImage {
    var averageColor: UIColor? {
        guard let inputImage = CIImage(image: self) else { return nil }
        let extentVector = CIVector(x: inputImage.extent.origin.x, y: inputImage.extent.origin.y, z: inputImage.extent.size.width, w: inputImage.extent.size.height)

        guard let filter = CIFilter(name: "CIAreaAverage", parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: extentVector]) else { return nil }
        guard let outputImage = filter.outputImage else { return nil }

        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext(options: [.workingColorSpace: kCFNull!])
        context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: .RGBA8, colorSpace: nil)

        return UIColor(red: CGFloat(bitmap[0]) / 255, green: CGFloat(bitmap[1]) / 255, blue: CGFloat(bitmap[2]) / 255, alpha: CGFloat(bitmap[3]) / 255)
    }
}

extension UIColor {
    var isDarkColor: Bool {
        var r, g, b, a: CGFloat
        (r, g, b, a) = (0, 0, 0, 0)
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        let lum = 0.2126 * r + 0.7152 * g + 0.0722 * b
        return lum < 0.50
    }
}

struct ContentView: View {
    @State var itemList = [[String: String]]()
    @State private var searchText = ""
    var body: some View {
        NavigationView {
            List {
                /*
                Button(action: { print("안뇽") }) {
                    HStack {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 70, height: 70)
                            .padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 10))
                        Text("로그인하세요")
                            .font(.system(size: 20, weight: .bold, design: .default))
                        Spacer()
                    }
                }
                .foregroundColor(.white)
                .frame(height: 100)
                .frame(maxWidth: .infinity)
                .background(Color(.secondaryLabel))
                .clipShape(RoundedRectangle(cornerRadius: 24))
                 */
                ForEach(itemList, id: \.self) { value in
                    VStack(spacing: 0) {
                        Image(value["image"]!)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 190)
                            .clipped()
                        HStack {
                            Text(value["title"]!)
                            Spacer()
                            Text(value["platform"]!)
                        }
                        .foregroundColor(UIImage(named: value["image"]!)!.averageColor!.isDarkColor ? .white : .black)
                        .padding(20)
                    }
                    .background(Color(UIImage(named: value["image"]!)!.averageColor!))
                    .frame(height: 250)
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                    .padding(EdgeInsets(top: 10, leading: 20, bottom: 15, trailing: 20))
                    //.shadow(radius: 12)
                    .listRowInsets(.init())
                    .listRowSeparator(.hidden)
                }
            }
            .searchable(text: $searchText)
            .navigationBarTitle("스토어")
            .navigationBarItems(trailing:
                Button(action: {
                    print("User icon pressed...")
                }) {
                    Image(systemName: "plus")
                }
            )
            .refreshable { print("refreshed") }
            .listStyle(PlainListStyle())
                .onAppear {
                    itemList.append([
                        "title": "Rolling Root",
                        "image": "Geunho",
                        "platform": "iOS",
                    ])
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
