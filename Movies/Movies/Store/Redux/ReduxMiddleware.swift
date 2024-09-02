public typealias Middleware<State, Action> = (
    @escaping () -> State,
    Action,
    @escaping (Action) -> ()
) -> ()

public protocol MiddlewareProtocol {
    associatedtype State
    associatedtype Action

    var middleware: Middleware<State, Action> { get }
}

public struct GenericMiddleware<State, Action>: MiddlewareProtocol {
    
    public var middleware: Middleware<State, Action>
    
    public init(_ middleware: @escaping Middleware<State, Action>) {
        self.middleware = middleware
    }
}

public struct CompositeMiddleware<State, Action>: MiddlewareProtocol {
    
    public let middleware: Middleware<State, Action>
    
    public init(_ middlewares: Middleware<State, Action>...) {
        let initial: Middleware<State, Action> = { store, action, next in next(action) }
        middleware = middlewares
            .reversed()
            .reduce(initial) { result, middleware in
                { getState, action, next in
                    middleware(getState, action) { action in
                        result(getState, action, next)
                    }
                }
            }
    }
}

public struct TypedMiddleware<State, Action>: MiddlewareProtocol {
    
    public var middleware: Middleware<State, Action>
    
    public init<Cast>(
        to: Cast.Type,
        _ middleware: @escaping (
            @escaping() -> State,
            Cast,
            @escaping (Action) -> Void
        ) -> Void)
    {
        self.middleware = { getState, action, next in
            switch action {
            case let mAction as Cast:
                return middleware(
                    getState,
                    mAction,
                    next
                )
            default:
                return next(action)
            }
        }
    }
}

public struct PartialMiddleware<State, Action>: MiddlewareProtocol {

    public let middleware: Middleware<State, Action>

    public init<T>(of key: WritableKeyPath<State, T>, _ middleware: @escaping Middleware<T, Action>) {
        self.middleware = { state, action, next in
            let partialState: () -> T = { state()[keyPath: key] }
            middleware(partialState, action, next)
        }
    }
}
