//
//  BankManagerUIApp - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {
    
    let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    let addButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("고객 10명 추가", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    
    let clearButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("초기화", for: .normal)
        button.setTitleColor(.red, for: .normal)
        return button
    }()
    
    let timerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        return stackView
    }()
    
    let timerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "업무시간 - 00:00:000"
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.textAlignment = .center
        return label
    }()
    
    let queueStateStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    let waitingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "대기중"
        label.textColor = .white
        label.backgroundColor = .systemGreen
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        label.textAlignment = .center
        return label
    }()
    
    let processingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "업무중"
        label.textColor = .white
        label.backgroundColor = .systemIndigo
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        label.textAlignment = .center
        return label
    }()
    
    let queueStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    let waitingScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let waitingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 8
        return stackView
    }()
    
    let processingScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let processingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 8
        return stackView
    }()
    
    let depositLabel2: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0-예금"
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        return label
    }()
    
    let loanLabel2: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0-대출"
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.textColor = .systemPurple
        return label
    }()
    
    let customerQueue = CustomerQueue<Customer>()
    var kbBank: Bank?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubview()
        setupUIConstraints()
        
        addButton.addTarget(self, action: #selector(addTenCustomerButton), for: .touchUpInside)
        clearButton.addTarget(self, action: #selector(allClearButton), for: .touchUpInside)
        
        kbBank = Bank(customerQueue: customerQueue)
    }
    
    @objc func addTenCustomerButton(sender: UIButton) {
        waitingStackView.subviews.forEach { $0.removeFromSuperview() }
        kbBank?.addTenCustomer()
        displayWaitingCustomers()
        kbBank?.allocateCustomer()
    }
    
    @objc func allClearButton(sender: UIButton) {
        kbBank?.resetAll()
        for view in waitingStackView.subviews {
            view.removeFromSuperview()
        }
        for view in processingStackView.subviews {
            view.removeFromSuperview()
        }
        timerLabel.text = "업무시간 - 00:00:000"
    }
    
    private func displayWaitingCustomers() {
        guard let customers = kbBank?.customerQueue.takeAll() else { return }
        customers.forEach { customer in
            guard let customer = customer else { return }
            waitingStackView.addArrangedSubview(makeCustomerLabel(customer: customer))
        }
    }
    
    private func makeCustomerLabel(customer: Customer) -> UILabel {
        let customerLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "\(customer.waitingNumber)-\(customer.requestingTask.name)"
            label.font = UIFont.preferredFont(forTextStyle: .title2)
            if customer.requestingTask == .loan {
                label.textColor = .systemPurple
            }
            return label
        }()
        return customerLabel
    }
    
    private func addSubview() {
        self.view.addSubview(mainStackView)
        mainStackView.addArrangedSubview(buttonStackView)
        mainStackView.addArrangedSubview(timerStackView)
        mainStackView.addArrangedSubview(queueStateStackView)
        mainStackView.addArrangedSubview(queueStackView)
        
        buttonStackView.addArrangedSubview(addButton)
        buttonStackView.addArrangedSubview(clearButton)
        
        timerStackView.addArrangedSubview(timerLabel)
        
        queueStateStackView.addArrangedSubview(waitingLabel)
        queueStateStackView.addArrangedSubview(processingLabel)
        
        queueStackView.addArrangedSubview(waitingScrollView)
        queueStackView.addArrangedSubview(processingScrollView)
        
        waitingScrollView.addSubview(waitingStackView)
        
        processingScrollView.addSubview(processingStackView)
        processingStackView.addArrangedSubview(depositLabel2)
        processingStackView.addArrangedSubview(loanLabel2)
    }
    
    private func setupUIConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            waitingStackView.topAnchor.constraint(equalTo: waitingScrollView.contentLayoutGuide.topAnchor),
            waitingStackView.leadingAnchor.constraint(equalTo: waitingScrollView.contentLayoutGuide.leadingAnchor),
            waitingStackView.trailingAnchor.constraint(equalTo: waitingScrollView.contentLayoutGuide.trailingAnchor),
            waitingStackView.bottomAnchor.constraint(equalTo: waitingScrollView.contentLayoutGuide.bottomAnchor),
            waitingStackView.widthAnchor.constraint(equalTo: waitingScrollView.frameLayoutGuide.widthAnchor),
            processingStackView.topAnchor.constraint(equalTo: processingScrollView.contentLayoutGuide.topAnchor),
            processingStackView.leadingAnchor.constraint(equalTo: processingScrollView.contentLayoutGuide.leadingAnchor),
            processingStackView.trailingAnchor.constraint(equalTo: processingScrollView.contentLayoutGuide.trailingAnchor),
            processingStackView.bottomAnchor.constraint(equalTo: processingScrollView.contentLayoutGuide.bottomAnchor),
            processingStackView.widthAnchor.constraint(equalTo: processingScrollView.frameLayoutGuide.widthAnchor)
        ])
    }
}
