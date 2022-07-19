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
            ZStack {
                Image("Geunho")
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
                    Text("Rolling Root")
                        .font(.system(size: 40, weight: .bold, design: .default))
                    Text("406SOFT")
                        .font(.system(size: 15))
                }
                .padding(EdgeInsets(top: 15, leading: 0, bottom: 15, trailing: 0))
                .foregroundColor(.white)
            }
            VStack(alignment: .leading) {
                Text("롤링 루트는 406SOFT에서 제작한 게임입니다.\n\n아이스크림을 피해 알맞은 타이밍에 점프만 하면 되는 단순한 게임이죠.\n\n하지만 얕보지 마세요. 당신은 무조건 짜증을 한번이라도 낼 것이니까요.")
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

struct ScreenView_Previews: PreviewProvider {
    static var previews: some View {
        ScreenView(swTitle: "Rolling Root")
    }
}
