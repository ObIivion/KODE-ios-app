import UIKit

class BaseView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup() // эта штука вызывается если класс создан не из кода, а через сториборд
    }
    
    func setup() {
        // пустой метод, который я буду оверрайдить
    }
}
