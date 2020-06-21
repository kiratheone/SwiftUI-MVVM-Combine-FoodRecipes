//
//  FoodsViewModel.swift
//  foodrecipes
//
//  Created by Arik on 26/05/20.
//  Copyright © 2020 Arik. All rights reserved.
//

import Foundation
import Combine

class FoodsViewModel: ObservableObject {
    @Published private(set) var state: State = .idle
    private let input = PassthroughSubject<Event, Never>()
    
    private var cancellable = Set<AnyCancellable>()
    let repository: FoodsRepository
    
    init(rep :FoodsRepository) {
        self.repository = rep
        
        Publishers.system(
            initial: state,
            reduce: Self.reduce,
            scheduler: RunLoop.main,
            feedbacks: [
                self.loadListFood(),
                self.userInput(input: input.eraseToAnyPublisher())
            ]
        )
        .assignNoRetain(to: \.state, on: self)
        .store(in: &cancellable)
        
        
    }
    
    func send(event: Event) {
        input.send(event)
    }

    
}

extension FoodsViewModel  {
    private func loadListFood() -> Feedback<State, Event>{
        Feedback { (state : State) -> AnyPublisher<Event,Never> in
            guard case .loading = state else {return Empty().eraseToAnyPublisher()}
            return self.repository.getListFoods()
                .map(Event.onLoaded)
                .catch {
                    Just(Event.onFailedToLoad($0))}
                .eraseToAnyPublisher()
        }
    }
    
    private func userInput(input: AnyPublisher<Event, Never>) -> Feedback<State, Event> {
        Feedback(run: { _ in
            print("Input >>> \(input.description)")
            return input
        })
    }
}

extension FoodsViewModel {
    enum State {
        case idle
        case loading
        case loaded([FoodModel])
        case error(Error)
    }
    
    enum Event {
        case onAppear
        case onLoaded([FoodModel])
        case onFailedToLoad(Error)
    }
    
}

extension FoodsViewModel {
    static func reduce(_ state: State, _ event: Event) -> State {
        switch state {
        case .idle:
            switch event {
            case .onAppear:
                return .loading
            default:
                return state
            }
        case .loading:
            switch event {
            case .onFailedToLoad(let error):
                return .error(error)
            case .onLoaded(let listFood):
                return .loaded(listFood)
            default:
                return state
            }
        case .loaded:
            return state
        case .error:
            return state
        }
    }
    
    
}
