//
//  ScreenView.swift
//  DGStore
//
//  Created by Mercen on 2022/07/19.
//

import SwiftUI
import SVGView

struct ScreenView: View {
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            ZStack {
                Image(selectedIndex!.thumb)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .blur(radius: 3)
                    .frame(width: 400, height: 190)
                    .padding(EdgeInsets(top: 15, leading: 0, bottom: 15, trailing: 0))
                    .clipShape(Rectangle())
                Rectangle()
                    .fill(.black)
                    .frame(width: 400, height: 220)
                    .opacity(0.5)
                VStack {
                    Capsule()
                            .fill(.white)
                            .frame(width: 100, height: 3)
                    Spacer()
                    Text(selectedIndex!.title)
                        .font(.system(size: 40, weight: .bold, design: .default))
                    Text(selectedIndex!.developer)
                        .font(.system(size: 15))
                    Spacer()
                }
                .frame(width: 400, height: 190)
                .padding(EdgeInsets(top: 15, leading: 0, bottom: 15, trailing: 0))
                .foregroundColor(.white)
            }
            VStack(alignment: .leading) {
                Text(selectedIndex!.description)
                    .lineLimit(50)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
                Spacer()
            }
            .padding(20)
            HStack {
                Link(destination: URL(string: selectedIndex?.download.ios ?? "https://github.com/") ?? URL(string: "https://github.com/")!) {
                    Text(selectedIndex?.download.ios.isEmpty ?? true ? "미지원" : "다운로드")
                        .font(.system(size: 20, weight: .bold, design: .default))
                        .frame(maxWidth: .infinity)
                        .frame(height: 60)
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 24))
                }
                .disabled(selectedIndex?.download.ios.isEmpty ?? true)
                Spacer()
                    .isHidden(selectedIndex?.github.isEmpty ?? true, remove: true)
                Link(destination: URL(string: selectedIndex?.github ?? "https://github.com/") ?? URL(string: "https://github.com/")!) {
                    SVGView(contentsOf: URL(string: "https://simpleicons.org/icons/github.svg")!)
                        .frame(width: 30)
                        .colorInvert()
                        .font(.system(size: 20, weight: .bold, design: .default))
                        .frame(width: 60, height: 60)
                        .background(Color(.label))
                        .clipShape(RoundedRectangle(cornerRadius: 24))
                        .isHidden(selectedIndex?.github.isEmpty ?? true || colorScheme == .dark, remove: true)
                }
                Link(destination: URL(string: selectedIndex?.github ?? "https://github.com/") ?? URL(string: "https://github.com/")!) {
                    SVGView(contentsOf: URL(string: "https://simpleicons.org/icons/github.svg")!)
                        .frame(width: 30)
                        .font(.system(size: 20, weight: .bold, design: .default))
                        .frame(width: 60, height: 60)
                        .background(Color(.label))
                        .clipShape(RoundedRectangle(cornerRadius: 24))
                        .isHidden(selectedIndex?.github.isEmpty ?? true || colorScheme != .dark, remove: true)
                }
            }
            .padding(20)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

//struct ScreenView_Previews: PreviewProvider {
//    static var previews: some View {
//        ScreenView()
//    }
//}
