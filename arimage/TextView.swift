//
//  TextView.swift
//  arimage
//
//  Created by sesang on 10/11/23.
//

import SwiftUI

struct TextView: View {
    var body: some View {
        VStack {

            Text("하울의 움직이는 성")
                .bold()
                .padding()
                .font(.largeTitle)
                .foregroundStyle(.black)
                .multilineTextAlignment(.leading)
            Text("2004 전체관람가 1시간 59분")
                .padding()
                .font(
                    .footnote
                )
                .foregroundStyle(.black)
                .multilineTextAlignment(.leading)

            Text("아버지가 물려준 모자 가게를 지키는 수수한 소녀 소피. 전쟁도, 미녀의 심장을 노리는 마법사의 소문도 먼 세상 이야기일 뿐. 하지만 마녀의 저주로 할머니가 되면서, 소피의 인생이 회전목마처럼 힘차게 움직이기 시작한다.")
                .font(.body)
                .padding()
                .foregroundStyle(.black)
                .multilineTextAlignment(.leading)
           
        }

    }
}

#Preview {
    TextView()
}
