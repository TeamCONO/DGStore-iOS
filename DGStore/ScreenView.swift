//
//  ScreenView.swift
//  DGStore
//
//  Created by Mercen on 2022/07/19.
//

import SwiftUI

struct ScreenView: View {
    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                Image(selectedIndex["image"]!)
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
                    Text(selectedIndex["title"]!)
                        .font(.system(size: 40, weight: .bold, design: .default))
                    Text(selectedIndex["developer"]!)
                        .font(.system(size: 15))
                    Spacer()
                }
                .frame(width: 400, height: 190)
                .padding(EdgeInsets(top: 15, leading: 0, bottom: 15, trailing: 0))
                .foregroundColor(.white)
            }
            VStack(alignment: .leading) {
                Text("")
                    .lineLimit(50)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
                Spacer()
            }
            .padding(20)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

