public typealias Reducer<State, Action> = (State, Action) -> State

public protocol ReducerProtocol {
    associatedtype Action
    associatedtype State
    
    var reduce: Reducer<State, Action> { get }
}

public struct CompositeReducer<State, Action>: ReducerProtocol {
    
    public let reduce: Reducer<State, Action>
    
    public init(_ reducers: Reducer<State, Action>...) {
        self.reduce = { state, action in
            reducers.reduce(state) { (newState, reducer) in reducer(newState, action) }
        }
    }
}

public struct TypedReducer<State, Action>: ReducerProtocol {
    
    public let reduce: Reducer<State, Action>
    
    public init<A>(_ reducer: @escaping Reducer<State, A>) {
        self.reduce = { state, action in
            switch action {
            case let action as A:
                return reducer(state, action)
            default:
                return state
            }
        }
    }
    
    public static func `inout`<A>(
        _ reducer: @escaping (inout State, A) -> Void
    ) -> TypedReducer<State, Action> {
        
        let classic: Reducer<State, A> = { state, action in
            var state = state
            reducer(&state, action)
            return state
        }
        
        return .init(classic)
    }
}

public struct PartialReducer<State, Action>: ReducerProtocol {
    
    public let reduce: Reducer<State, Action>
    
    public init<T>(of key: WritableKeyPath<State, T>, _ reduce: @escaping Reducer<T, Action>) {
        self.reduce = { state, action in
            var state = state
            state[keyPath: key] = reduce(state[keyPath: key], action)
            return state
        }
    }
}
