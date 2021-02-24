//
//  ViewController.swift
//  Intelico_Test
//
//  Created by Sergey on 2/18/21.
//

import UIKit

class ViewController: UIViewController {
    
    var newLoan = Loan()
    
    let firstPaymentDateOptions = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15"]
    let secondPaymentDateOptions = ["16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30"]
    let paymentDateOptions = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30"]
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var totalAmountLabel: UITextField!
    @IBOutlet weak var lessButton: UIButton!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var totalAmountSlider: UISlider!
    @IBOutlet weak var totalAmountSliderMinValueLabel: UILabel!
    @IBOutlet weak var totalAmountSliderMaxValueLabel: UILabel!
    
    @IBOutlet weak var interestRateTextField: UITextField!
    @IBOutlet weak var periodTextField: UITextField!
    
    @IBOutlet weak var weeklyButton: UIButton!
    @IBOutlet weak var biweeklyButton: UIButton!
    @IBOutlet weak var semimonthlyButton: UIButton!
    @IBOutlet weak var monthlyButton: UIButton!
    
    @IBOutlet weak var suButton: UIButton!
    @IBOutlet weak var moButton: UIButton!
    @IBOutlet weak var tuButton: UIButton!
    @IBOutlet weak var weButton: UIButton!
    @IBOutlet weak var thButton: UIButton!
    @IBOutlet weak var frButton: UIButton!
    @IBOutlet weak var saButton: UIButton!
    
    @IBOutlet weak var firstPaymentDatePickerView: UIPickerView!
    @IBOutlet weak var secondPaymentDatePickerView: UIPickerView!
    @IBOutlet weak var paymentDatePickerView: UIPickerView!
    
    @IBOutlet weak var beforeWeekendButton: UIButton!
    @IBOutlet weak var afterWeekendButton: UIButton!
    
    @IBOutlet weak var dayOfButton: UIButton!
    @IBOutlet weak var oneDayBeforeButton: UIButton!
    @IBOutlet weak var twoDayBeforeButton: UIButton!
    @IBOutlet weak var threeDayBeforeButton: UIButton!
    
    @IBOutlet weak var regularLoanPaymentLabel: UILabel!
    @IBOutlet weak var totalInterestPaybleLabel: UILabel!
    @IBOutlet weak var totalAmountPaybleLabel: UILabel!
    @IBOutlet weak var numberOfPaymentsLabel: UILabel!
    
    @IBOutlet weak var estimatedPayoffDateLabel: UILabel!
    
    @IBOutlet weak var descriptionTextField: UITextField!
    
    @IBOutlet weak var addLoanButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        newLoan.calculation()
        refreshScreenData()
    }
    
    @IBAction func lessMoreButtonPressed(_ sender: UIButton) {
        totalAmountSlider.minimumValue = (sender.tag == 1) ? 0 : 5000
        totalAmountSlider.maximumValue = (sender.tag == 1) ? 5000 : 15000
        
        moreButton.isEnabled = (sender.tag == 1) ? true : false
        lessButton.isEnabled = (sender.tag == 1) ? false : true
        
        totalAmountSliderMinValueLabel.text = (sender.tag == 1) ? "$\(0)" : "$\(5000)"
        totalAmountSliderMaxValueLabel.text = (sender.tag == 1) ? "$\(5000)" : "$\(15000)"
    }
    
    @IBAction func totalAmountSliderChanged(_ sender: UISlider) {
        newLoan.totalAmount = Int(sender.value)
        totalAmountLabel.text = "$ \(newLoan.totalAmount)"
        
        newLoan.calculation()
        refreshScreenData()
    }
    @IBAction func periodPlusMinusButtonPressed(_ sender: UIButton) {
        
        if sender.tag == 2 && newLoan.period == 36 {
            return
        } else if sender.tag == 1 && newLoan.period == 1 {
            return
        }
        
        newLoan.period += (sender.tag == 1) ? -1 : 1
        periodTextField.text = "\(newLoan.period)"
        
        newLoan.calculation()
        refreshScreenData()
    }
    
    @IBAction func payFrequencyButtonPressed(_ sender: UIButton) {
        weeklyButton.layer.borderWidth = (sender.tag == 1) ? 1 : 0
        biweeklyButton.layer.borderWidth = (sender.tag == 2) ? 1 : 0
        semimonthlyButton.layer.borderWidth = (sender.tag == 3) ? 1 : 0
        monthlyButton.layer.borderWidth = (sender.tag == 4) ? 1 : 0
        
        switch sender.tag {
        case 1:
            newLoan.payFrequency = 52
        case 2:
            newLoan.payFrequency = 26
        case 3:
            newLoan.payFrequency = 24
        case 4:
            newLoan.payFrequency = 12
        default:
            return
        }
        
        suButton.isEnabled = (sender.tag == 1 || sender.tag == 2)
        moButton.isEnabled = (sender.tag == 1 || sender.tag == 2)
        tuButton.isEnabled = (sender.tag == 1 || sender.tag == 2)
        weButton.isEnabled = (sender.tag == 1 || sender.tag == 2)
        thButton.isEnabled = (sender.tag == 1 || sender.tag == 2)
        frButton.isEnabled = (sender.tag == 1 || sender.tag == 2)
        saButton.isEnabled = (sender.tag == 1 || sender.tag == 2)
        
        firstPaymentDatePickerView.isUserInteractionEnabled = (sender.tag == 3)
        secondPaymentDatePickerView.isUserInteractionEnabled = (sender.tag == 3)
        paymentDatePickerView.isUserInteractionEnabled = (sender.tag == 4)

        newLoan.calculation()
        refreshScreenData()
    }
    
    @IBAction func dayOfPaymentButtonPressed(_ sender: UIButton) {
        suButton.layer.borderWidth = (sender.tag == 1) ? 1 : 0
        moButton.layer.borderWidth = (sender.tag == 2) ? 1 : 0
        tuButton.layer.borderWidth = (sender.tag == 3) ? 1 : 0
        weButton.layer.borderWidth = (sender.tag == 4) ? 1 : 0
        thButton.layer.borderWidth = (sender.tag == 5) ? 1 : 0
        frButton.layer.borderWidth = (sender.tag == 6) ? 1 : 0
        saButton.layer.borderWidth = (sender.tag == 7) ? 1 : 0
        
        newLoan.calculation()
        refreshScreenData()
    }
    
    @IBAction func weekendButtonPressed(_ sender: UIButton) {
        beforeWeekendButton.layer.borderWidth = (sender.tag == 1 && beforeWeekendButton.isSelected == false) ? 1 : 0
        beforeWeekendButton.isSelected = (sender.tag == 1 && beforeWeekendButton.isSelected == false)
        
        afterWeekendButton.layer.borderWidth = (sender.tag == 2 && afterWeekendButton.isSelected == false) ? 1 : 0
        afterWeekendButton.isSelected = (sender.tag == 2 && afterWeekendButton.isSelected == false)
    }
    
    @IBAction func paymentReminderSwitchSelected(_ sender: UISwitch) {
        dayOfButton.isEnabled = sender.isOn
        oneDayBeforeButton.isEnabled = sender.isOn
        twoDayBeforeButton.isEnabled = sender.isOn
        
        dayOfButton.layer.borderWidth = 0
        oneDayBeforeButton.layer.borderWidth = 0
        twoDayBeforeButton.layer.borderWidth = 0
        threeDayBeforeButton.layer.borderWidth = 0
    }
    @IBAction func paymentReminderButtonPressed(_ sender: UIButton) {
        dayOfButton.layer.borderWidth = (sender.tag == 4) ? 1 : 0
        oneDayBeforeButton.layer.borderWidth = (sender.tag == 1) ? 1 : 0
        twoDayBeforeButton.layer.borderWidth = (sender.tag == 2) ? 1 : 0
        threeDayBeforeButton.layer.borderWidth = (sender.tag == 3) ? 1 : 0

        newLoan.calculation()
        refreshScreenData()
    }
    
    func refreshScreenData() {
        regularLoanPaymentLabel.text = "$ " + String(format: "%.2f", newLoan.regularLoanPayments)
        totalInterestPaybleLabel.text = "$ " + String(format: "%.2f", newLoan.totalInterestPayble)
        totalAmountPaybleLabel.text = "$ " + String(format: "%.2f", newLoan.totalAmountPayble)
        numberOfPaymentsLabel.text = String(format: "%.2f", newLoan.numberOfPayments)
    }
    
    func setupUI() {
        lessButton.isEnabled = false
        totalAmountSlider.minimumValue = 0
        totalAmountSlider.maximumValue = 5000
        totalAmountSlider.value = 1000
        
        interestRateTextField.delegate = self
        
        weeklyButton.layer.borderColor = UIColor.blue.cgColor
        weeklyButton.layer.borderWidth = 0
        biweeklyButton.layer.borderColor = UIColor.blue.cgColor
        biweeklyButton.layer.borderWidth = 0
        semimonthlyButton.layer.borderColor = UIColor.blue.cgColor
        semimonthlyButton.layer.borderWidth = 0
        monthlyButton.layer.borderColor = UIColor.blue.cgColor
        monthlyButton.layer.borderWidth = 1
        
        suButton.layer.borderColor = UIColor.blue.cgColor
        suButton.layer.borderWidth = 0
        moButton.layer.borderColor = UIColor.blue.cgColor
        moButton.layer.borderWidth = 0
        tuButton.layer.borderColor = UIColor.blue.cgColor
        tuButton.layer.borderWidth = 0
        weButton.layer.borderColor = UIColor.blue.cgColor
        weButton.layer.borderWidth = 1
        thButton.layer.borderColor = UIColor.blue.cgColor
        thButton.layer.borderWidth = 0
        frButton.layer.borderColor = UIColor.blue.cgColor
        frButton.layer.borderWidth = 0
        saButton.layer.borderColor = UIColor.blue.cgColor
        saButton.layer.borderWidth = 0
        
        firstPaymentDatePickerView.delegate = self
        firstPaymentDatePickerView.dataSource = self
        secondPaymentDatePickerView.delegate = self
        secondPaymentDatePickerView.dataSource = self
        paymentDatePickerView.delegate = self
        paymentDatePickerView.dataSource = self
        
        firstPaymentDatePickerView.tag = 1
        secondPaymentDatePickerView.tag = 2
        paymentDatePickerView.tag = 3
        
        firstPaymentDatePickerView.selectRow(9, inComponent: 0, animated: true)
        secondPaymentDatePickerView.selectRow(9, inComponent: 0, animated: true)
        paymentDatePickerView.selectRow(24, inComponent: 0, animated: true)
        
        firstPaymentDatePickerView.isUserInteractionEnabled = false
        
        beforeWeekendButton.layer.borderColor = UIColor.blue.cgColor
        beforeWeekendButton.layer.borderWidth = 0
        afterWeekendButton.layer.borderColor = UIColor.blue.cgColor
        afterWeekendButton.layer.borderWidth = 0
        
        dayOfButton.isEnabled = false
        oneDayBeforeButton.isEnabled = false
        twoDayBeforeButton.isEnabled = false
        threeDayBeforeButton.isEnabled = false
        dayOfButton.layer.borderWidth = 0
        oneDayBeforeButton.layer.borderWidth = 0
        twoDayBeforeButton.layer.borderWidth = 0
        threeDayBeforeButton.layer.borderWidth = 0
        dayOfButton.layer.borderColor = UIColor.blue.cgColor
        oneDayBeforeButton.layer.borderColor = UIColor.blue.cgColor
        twoDayBeforeButton.layer.borderColor = UIColor.blue.cgColor
        threeDayBeforeButton.layer.borderColor = UIColor.blue.cgColor
        
        addLoanButton.layer.cornerRadius = 25
    }
}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in firstPaymentDatePickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return firstPaymentDateOptions.count
        case 2:
            return secondPaymentDateOptions.count
        case 3:
            return paymentDateOptions.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return firstPaymentDateOptions[row]
        case 2:
            return secondPaymentDateOptions[row]
        case 3:
            return paymentDateOptions[row]
        default:
            return ""
        }
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        guard textField == interestRateTextField else { return false }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == interestRateTextField {
            self.interestRateTextField.resignFirstResponder()
            newLoan.interestRate = Double(textField.text!)!
            newLoan.calculation()
            refreshScreenData()
        }
        return true
    }
}

