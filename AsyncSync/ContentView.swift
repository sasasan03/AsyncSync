//
//  ContentView.swift
//  AsyncSync
//
//  Created by sako0602 on 2023/03/12.
//

import SwiftUI

struct ContentView: View {
    @State var opacity = 1.0    // 不透明度のステート変数
    @State var isTapped = false   // 非同期的なボタンが押されたかどうか
        
        var body: some View {
            VStack {
                Text("Hello")
                    .foregroundColor(isTapped ? .red : .black)
                    .font(.system(size: 65))
                    .fontWeight(.bold)
                    .opacity(opacity)

                // テキストの不透明度を制御する
                Slider(value: $opacity, in: 0...1) {
                    Text("Opacity")
                }
                // 🟥同期的に5秒を数えるボタン
                Button {
                    sleep(5)
                } label: {
                    Text("Count")
                        .frame(maxWidth: 180, maxHeight: 66)
                }
                .buttonStyle(.bordered)
                // 🟥非同期的に5秒を数えるボタン
                Button {
                    // 非同期的なタスクを作成する
                    Task {
                        // タスクの中は非同期的なコンテキストなので、
                        // 非同期関数を呼び出せる
                        //awaitはコード実行を一時的に停止（サスペンド）する箇所につける
                        try? await Task.sleep(nanoseconds: 5_000_000_000)
                        isTapped.toggle()
                    }
                } label: {
                    Text("Async count")
                        .frame(maxWidth: 180, maxHeight: 66)
                }
                .buttonStyle(.bordered)
            }
        }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
