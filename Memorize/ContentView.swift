//
//  ContentView.swift
//  Memorize
//
//  Created by Mike Putnam on 4/11/25.
//

import SwiftUI

struct ContentView: View {
    @State var cardCount: Int = 4
    let emojis: Array<String> = ["😈","🎃","💀","👻","👽","😺","🧞‍♂️","🕷️"]
    var body: some View {
        VStack{
            ScrollView{
                cards
            }
            Spacer()
            cardCountAdjusters
        }.padding()
    }

    var cards : some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
            ForEach(0..<cardCount, id: \.self) { index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }.foregroundColor(.orange)
    }
    var cardCountAdjusters: some View {
        HStack {
            cardRemover
            Spacer()
            carAdder
            
        }
    }
    
    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
        Button(action: {
            cardCount += offset
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(cardCount + offset < 1 ||
                  cardCount + offset > emojis.count )
    }
               
    var cardRemover : some View {
        return cardCountAdjuster(by: -1, symbol: "minus.circle")
    }
    
    var carAdder : some View {
        return cardCountAdjuster(by: +1, symbol: "plus.circle")
    }
}

struct CardView : View {
    let content: String
    @State var isFaceUp = false
    var body: some View{
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }.opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
                
        }.onTapGesture {
            isFaceUp.toggle();
        }
    }
}
#Preview {
    ContentView()
}
