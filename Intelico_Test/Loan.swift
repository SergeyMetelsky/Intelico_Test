//
//  Loan.swift
//  Intelico_Test
//
//  Created by Sergey on 2/23/21.
//

import Foundation

struct Loan {
    var loanName: String = ""
    var totalAmount: Int = 1000
    var interestRate: Double = 0
    var period: Int = 12
    var payFrequency: Double = 12
    var dayOfPayment: String = "Su"
    var firstPaymentDate: Int = 10
    var secondPaymentDate: Int = 25
    var paymentDate: Int = 25
    
    var regularLoanPayments: Double = 0
    var totalInterestPayble: Double = 0
    var totalAmountPayble: Double = 0
    var numberOfPayments: Double = 0
    var estimatedPayoffDate: Double = 0
    
    mutating func calculation() {
        let n = (payFrequency / (12 / Double(period)))
        numberOfPayments = n.rounded(.up)
        
        if interestRate == 0 {
            regularLoanPayments = Double(totalAmount) / numberOfPayments
            totalAmountPayble = Double(totalAmount)
            totalInterestPayble = 0
        } else {
            let i = interestRate / payFrequency / 100
            
            let k = (i * pow(1 + i, numberOfPayments)) / (pow(1 + i, numberOfPayments) - 1)
            
            regularLoanPayments = k * Double(totalAmount)
            totalAmountPayble = regularLoanPayments * numberOfPayments
            totalInterestPayble = totalAmountPayble - Double(totalAmount)
        }
    }
}
