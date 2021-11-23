//
// Copyright (c) 2021 Adyen N.V.
//
// This file is open source and available under the MIT license. See the LICENSE file for more info.
//

import Adyen
import Foundation

// TODO: - Complete documentation

internal protocol BACSDirectDebitRouterProtocol {
    func continuePayment(data: BACSDirectDebitData)
}

public final class BACSDirectDebitComponent: PaymentComponent, PresentableComponent {

    // MARK: - PresentableComponent

    // TODO: - Set up view controller
    public var viewController: UIViewController {
        navigationController
    }

    private let navigationController: UINavigationController

    public var requiresModalPresentation: Bool = true
    
    // TODO: - Set up delegate
    public weak var delegate: PaymentComponentDelegate?

    public let paymentMethod: PaymentMethod
    public let apiContext: APIContext
    public let style: FormComponentStyle
    public var localizationParameters: LocalizationParameters?

    // MARK: - Initializers

    public init(paymentMethod: BACSDirectDebitPaymentMethod,
                apiContext: APIContext,
                style: FormComponentStyle = .init(),
                localizationParameters: LocalizationParameters? = nil) {
        self.paymentMethod = paymentMethod
        self.apiContext = apiContext
        self.style = style
        self.localizationParameters = localizationParameters

        let view = BACSDirectDebitInputFormView(title: paymentMethod.name,
                                                styleProvider: style)

        // TODO: - Set navigation controller
        self.navigationController = UINavigationController(rootViewController: view as UIViewController)

        let itemsFactory = BACSDirectDebitItemsFactory(styleProvider: style,
                                                       localizationParameters: localizationParameters,
                                                       scope: self)
        let presenter = BACSDirectDebitPresenter(view: view,
                                                 router: self,
                                                 itemsFactory: itemsFactory)
        view.presenter = presenter
    }
}

extension BACSDirectDebitComponent: BACSDirectDebitRouterProtocol {

    func continuePayment(data: BACSDirectDebitData) {
        // TODO: - Continue payment
        print("PAYMENT: \(data)")

        let confirmationView = UIViewController()
        confirmationView.title = "Confirmation View"
        confirmationView.view.backgroundColor = UIColor(red: 0.19, green: 0.84, blue: 0.78, alpha: 1.00)
        navigationController.pushViewController(confirmationView, animated: true)
    }
}
