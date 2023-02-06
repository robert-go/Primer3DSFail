//
//  ViewController.swift
//  Primer3DSFail
//
//  Created by Golden Owl on 06/02/2023.
//

import PrimerSDK

import UIKit

class ViewController: UIViewController {
    lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Checkout", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.setTitleColor(.black, for: .selected)
        button.backgroundColor = .systemBackground
        button.addTarget(self, action: #selector(checkout), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        Primer.shared.configure(delegate: self)
    }

    func setup() {
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.widthAnchor.constraint(equalToConstant: 200),
            button.heightAnchor.constraint(equalToConstant: 70),
        ])
    }

    @objc func checkout() {
        getClientToken { token, error in
            if let error = error {
                print("error", error)
                return
            }
            if let clientToken = token {
                print("clientToken", clientToken)
                Primer.shared.showPaymentMethod(
                    "PAYMENT_CARD",
                    withIntent: .checkout,
                    andClientToken: clientToken
                )
            }
        }
    }

    func getClientToken(_ completion: @escaping (String?, Error?) -> Void) {
        let parameters = "{\"\":\"\"}"
        let postData = parameters.data(using: .utf8)

        var request = URLRequest(url: URL(string: "https://staging-consumer-api.pacenow.co/v1/api/getClientToken")!, timeoutInterval: Double.infinity)
        request.addValue("staging-consumer-api.pacenow.co", forHTTPHeaderField: "Host")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("184AD543-9101-4C43-8431-CAC39E9D4092", forHTTPHeaderField: "X-Pace-Deviceid")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("SG", forHTTPHeaderField: "X-Pace-Location-Id")
        request.addValue("qnjkzucvcesyzbwuthxvub", forHTTPHeaderField: "X-Pace-Sessionid")
        request.addValue("co.pacenow.internal.sit", forHTTPHeaderField: "X-Pace-Appid")
        request.addValue("consumerapp", forHTTPHeaderField: "X-Pace-Clientid")
        request.addValue("vi-VN,vi;q=0.9", forHTTPHeaderField: "Accept-Language")
        request.addValue("{\"osBuildId\":\"65\",\"modelId\":\"iPhone\",\"gitSha\":\"\",\"appId\":\"co.pacenow.internal.sit\",\"deviceType\":\"ios\",\"modelName\":\"iPhone 14 Pro Max\",\"osName\":\"iOS\",\"deviceName\":\"iPhone 14 Pro Max\",\"version\":\"2.5.0\",\"buildVersion\":\"1\",\"osVersion\":\"16.1\"}", forHTTPHeaderField: "X-Pace-Metadata")
        request.addValue("gzip, deflate", forHTTPHeaderField: "Accept-Encoding")
        request.addValue("7", forHTTPHeaderField: "Content-Length")
        request.addValue("Phoenix_iOS/1 CFNetwork/1399 Darwin/22.2.0", forHTTPHeaderField: "User-Agent")
        request.addValue("338425d50db94f22aee78e079c5bd9ec7e4ae416", forHTTPHeaderField: "X-Pace-Clienttoken")

        request.httpMethod = "POST"
        request.httpBody = postData

        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data else {
                print(String(describing: error))
                completion(nil, error)
                return
            }
            if let token = String(data: data, encoding: .utf8) {
                completion(token, nil)
            }
        }

        task.resume()
    }
}

extension ViewController: PrimerDelegate {
    func primerDidCompleteCheckoutWithData(_ data: PrimerSDK.PrimerCheckoutData) {
        print(data)
    }
}
