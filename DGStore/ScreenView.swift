//
//  ScreenView.swift
//  DGStore
//
//  Created by Mercen on 2022/07/19.
//

import SwiftUI

struct ScreenView: View {
    @State var swTitle: String
    var body: some View {
        VStack(alignment: .leading) {
            Image("Geunho")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 190)
                .frame(maxWidth: .infinity)
                .padding(EdgeInsets(top: 15, leading: 0, bottom: 15, trailing: 0))
            Text(swTitle)
                .font(.system(size: 40, weight: .bold, design: .default))
                .padding(20)
            Spacer()
        }
    }
}

struct ScreenView_Previews: PreviewProvider {
    static var previews: some View {
        ScreenView(swTitle: "Rolling Root")
    }
}
