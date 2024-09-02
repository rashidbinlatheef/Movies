/// This protocol represent an ability to dispatch different things to redux store.
public protocol Dispatcher {
    associatedtype Action
    func dispatch(action: Action)
    func dispatchActions(actions: [Action])
}
