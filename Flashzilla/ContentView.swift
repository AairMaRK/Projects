//
//  ContentView.swift
//  Flashzilla
//
//  Created by Egor Gryadunov on 26.08.2021.
//

import SwiftUI

struct ContentView: View
{
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityEnabled) var accessibilityEnabled
    
    @State private var cards = [Card]()
    
    @State private var isActive = true
    @State private var timeRemaining = 100
    
    @State private var showingSheet = false
    
    @State private var initialCardsCount = 0
    @State private var correctCards = 0
    @State private var incorrectCards = 0
    
    private var reviewedCards: Int {
        correctCards + incorrectCards
    }
    let haptics = Haptics()
    
    @State private var retryIncorrectCards = false
    @State private var sheetType = SheetType.editCards
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    static let initialTimerValue = 100
    static let maxTimerDigits = String(Self.initialTimerValue).count
    
    var body: some View {
        ZStack {
            Image(decorative: "background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Time: \(timeRemaining)")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(
                        Capsule()
                            .fill(Color.black)
                            .opacity(0.75)
                    )
                
                ZStack {
                    ForEach(cards) { card in
                        CardView(card: card, retryIncorrectCards: self.retryIncorrectCards) { isCorrect in
                            if isCorrect {
                                self.correctCards += 1
                            } else {
                                self.incorrectCards += 1
    
                                if self.retryIncorrectCards {
                                    self.restackCard(at: self.index(for: card))
                                    return
                                }
                            }

                            withAnimation {
                                self.removeCard(at: self.index(for: card))
                            }
                        }
                        .stacked(at: self.index(for: card), in: self.cards.count)
                        .allowsHitTesting(self.index(for: card) == self.cards.count - 1)
                        .accessibility(hidden: self.index(for: card) < self.cards.count - 1)
                    }
                }
                .allowsHitTesting(timeRemaining > 0)
                
                if timeRemaining == 0 || !isActive {
                    RestartView(retryIncorrectCards: retryIncorrectCards, initialCardsCount: initialCardsCount, reviewedCards: reviewedCards, correctCards: correctCards, incorrectCards: incorrectCards, restartAction: resetCards)
                        .frame(width: 300, height: 200)
                }
            }
            
            VStack {
                HStack {
                    ActionButton(systemImage: "gear") {
                        self.showSheet(type: .settings)
                    }
                    Spacer()
                }
                Spacer()
            }
            .padding()
            
            VStack {
                HStack {
                    Spacer()
                    ActionButton(systemImage: "plus.circle") {
                        self.showSheet(type: .editCards)
                    }
                }
                Spacer()
            }
            .padding()
            
            if (differentiateWithoutColor || accessibilityEnabled) &&
                            timeRemaining > 0 && isActive {
                VStack {
                    Spacer()
                    HStack {
                        ActionButton(systemImage: "xmark.circle") {
                            self.incorrectCards += 1
                            if self.retryIncorrectCards {
                                self.restackCard(at: self.cards.count - 1)
                                return
                            }
                             
                            withAnimation {
                                self.removeCard(at: self.cards.count - 1)
                            }
                        }
                        .accessibility(label: Text("Wrong"))
                        .accessibility(hint: Text("Mark your answer as being incorrect."))

                        Spacer()

                        ActionButton(systemImage: "checkmark.circle") {
                            withAnimation {
                                self.removeCard(at: self.cards.count - 1)
                                self.correctCards += 1
                            }
                        }
                        .accessibility(label: Text("Correct"))
                        .accessibility(hint: Text("Mark your answer as being correct."))
                    }
                    .padding()
                }
            }
        }
        .sheet(isPresented: $showingSheet, onDismiss: resetCards) {
            if self.sheetType == .editCards {
                EditCards()
            } else if self.sheetType == .settings {
                SettingsView(retryIncorrectCards: self.$retryIncorrectCards)
            }
        }
        .onAppear(perform: resetCards)
        .onReceive(timer) { time in
            guard self.isActive else { return }

            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
                        
                if self.timeRemaining == 2 {
                    self.haptics.prepare()
                } else if self.timeRemaining == 0 {
                    self.haptics.playEnding()
                }
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
            self.isActive = false
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            if self.cards.isEmpty == false {
                self.isActive = true
            }
        }
    }
    
    private func removeCard(at index: Int) {
        guard index >= 0 else { return }

        cards.remove(at: index)

        if cards.count == 1 { haptics.prepare() }

        if cards.isEmpty {
            isActive = false
            haptics.playEnding()
        }
    }
    
    private func restackCard(at index: Int) {
        guard index >= 0 else { return }

        let card = cards[index]
        cards.remove(at: index)
        cards.insert(card, at: 0)
    }
    
    private func resetCards() {
        timeRemaining = 100
        isActive = true
        loadData()
    }
    
    private func loadData() {
        if let data = UserDefaults.standard.data(forKey: "Cards") {
            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                self.cards = decoded

                self.initialCardsCount = cards.count
                self.correctCards = 0
                self.incorrectCards = 0
                if cards.count == 1 {
                    self.haptics.prepare()
                }
            }
        }
    }
    
    private func index(for card: Card) -> Int {
        return cards.firstIndex(where: { $0.id == card.id }) ?? 0
    }

    private func showSheet(type: SheetType) {
        self.sheetType = type
        self.showingSheet = true
    }
    
    enum SheetType { case editCards, settings }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension View
{
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = CGFloat(total - position)
        return self.offset(CGSize(width: 0, height: offset * 10))
    }
}
