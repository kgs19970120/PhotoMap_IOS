//
//  MemberList.swift
//  PhotoMap_IOS
//
//  Created by 김근수 on 2020/01/12.
//  Copyright © 2020 김근수. All rights reserved.
//

import SwiftUI

struct MemberList: View {
    var body: some View {
        
        VStack {
            MenuTtileView()
                .frame(height: 50)
            AddingMemberView()
            List(0 ..< 5) { member in
                MemberRow()
            }
            MenuOptionView()
        }
        
    }
}
struct MenuTtileView: View {
    var body: some View {
        ZStack{
            Color(.gray)
            HStack {
                Text("그룹멤버")
                    .foregroundColor(.white)
                    .padding()
                Spacer()
            }
        }
    }
}
struct MenuOptionView: View {
    var body: some View {
        HStack {
            Image(systemName: "arrowshape.turn.up.right")
            Spacer()
            Image(systemName: "star")
        }
        .padding()
    }
}

struct AddingMemberView: View {
    var body: some View {
        HStack{
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                Image(systemName: "person.badge.plus.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.black)
            }
            Text(verbatim: "그룹멤버 초대")
                .font(.headline)
                .foregroundColor(.blue)
            Spacer()
        }
        .padding()
        
    }
}

struct MemberList_Previews: PreviewProvider {
    static var previews: some View {
        MemberList()
        //        MenuOptionView()
        //            .previewLayout(.fixed(width: 375, height: 70))
    }
}
