import RxSwift

@propertyWrapper
public struct RxPublished<Value> {
	private let subject: BehaviorSubject<Value>
	
	public var wrappedValue: Value { didSet { subject.onNext(wrappedValue) } }
	public var projectedValue: Observable<Value> { subject.asObservable() }
	
	public init(wrappedValue: Value) {
		self.wrappedValue = wrappedValue
		self.subject = BehaviorSubject(value: wrappedValue)
	}
}
