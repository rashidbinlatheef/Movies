import Combine
import Foundation

@available(iOS 13.0, *)
extension Store {
    public var publisher: AnyPublisher<State, Never> {
        let subject = PassthroughSubject<State, Never>()
        _ = addObserver(callback: { [weak subject] value in subject?.send(value) })
        return subject.eraseToAnyPublisher()
    }
}
