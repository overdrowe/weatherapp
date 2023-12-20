import Foundation
import UIKit

extension UIView {

	/// Добавляет в текущее вью несколько дочерних сабвью
	/// - Parameter subviews: Добавляемые сабвью
	public func addSubviews(_ subviews: UIView...) {
		addSubviews(subviews)
	}

	// TODO: Сделать public после удаления одноимённого метода из UIComponents в ГУ
	/// Добавляет в текущее вью несколько дочерних сабвью
	/// - Parameter subviews: Добавляемые сабвью
	func addSubviews(_ subviews: [UIView]) {
		subviews.forEach(addSubview)
	}
}

