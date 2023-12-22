import Foundation
import UIKit

open class BaseView: UIView {
	public init() {
		super.init(frame: .zero)
		
		prepareView()
		addSubviews()
		makeConstraints()
		configure()
	}

	public override init(frame: CGRect) {
		super.init(frame: frame)
		
		prepareView()
		addSubviews()
		makeConstraints()
		configure()
	}

	public required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	open func prepareView() {}
	open func addSubviews() {}
	open func makeConstraints() {}
	open func configure() {}
}

